if ~exist('ifsave','var')
    ifsave = false;
end

% Para_0524161726_pop_2400_gen_2795
load('Para_0717213819_pop_2400_gen_8582')
index = 1;

ActivatingRate = Para.ActivatingRate;

constants = Para.constants;

g = constants.g;
kPB = constants.kPB;
cPB = constants.cPB;
mAll = constants.mAll;
mPB = constants.mPB;
mArm = constants.mArm;
mBody = constants.mBody;
mLeg = constants.mLeg;
rArm = constants.rArm;
rBody = constants.rBody;
rLeg = constants.rLeg;
InertiaModel = constants.InertiaModel;
rArmMCD = constants.rArmMCD;
rBodyMCD = constants.rBodyMCD;
rLegMCD = constants.rLegMCD;
InertiaArm = constants.InertiaArm;
InertiaBody = constants.InertiaBody;
InertiaLeg = constants.InertiaLeg;
InertiaG = constants.InertiaG;
Hand_Para = constants.Hand_Para;
Shoulder_Para = constants.Shoulder_Para;
Waist_Para = constants.Waist_Para;


Data_Set_Time = Para.Data_Set_Time;
t = Para.odeTime;
% t = 0:1e-4:4;
q0 = Para.q0;
odeEvent = Para.odeEvent;
absTol = Para.absTol;
% absTol = 1e-8;
Spin_num_Goal = Para.Spin_num_Goal;
% Spin_num_Goal = 1.2;


ActivatingRate_index = [reshape(ActivatingRate(index,1,:), size(Data_Set_Time)), reshape(ActivatingRate(index,2,:), size(Data_Set_Time)), reshape(ActivatingRate(index,3,:), size(Data_Set_Time))];

MthHand_ActivatingRate_spline = spline(Data_Set_Time, ActivatingRate_index(:,1));
MthShoulder_ActivatingRate_spline = spline(Data_Set_Time, ActivatingRate_index(:,2));
MthWaist_ActivatingRate_spline = spline(Data_Set_Time, ActivatingRate_index(:,3));

ActivatingRate_spline = [MthHand_ActivatingRate_spline, MthShoulder_ActivatingRate_spline, MthWaist_ActivatingRate_spline]';

ode = @(t, q) ddt_ActivatingRate(t, q, constants, ActivatingRate_spline);

odeOption = odeset('Events', odeEvent, 'AbsTol', absTol);

[time_onbar, q, ~, ~, ie] = ode45(ode, t, q0, odeOption);
time = time_onbar;

if ~isempty(ie)
    breakNum = ie(end);
else
    breakNum = 0;
end

ObjectiveValueData = ObjectiveFcn(time_onbar, q, constants, Spin_num_Goal, breakNum, ActivatingRate_index, Data_Set_Time, thWaist_AtBodyUpStraight_Range);

DispObjectiveValueData(ObjectiveValueData, 0)

rPB = q(:,1);
thHand = q(:,2);
thShoulder = q(:,3);
thWaist = q(:,4);
drPB = q(:,5);
dthHand = q(:,6);
dthShoulder = q(:,7);
dthWaist = q(:,8);

yHand = rPB(:,1);
xHand = zeros(size(yHand));
dyHand = drPB(:,1);
dxHand = zeros(size(dyHand));

ddrPB = fnval(fnder(spline(time_onbar, drPB)), time_onbar);
ddthHand = fnval(fnder(spline(time_onbar, dthHand)), time_onbar);
ddthShoulder = fnval(fnder(spline(time_onbar, dthShoulder)), time_onbar);
ddthWaist = fnval(fnder(spline(time_onbar, dthWaist)), time_onbar);


MrPB = find_MrPB(ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
MthHand = find_MthHand(InertiaLeg,InertiaArm,InertiaBody,ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
MthShoulder = find_MthShoulder(InertiaLeg,InertiaBody,ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,mBody,mLeg,rArm,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
MthWaist = find_MthWaist(InertiaLeg,ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthShoulder,g,mLeg,rArm,rBody,rLegMCD,thHand,thShoulder,thWaist);
% 最大トルクダブルチェック機構
%{
[Index_AtOverMaxTorque, Index_OverMaxTorque] = min([find(abs(MthHand) > thHand_MaxTorque, 1), find(abs(MthShoulder) > thShoulder_MaxTorque, 1), find(abs(MthWaist) > thWaist_MaxTorque, 1)]);

if ~isempty(Index_AtOverMaxTorque)
    breakNum = 2 + Index_OverMaxTorque;
    time_onbar = time_onbar(1:Index_AtOverMaxTorque,1);
    q = q(1:Index_AtOverMaxTorque,:);
    
    rPB = q(:,1);
    thHand = q(:,2);
    thShoulder = q(:,3);
    thWaist = q(:,4);
    drPB = q(:,5);
    dthHand = q(:,6);
    dthShoulder = q(:,7);
    dthWaist = q(:,8);
    
    yHand = rPB(:,1);
    xHand = zeros(size(yHand));
    dyHand = drPB(:,1);
    dxHand = zeros(size(dyHand));
    
    ddrPB = ppval(fnder(spline(time_onbar, drPB)), time_onbar);
    
    ddthHand = fnval(ddthHand_pp, time_onbar);
    ddthShoulder = fnval(ddthShoulder_pp, time_onbar);
    ddthWaist = fnval(ddthWaist_pp, time_onbar);
    
    MrPB = find_MrPB(ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,kPB,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,rPB,thHand,thShoulder,thWaist);
    MthHand = find_MthHand(InertiaLeg,InertiaArm,InertiaBody,ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
    MthShoulder = find_MthShoulder(InertiaLeg,InertiaBody,ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,mBody,mLeg,rArm,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
    MthWaist = find_MthWaist(InertiaLeg,ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthShoulder,g,mLeg,rArm,rBody,rLegMCD,thHand,thShoulder,thWaist);
end
%}

KE = find_KE(InertiaLeg,InertiaArm,InertiaBody,dthHand,dthWaist,dthShoulder,dxHand,dyHand,g,kPB,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist,yHand);
% dKE = find_dKE(InertiaLeg,InertiaArm,InertiaBody,ddthHand,ddthWaist,ddthShoulder,ddxHand,ddyHand,dthHand,dthWaist,dthShoulder,dxHand,dyHand,g,kPB,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist,yHand);
dKE = ppval(fnder(spline(time_onbar, KE)), time_onbar);

pHand = [zeros(size(rPB(:,1))), rPB];
vHand = [zeros(size(rPB(:,1))), drPB];
    
if breakNum == 1
    
    pG = find_pG(mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist,xHand,yHand);
    vG = find_vG(dthHand,dthWaist,dthShoulder,dxHand,dyHand,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
    momentumG = find_momentumG(InertiaLeg,InertiaArm,InertiaBody,dthHand,dthWaist,dthShoulder,dxHand,dyHand,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist,xHand,yHand);
    
    height = pG(end,2) + vG(end,2)^2/(2*g) + 1.8 - rLeg;
    time_until_landing = vG(end,2)/g + (2*height/g)^0.5; %vG(end,2)がマイナスだった場合でも大丈夫
    omegaG = momentumG(end)/InertiaG;
    spinNum = time_until_landing * omegaG /(2*pi);
    
    fprintf(strcat("spinNum = ", num2str(spinNum), "\n"))
    
    t_freefall = 0:time_onbar(2,1) - time_onbar(1,1):10;
    q0_freefall = [0, q(end,1), q(end,2), q(end,3), q(end,4), 0, q(end,5), q(end,6), q(end,7), q(end,8)]';
    
    eventFcn_freefall = @(t,q)Events_freefall(t, q, constants);
    odeOption_freefall = odeset('Events', eventFcn_freefall ,'AbsTol', Para.absTol);
    ode_freefall = @(t,q) ddt_freefall(t, q, constants);
    
    [time_freefall, q_freefall] = ode45(ode_freefall, t_freefall, q0_freefall, odeOption_freefall);
    
    time = [time_onbar(:,1); time_freefall(2:end,1) + time_onbar(end,1)];
    
    xHand = [xHand; q_freefall(2:end, 1)];
    yHand = [yHand; q_freefall(2:end, 2)];
    thHand = [thHand; q_freefall(2:end,3)];
    thShoulder = [thShoulder; q_freefall(2:end,4)];
    thWaist = [thWaist; q_freefall(2:end,5)];
    
    dxHand = [dxHand; q_freefall(2:end, 6)];
    dyHand = [dyHand; q_freefall(2:end, 7)];
    dthHand = [dthHand; q_freefall(2:end,8)];
    dthShoulder = [dthShoulder; q_freefall(2:end,9)];
    dthWaist = [dthWaist; q_freefall(2:end,10)];
    
    MrPB = [MrPB; zeros(size(time_freefall(2:end,1)))];
    MthHand = [MthHand; zeros(size(time_freefall(2:end,1)))];
    MthShoulder = [MthShoulder; zeros(size(time_freefall(2:end,1)))];
    MthWaist = [MthWaist; zeros(size(time_freefall(2:end,1)))];
    
    pHand = [xHand, yHand];
    vHand = [dxHand, dyHand];
    
    rPB = [rPB(:,1); zeros(size(time_freefall(2:end,1))) + rPB(end,1)];
    drPB = [drPB(:,1); zeros(size(time_freefall(2:end,1))) + drPB(end,1)];
    
    ddrPB = [ddrPB(:,1); zeros(size(time_freefall(2:end,1)))];
    ddthHand = [ddthHand(:,1); zeros(size(time_freefall(2:end,1)))];
    ddthShoulder = [ddthShoulder(:,1); zeros(size(time_freefall(2:end,1)))];
    ddthWaist = [ddthWaist(:,1); zeros(size(time_freefall(2:end,1)))];
    
else
    warning("離手失敗")
    time = time_onbar;
end
pShoulder = pHand + rArm * [cos(thHand+1/2*pi), sin(thHand+1/2*pi)];
pWaist = pShoulder + rBody * [cos(thHand+1/2*pi + thShoulder), sin(thHand+1/2*pi + thShoulder)];
pToe = pWaist + rLeg * [cos(thHand+1/2*pi + thShoulder + thWaist), sin(thHand+1/2*pi + thShoulder + thWaist)];

vShoulder = vHand + rArm * [-sin(thHand+1/2*pi), cos(thHand+1/2*pi)] .* dthHand;
vWaist = vShoulder + rBody * [-sin(thHand+1/2*pi + thShoulder), cos(thHand+1/2*pi + thShoulder)] .* (dthHand + dthShoulder);
vToe = vWaist + rLeg * [-sin(thHand+1/2*pi + thShoulder + thWaist), cos(thHand+1/2*pi + thShoulder + thWaist)] .* (dthHand + dthShoulder + dthWaist);

PrPB = MrPB .* drPB;
PthHand = MthHand .* dthHand;
PthShoulder = MthHand .* dthShoulder;
PthWaist = MthWaist .* dthWaist;

pG = find_pG(mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist,xHand,yHand);
vG = find_vG(dthHand,dthWaist,dthShoulder,dxHand,dyHand,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
momentumG = find_momentumG(InertiaLeg,InertiaArm,InertiaBody,dthHand,dthWaist,dthShoulder,dxHand,dyHand,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist,xHand,yHand);
KE = [KE; zeros([size(momentumG,1)-size(KE,1),1])];
dKE = [dKE; zeros([size(momentumG,1)-size(dKE,1),1])];

thHand_degree = rad2deg(thHand);
thShoulder_degree = rad2deg(thShoulder);
thWaist_degree = rad2deg(thWaist);
dthHand_degree = rad2deg(dthHand);
dthShoulder_degree = rad2deg(dthShoulder);
dthWaist_degree = rad2deg(dthWaist);

thHand_degree_VT = thHand_degree;
thHand_degree_VT(thHand_degree < Hand_Para.theta_PE_1_Ext) = Hand_Para.theta_PE_1_Ext;
thHand_degree_VT(thHand_degree > Hand_Para.theta_PE_1_Flex) = Hand_Para.theta_PE_1_Flex;


MthHand_MaxTorque = VoluntaryTorque(Hand_Para, thHand_degree_VT, dthHand_degree, 1) * 2;
MthHand_MinTorque = VoluntaryTorque(Hand_Para, thHand_degree_VT, dthHand_degree, -1) * 2;
MthHand_PassiveTorque = VoluntaryTorque(Hand_Para, thHand_degree_VT, dthHand_degree, 0) * 2;
MthShoulder_MaxTorque = VoluntaryTorque(Shoulder_Para, thShoulder_degree, dthShoulder_degree, 1) * 2;
MthShoulder_MinTorque = VoluntaryTorque(Shoulder_Para, thShoulder_degree, dthShoulder_degree, -1) * 2;
MthShoulder_PassiveTorque = VoluntaryTorque(Shoulder_Para, thShoulder_degree, dthShoulder_degree, 0) * 2;
MthWaist_MaxTorque = VoluntaryTorque(Waist_Para, thWaist_degree, dthWaist_degree, 1) * 2;
MthWaist_MinTorque = VoluntaryTorque(Waist_Para, thWaist_degree, dthWaist_degree, -1) * 2;
MthWaist_PassiveTorque = VoluntaryTorque(Waist_Para, thWaist_degree, dthWaist_degree, 0) * 2;

MthHand_ActivatedRate_Ext = (MthHand - MthHand_PassiveTorque) ./ (MthHand_MaxTorque - MthHand_PassiveTorque);
MthHand_ActivatedRate_Flex = (MthHand_PassiveTorque - MthHand) ./ (MthHand_PassiveTorque - MthHand_MinTorque);
MthShoulder_ActivatedRate_Ext = (MthShoulder - MthShoulder_PassiveTorque) ./ (MthShoulder_MaxTorque - MthShoulder_PassiveTorque);
MthShoulder_ActivatedRate_Flex = (MthShoulder_PassiveTorque - MthShoulder) ./ (MthShoulder_PassiveTorque - MthShoulder_MinTorque);
MthWaist_ActivatedRate_Ext = (MthWaist - MthWaist_PassiveTorque) ./ (MthWaist_MaxTorque - MthWaist_PassiveTorque);
MthWaist_ActivatedRate_Flex = (MthWaist_PassiveTorque - MthWaist) ./ (MthWaist_PassiveTorque - MthWaist_MinTorque);

MthHand_ActivatedRate = MthHand_ActivatedRate_Ext;
MthHand_ActivatedRate(MthHand_ActivatedRate < 0) = -MthHand_ActivatedRate_Flex(MthHand_ActivatedRate < 0);

MthShoulder_ActivatedRate = MthShoulder_ActivatedRate_Ext;
MthShoulder_ActivatedRate(MthShoulder_ActivatedRate < 0) = -MthShoulder_ActivatedRate_Flex(MthShoulder_ActivatedRate < 0);

MthWaist_ActivatedRate = MthWaist_ActivatedRate_Ext;
MthWaist_ActivatedRate(MthWaist_ActivatedRate < 0) = -MthWaist_ActivatedRate_Flex(MthWaist_ActivatedRate < 0);

MthHand_ActivatedRate(time > time_onbar(end)) = 0;
MthShoulder_ActivatedRate(time > time_onbar(end)) = 0;
MthWaist_ActivatedRate(time > time_onbar(end)) = 0;

%{
figure(1)
line_ActivatedRate = plot(time, [MthHand_ActivatedRate, MthShoulder_ActivatedRate, MthWaist_ActivatedRate]);
legend({'手首の動員率', '肩の動員率', '腰の動員率'})
hold on
scatter(Data_Set_Time(Data_Set_Time<time_onbar(end)),ActivatingRate(index,1,Data_Set_Time<time_onbar(end)), 'MarkerEdgeColor', line_ActivatedRate(1,1).Color)
scatter(Data_Set_Time(Data_Set_Time<time_onbar(end)),ActivatingRate(index,2,Data_Set_Time<time_onbar(end)), 'MarkerEdgeColor', line_ActivatedRate(2,1).Color)
scatter(Data_Set_Time(Data_Set_Time<time_onbar(end)),ActivatingRate(index,3,Data_Set_Time<time_onbar(end)), 'MarkerEdgeColor', line_ActivatedRate(3,1).Color)
hold off

figure(2)
plot(pG(:,1), pG(:,2))
xlim([-1, 1])
ylim([-1, 1])
pbaspect([1, 1, 1])
grid on

figure(3)
plot(time, [MthHand, MthShoulder, MthWaist])
legend({'手首のトルク','肩のトルク','腰のトルク'},'location','best')

figure(4)
plot(time, [dthHand, dthShoulder, dthWaist])
legend({'手首の角速度','肩の角速度','腰の角速度'},'location','best')
%}

Anime_main
%{
if ifsave
    xArray = [pHand(:,1), pShoulder(:,1), pWaist(:,1), pToe(:,1), pG(:,1)];
    yArray = [pHand(:,2), pShoulder(:,2), pWaist(:,2), pToe(:,2), pG(:,2)];
    
    xArray = [zeros(length(xArray(:, 1)), 1), xArray];
    yArray = [zeros(length(yArray(:, 1)), 1), yArray];
    
    figure(1)
    axAnime = gca;
    %----------------------------------------------------
    %-----------------関節の表示--------------------------
    %----------------------------------------------------
    pAnimes(1) = scatter(axAnime, 0, 0);
    hold(axAnime, 'on')
    for ii = 2:length(xArray(1, :))-1
        pAnimes(ii) = scatter(axAnime, xArray(1, ii), yArray(1, ii), 'r', 'fill');
    end
    
    %----------------------------------------------------
    %-----------------身体の表示--------------------------
    %----------------------------------------------------
    for ii = 2:length(xArray(1, :)) - 2
        lines(ii-1) = line(axAnime,...
            [xArray(1, ii), xArray(1, ii+1)],...
            [yArray(1, ii), yArray(1, ii+1)]);
    end
    
    
    %----------------------------------------------------
    %-----------------重心の表示--------------------------
    %----------------------------------------------------
    ii = length(xArray(1,:));
    pAnimes(ii) = scatter(axAnime, xArray(1, ii), yArray(1, ii), 'r', 'x');
    
    line(axAnime,[-3,3],[-1.8, -1.8])

    hold(axAnime, 'off')
            
    xlim(axAnime,[-3 3])
    ylim(axAnime,[-3 3])
    pbaspect(axAnime,[1 1 1])
    
    frame_step_num = 50;
    for jj = 0:floor(length(xArray)/frame_step_num)-1
        targetIndex = jj * frame_step_num + 1;
        for ii = 2:length(xArray(1, :))
            pAnimes(ii).XData = xArray(targetIndex, ii);
            pAnimes(ii).YData = yArray(targetIndex, ii);
        end
        
        for ii = 2:length(xArray(1, :)) - 2 %2つのデータを使い、かつ重心（最後）には線を引かない
            lines(ii-1).XData = ...
                [xArray(targetIndex, ii), xArray(targetIndex, ii+1)];
            lines(ii-1).YData =...
                [yArray(targetIndex, ii), yArray(targetIndex, ii+1)];
        end
%         drawnow;
        fileName = strcat("S:\OneDrive - The University of Tokyo\MATLAB_projects\GeneticAlgorithm\ParallelBars\png\", num2str(jj,"%03.f"),".png");
        saveas(axAnime, fileName)
    end
end

ifsave = false;
%}








































