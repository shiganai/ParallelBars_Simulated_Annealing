if ~exist('ifsave','var')
    ifsave = false;
end

load('Para_0520085816_pop_2400_gen_8225_Anneal')

index_Start = 1501; %1ÇæÇ∆ç≈èâÇ©ÇÁÅB

ExtreamPoint = Para.ExtreamPoint;
ExtreamPoint_num = Para.ExtreamPoint_num;
ObjectiveValueDatas = Para.ObjectiveValueDatas;

% ExtreamPoint = Para.ExtreamPoint(:,:,:, index_Start:end);
% ExtreamPoint_num = Para.ExtreamPoint_num(index_Start:end,:);
% ObjectiveValueDatas = Para.ObjectiveValueDatas(index_Start:end,:);

% ExtreamPoint = flip(Para.midterm_elitest_ExtreamPoint,4);
% ExtreamPoint_num = flip(Para.midterm_elitest_ExtreamPoint_num,1);
% ObjectiveValueDatas = flip(Para.midterm_elitest_ObjectiveValueDatas,1);

constants = Para.constants;

g = constants.g;
kPB = constants.kPB;
cPB = constants.cPB;
mAll = constants.mAll;
mPB = constants.mPB;
rAll = constants.rAll;
mArm = constants.mArm;
mBody = constants.mBody;
mLeg = constants.mLeg;
rArm = constants.rArm;
rBody = constants.rBody;
rLeg = constants.rLeg;
thHand_MaxTorque = constants.thHand_MaxTorque;
thShoulder_MaxTorque = constants.thShoulder_MaxTorque;
thWaist_MaxTorque = constants.thWaist_MaxTorque;
InertiaModel = constants.InertiaModel;
rArmMCD = constants.rArmMCD;
rBodyMCD = constants.rBodyMCD;
rLegMCD = constants.rLegMCD;
InertiaArm = constants.InertiaArm;
InertiaBody = constants.InertiaBody;
InertiaLeg = constants.InertiaLeg;
InertiaG = constants.InertiaG;


t = Para.odeTime;
q0 = Para.q0;
odeEvent = Para.odeEvent;
absTol = Para.absTol;

dthHand_ExtreamPoint = ExtreamPoint(:,:,1,:);
dthShoulder_ExtreamPoint = ExtreamPoint(:,:,2,:);
dthWaist_ExtreamPoint = ExtreamPoint(:,:,3,:);

PerformedWell_num = size(find(~isnan(ObjectiveValueDatas(:,2))),1);
ObjectiveValueDatas = ObjectiveValueDatas(1:PerformedWell_num,:);

MinThHand = zeros([PerformedWell_num, 1]);
MaxDthShoulder = zeros([PerformedWell_num, 1]);
MinThWaist = zeros([PerformedWell_num, 1]);

thWaist_AtBodyUpStraight = zeros([PerformedWell_num, 1]);

thBodyDifference = zeros([PerformedWell_num, 1]);

time_AtBodyUpStraight = zeros([PerformedWell_num, 1]);
time_AtMinThWaist = zeros([PerformedWell_num, 1]);

tic
parfor index = 1:PerformedWell_num
    
    ddthHand_pp = fnder(GetdthTH_pp(dthHand_ExtreamPoint(1:ExtreamPoint_num(index,1),:,:,index)));
    ddthShoulder_pp = fnder(GetdthTH_pp(dthShoulder_ExtreamPoint(1:ExtreamPoint_num(index,2),:,:,index)));
    ddthWaist_pp = fnder(GetdthTH_pp(dthWaist_ExtreamPoint(1:ExtreamPoint_num(index,3),:,:,index)));
    
    
    ddpp_time_histories = [ddthHand_pp, ddthShoulder_pp, ddthWaist_pp]';
    ode = @(t, q) ddt_Realization(t, q, constants, ddpp_time_histories);
    eventFcn = @(t,q)odeEvent(t,q,ddpp_time_histories);
    
    odeOption = odeset('Events', eventFcn, 'AbsTol', absTol);
    
    [time_onbar, q, te, ye, ie] = ode45(ode, t, q0, odeOption);
    time = time_onbar;
    
    if ~isempty(ie)
        breakNum = ie(end);
    else
        breakNum = 0;
    end
    ObjectiveValueData = ObjectiveFcn(time_onbar, q, constants, breakNum);
%     DispObjectiveValueData(ObjectiveValueData, 0)
    
    rPB = q(:,1);
    thHand = q(:,2);
    thShoulder = q(:,3);
    thWaist = q(:,4);
    drPB = q(:,5);
    dthHand = q(:,6);
    dthShoulder = q(:,7);
    dthWaist = q(:,8);
    
    MinThHand(index,1) = min(thHand);
    MaxDthShoulder(index,1) = max(dthShoulder);
    [MinThWaist(index,1), index_AtMinThWaist] = min(thWaist);
    
    time_AtMinThWaist(index, 1) = time(index_AtMinThWaist,1);
    
    time_AtBodyUpStraight(index, 1) = interp1(thHand+1/2*pi + thShoulder, time, 3/2*pi);
    thWaist_AtBodyUpStraight(index, 1) = interp1(time, thWaist, time_AtBodyUpStraight(index, 1));
    
    thBodyDifference(index, 1) = thHand(index_AtMinThWaist,1)+1/2*pi + thShoulder(index_AtMinThWaist,1) - 3/2*pi;
    
    %{
    yHand = rPB(:,1);
    xHand = zeros(size(yHand));
    dyHand = drPB(:,1);
    dxHand = zeros(size(dyHand));
    
    ddrPB = ppval(fnder(spline(time_onbar, drPB)), time_onbar);
    ddthHand = ppval(fnder(spline(time_onbar, dthHand)), time_onbar);
    ddthShoulder = ppval(fnder(spline(time_onbar, dthShoulder)), time_onbar);
    ddthWaist = ppval(fnder(spline(time_onbar, dthWaist)), time_onbar);
    
    MrPB = find_MrPB(ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,kPB,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,rPB,thHand,thShoulder,thWaist);
    MthHand = find_MthHand(InertiaLeg,InertiaArm,InertiaBody,ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
    MthShoulder = find_MthShoulder(InertiaLeg,InertiaBody,ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,mBody,mLeg,rArm,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
    MthWaist = find_MthWaist(InertiaLeg,ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthShoulder,g,mLeg,rArm,rBody,rLegMCD,thHand,thShoulder,thWaist);
    
    KE = find_KE(InertiaLeg,InertiaArm,InertiaBody,dthHand,dthWaist,dthShoulder,dxHand,dyHand,g,kPB,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist,yHand);
    % dKE = find_dKE(InertiaLeg,InertiaArm,InertiaBody,ddthHand,ddthWaist,ddthShoulder,ddxHand,ddyHand,dthHand,dthWaist,dthShoulder,dxHand,dyHand,g,kPB,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist,yHand);
    dKE = ppval(fnder(spline(time_onbar, KE)), time_onbar);
    
    pHand = [xHand, yHand];
    pShoulder = pHand + rArm * [cos(thHand+1/2*pi), sin(thHand+1/2*pi)];
    pWaist = pShoulder + rBody * [cos(thHand+1/2*pi + thShoulder), sin(thHand+1/2*pi + thShoulder)];
    pToe = pWaist + rLeg * [cos(thHand+1/2*pi + thShoulder + thWaist), sin(thHand+1/2*pi + thShoulder + thWaist)];
    
    vHand = [dxHand, dyHand];
    vShoulder = vHand + rArm * [-sin(thHand+1/2*pi), cos(thHand+1/2*pi)] .* dthHand;
    vWaist = vShoulder + rBody * [-sin(thHand+1/2*pi + thShoulder), cos(thHand+1/2*pi + thShoulder)] .* (dthHand + dthShoulder);
    vToe = vWaist + rLeg * [-sin(thHand+1/2*pi + thShoulder + thWaist), cos(thHand+1/2*pi + thShoulder + thWaist)] .* (dthHand + dthShoulder + dthWaist);
    
    PrPB = MrPB .* drPB;
    PthHand = MthHand .* dthHand;
    PthShoulder = MthHand .* dthShoulder;
    PthWaist = MthWaist .* dthWaist;
    
    pG = find_pG(mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist,xHand,yHand);
    vG = find_vG(dthHand,dthWaist,dthShoulder,dxHand,dyHand,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
    momentumG = find_momentumG(dthHand,dthWaist,dthShoulder,dxHand,dyHand,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLeg,rLegMCD,thHand,thShoulder,thWaist,xHand,yHand);
    %}
end
toc

PhysicsValue = [MinThHand, MinThWaist, thWaist_AtBodyUpStraight, MaxDthShoulder, thBodyDifference];
TimeDifference = time_AtMinThWaist - time_AtBodyUpStraight;

Average_Range_Analyze = 10;
Average_PhysicsValue = zeros([ceil(PerformedWell_num/Average_Range_Analyze), size(PhysicsValue,2)]);
Average_ObjectiveValueDatas = zeros([ceil(PerformedWell_num/Average_Range_Analyze), size(ObjectiveValueDatas,2)]);
Average_TimeDifference = zeros([ceil(PerformedWell_num/Average_Range_Analyze), size(TimeDifference,2)]);
for ii = 1:size(Average_PhysicsValue, 1)
    StartIndex_tmp = (ii-1) * Average_Range_Analyze + 1;
    StopIndex_tmp = min(ii * Average_Range_Analyze, size(PhysicsValue, 1));
    
    Average_PhysicsValue(ii, :) = mean(PhysicsValue(StartIndex_tmp:StopIndex_tmp, :));
    Average_ObjectiveValueDatas(ii, :) = mean(ObjectiveValueDatas(StartIndex_tmp:StopIndex_tmp, :));
    Average_TimeDifference(ii, :) = mean(TimeDifference(StartIndex_tmp:StopIndex_tmp, :));
end

% AllData_Matrix = [PhysicsValue, ObjectiveValueDatas, TimeDifference];
AllData_Matrix = [PhysicsValue(:,1:4), ObjectiveValueDatas, TimeDifference, PhysicsValue(:,5)];
corrcoefs = corrcoef(AllData_Matrix, 'Rows','complete')

figure_Number = 0;
Average_LineWidth = 3;

figure_Number = figure_Number + 1;
figure(figure_Number)
clf('reset')
plot(1:PerformedWell_num, ObjectiveValueDatas(:,1), 'blue')
legend({'ëSëÃÇÃï]âø'})
xlabel('âΩî‘ñ⁄Ç…ó«Ç¢ìÆÇ´Ç©(ç∂ÇŸÇ«ó«Ç¢)')
ylabel('ï]âøíl(í·Ç¢ÇŸÇ«ó«Ç¢')

figure_Number = figure_Number + 1;
figure(figure_Number)
clf('reset')
plot(1:PerformedWell_num, -PhysicsValue(:,1), ':blue')
hold on
plot((1:size(Average_PhysicsValue, 1))*Average_Range_Analyze, -Average_PhysicsValue(:,1), 'red', 'LineWidth', Average_LineWidth)
hold off
legend({'éËÇÃç≈è¨äpìx(ëOë§Ç…Ç«ÇÍÇæÇØåXÇ¢ÇΩÇ©)','ïΩãœ'})
xlabel('âΩî‘ñ⁄Ç…ó«Ç¢ìÆÇ´Ç©(ç∂ÇŸÇ«ó«Ç¢)')
ylabel('äpìx(rad)')

figure_Number = figure_Number + 1;
figure(figure_Number)
clf('reset')
plot(1:PerformedWell_num, -PhysicsValue(:,2), ':blue')
hold on
plot((1:size(Average_PhysicsValue, 1))*Average_Range_Analyze, -Average_PhysicsValue(:,2), 'red', 'LineWidth', Average_LineWidth)
hold off
legend({'çòÇÃç≈ëÂêLìWäpìx','ïΩãœ'})
xlabel('âΩî‘ñ⁄Ç…ó«Ç¢ìÆÇ´Ç©(ç∂ÇŸÇ«ó«Ç¢)')
ylabel('äpìx(rad)')

figure_Number = figure_Number + 1;
figure(figure_Number)
clf('reset')
plot(1:PerformedWell_num, -PhysicsValue(:,3), ':blue')
hold on
plot((1:size(Average_PhysicsValue, 1))*Average_Range_Analyze, -Average_PhysicsValue(:,3), 'red', 'LineWidth', Average_LineWidth)
hold off
legend({'ì∑ëÃêÇíºéûÇÃçòÇÃäpìx','ïΩãœ'})
xlabel('âΩî‘ñ⁄Ç…ó«Ç¢ìÆÇ´Ç©(ç∂ÇŸÇ«ó«Ç¢)')
ylabel('äpìx(rad)')

figure_Number = figure_Number + 1;
figure(figure_Number)
clf('reset')
plot(1:PerformedWell_num, PhysicsValue(:,4), ':blue')
hold on
plot((1:size(Average_PhysicsValue, 1))*Average_Range_Analyze, Average_PhysicsValue(:,4), 'red', 'LineWidth', Average_LineWidth)
hold off
legend({'å®ä÷êﬂäpë¨ìxÇÃç≈ëÂ','ïΩãœ'})
xlabel('âΩî‘ñ⁄Ç…ó«Ç¢ìÆÇ´Ç©(ç∂ÇŸÇ«ó«Ç¢)')
ylabel('äpë¨ìx(rad/s)')

figure_Number = figure_Number + 1;
figure(figure_Number)
clf('reset')
plot(1:PerformedWell_num, ObjectiveValueDatas(:,3)/1e1, ':blue')
hold on
plot((1:size(Average_PhysicsValue, 1))*Average_Range_Analyze, Average_ObjectiveValueDatas(:,3)/1e1, 'red', 'LineWidth', Average_LineWidth)
hold off
legend({'dthSwitchValue','ïΩãœ'})
xlabel('âΩî‘ñ⁄Ç…ó«Ç¢ìÆÇ´Ç©(ç∂ÇŸÇ«ó«Ç¢)')
ylabel('ï]âø(í·Ç¢ÇŸÇ«ó«Ç¢)')

figure_Number = figure_Number + 1;
figure(figure_Number)
clf('reset')
plot(1:PerformedWell_num, ObjectiveValueDatas(:,4)/1e0, ':blue')
hold on
plot((1:size(Average_PhysicsValue, 1))*Average_Range_Analyze, Average_ObjectiveValueDatas(:,4)/1e0, 'red', 'LineWidth', Average_LineWidth)
hold off
legend({'MthValue','ïΩãœ'})
xlabel('âΩî‘ñ⁄Ç…ó«Ç¢ìÆÇ´Ç©(ç∂ÇŸÇ«ó«Ç¢)')
ylabel('ï]âø(í·Ç¢ÇŸÇ«ó«Ç¢)')

figure_Number = figure_Number + 1;
figure(figure_Number)
clf('reset')
plot(1:PerformedWell_num, TimeDifference, ':blue')
hold on
plot((1:size(Average_PhysicsValue, 1))*Average_Range_Analyze, Average_TimeDifference, 'red', 'LineWidth', Average_LineWidth)
hold off
legend({'çòÇÃç≈ëÂêiìWéûÇ∆ì∑ëÃêÇíºéûÇÃéûä‘ç∑','ïΩãœ'})
xlabel('âΩî‘ñ⁄Ç…ó«Ç¢ìÆÇ´Ç©(ç∂ÇŸÇ«ó«Ç¢)')
ylabel('éûä‘ç∑(s)')

figure_Number = figure_Number + 1;
figure(figure_Number)
clf('reset')
plot(1:PerformedWell_num, PhysicsValue(:,5), ':blue')
hold on
plot((1:size(Average_PhysicsValue, 1))*Average_Range_Analyze, Average_PhysicsValue(:,5), 'red', 'LineWidth', Average_LineWidth)
hold off
legend({'çòÇÃç≈ëÂêiìWéûÇÃì∑ëÃäpìxÇÃêÇíºâ∫Ç©ÇÁÇÃÇ∏ÇÍ','ïΩãœ'})
xlabel('âΩî‘ñ⁄Ç…ó«Ç¢ìÆÇ´Ç©(ç∂ÇŸÇ«ó«Ç¢)')
ylabel('äpìx(rad)')


%ìÒé≤Ç≈ÇÃï\Çµï˚ÅBï€ë∂ÇµÇƒÇ®Ç≠Ç◊Ç´
%{
figure_Number = figure_Number + 1;
figure(figure_Number)
clf('reset')
colororder({'black','red'})
yyaxis right
ax = gca;
ax.YAxis(2,1).Color = [1,0,0];
yyaxis left
plot((1:PerformedWell_num)', [MinThHand, MinThWaist, thWaist_AtBodyUpStraight], 'Color', ax.YAxis(1,1).Color)
yyaxis right
plot((1:PerformedWell_num)', MaxDthShoulder, 'Color', ax.YAxis(2,1).Color)
legend({'éËÇÃç≈è¨äpìx','çòÇÃç≈è¨äpìx','ê^â∫Ç≈ÇÃçòäpìx','å®äpë¨ìxÇÃç≈ëÂíl'})

figure_Number = figure_Number + 1;
figure(figure_Number)
clf('reset')
colororder({'black','red'})
yyaxis right
ax = gca;
ax.YAxis(2,1).Color = [1,0,0];
yyaxis left
plot(1:PerformedWell_num, ObjectiveValueDatas(1:PerformedWell_num,2:4)./[1e2, 1e1, 1e0], 'Color', ax.YAxis(1,1).Color)
% hold on
% plot(1:PerformedWell_num, ObjectiveValueDatas(1:PerformedWell_num,3)/1e1)
% plot(1:PerformedWell_num, ObjectiveValueDatas(1:PerformedWell_num,4)/1e0)
% hold off
yyaxis right
plot(1:PerformedWell_num, ObjectiveValueDatas(1:PerformedWell_num,1), 'Color', ax.YAxis(2,1).Color)
legend({'spinValue', 'dthSwitchValue', 'MthValue', 'ObjectiveValue'})

PhysicsValue = [MinThHand, MinThWaist, thWaist_AtBodyUpStraight, MaxDthShoulder];
TimeDifference = time_AtMinThWaist - time_AtBodyUpStraight;


figure_Number = figure_Number + 1;
figure(figure_Number)
clf('reset')
colororder({'black','red'})
yyaxis right
ax = gca;
ax.YAxis(2,1).Color = [1,0,0];
yyaxis left
% plot((1:size(Average_PhysicsValue, 1))'*Average_Range_MaxTh_fromPara, Average_PhysicsValue(:,1:2))
plot((1:size(Average_PhysicsValue, 1))'*Average_Range_Analyze, Average_PhysicsValue(:,1:3), 'Color', ax.YAxis(1,1).Color)
yyaxis right
plot((1:size(Average_PhysicsValue, 1))'*Average_Range_Analyze, Average_PhysicsValue(:,4), 'Color', ax.YAxis(2,1).Color)
legend({'éËÇÃç≈è¨äpìxÇÃïΩãœ','çòÇÃç≈è¨äpìxÇÃïΩãœ','ê^â∫Ç≈ÇÃçòäpìxÇÃïΩãœ','å®äpë¨ìxÇÃç≈ëÂílÇÃïΩãœ'})

figure_Number = figure_Number + 1;
figure(figure_Number)
clf('reset')
colororder({'black','red'})
yyaxis right
ax = gca;
ax.YAxis(2,1).Color = [1,0,0];
yyaxis left
plot((1:size(Average_PhysicsValue, 1))'*Average_Range_Analyze, Average_ObjectiveValueDatas(:,2:4)./[1e2, 1e1, 1e0], 'Color', ax.YAxis(1,1).Color)
yyaxis right
plot((1:size(Average_PhysicsValue, 1))'*Average_Range_Analyze, Average_ObjectiveValueDatas(:,1), 'Color', ax.YAxis(2,1).Color)
legend({'spinValueÇÃïΩãœ', 'dthSwitchValueÇÃïΩãœ', 'MthValueÇÃïΩãœ', 'ObjectiveValueÇÃïΩãœ'})

figure_Number = figure_Number + 1;
figure(figure_Number)
clf('reset')
plot(1:PerformedWell_num, TimeDifference, ':blue',...
    (1:size(Average_PhysicsValue, 1))*Average_Range_Analyze, Average_TimeDifference, 'red')
legend({'çòÇÃç≈ëÂêiìWéûÇ∆ì∑ëÃêÇíºéûÇÃéûä‘ç∑','ïΩãœ'})
%}
















































