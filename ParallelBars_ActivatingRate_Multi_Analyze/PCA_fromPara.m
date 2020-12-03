
load('Para_1014140750_pop_2400_gen_12392')

ActivatingRate = Para.ActivatingRate;
ObjectiveValueDatas = Para.ObjectiveValueDatas;

ActivatingRate = Para.Before_Annealing_ActivatingRate;
ObjectiveValueDatas = Para.Before_Annealing_ObjectiveValueDatas;

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
%     odeEvent = Para.odeEvent;
absTol = Para.absTol;
% absTol = 1e-8;
Spin_num_Goal = Para.Spin_num_Goal;
% Spin_num_Goal = 1.2;

ode_Fcn = Para.ode_Fcn;
ode_Event = Para.ode_Event;
Objective_Fcn = Para.Objective_Fcn;

PerformedWell_Index = find((ObjectiveValueDatas(:,2) >= 0.00)...
    .* (ObjectiveValueDatas(:,2) <= 100-84.15));
% PerformedWell_Index = find((ObjectiveValueDatas(:,2) >= 0.00)...
%     .* (ObjectiveValueDatas(:,2) <= 100));

% PerformedWell_Index = 1:200;
% PerformedWell_Index = 1:800;
%     PerformedWell_Index = 1:2400;

%     if size(PerformedWell_Index,1) < Data_Index_Range(end)
%         Data_Index_Range = 1:size(PerformedWell_Index,1);
%     end

ActivatingRate = ActivatingRate(PerformedWell_Index,:,:);
ObjectiveValueDatas = ObjectiveValueDatas(PerformedWell_Index,:);


PerformedWell_num = size(ObjectiveValueDatas,1);

MinThHand = zeros([PerformedWell_num, 1]);
MaxDthShoulder = zeros([PerformedWell_num, 1]);
MinThWaist = zeros([PerformedWell_num, 1]);

thWaist_AtBodyUpStraight = zeros([PerformedWell_num, 1]);
thWaist_AtBodyHorizon = zeros([PerformedWell_num, 1]);

thBodyDifference = zeros([PerformedWell_num, 1]);

time_AtBodyUpStraight = zeros([PerformedWell_num, 1]);
time_AtBodyHorizon = zeros([PerformedWell_num, 1]);
time_AtMinThWaist = zeros([PerformedWell_num, 1]);

Spin_num = zeros([PerformedWell_num, 1]);
Time_Until_Landing = zeros([PerformedWell_num, 1]);
Height = zeros([PerformedWell_num, 1]);
MomentumG = zeros([PerformedWell_num, 1]);
OmegaG = zeros([PerformedWell_num, 1]);

Work_Total = zeros([PerformedWell_num, 1]);

Value_phase2 = zeros([PerformedWell_num, 1]);
Value_phase3 = zeros([PerformedWell_num, 1]);

thHand_All = zeros([PerformedWell_num, size(t,2)]);
thShoulder_All = zeros([PerformedWell_num, size(t,2)]);
thWaist_All = zeros([PerformedWell_num, size(t,2)]);

tic
parfor index = 1:PerformedWell_num
    
    ActivatingRate_index = [reshape(ActivatingRate(index,1,:), size(Data_Set_Time)), reshape(ActivatingRate(index,2,:), size(Data_Set_Time)), reshape(ActivatingRate(index,3,:), size(Data_Set_Time))];
    
    MthHand_ActivatingRate_spline = spline(Data_Set_Time, ActivatingRate_index(:,1));
    MthShoulder_ActivatingRate_spline = spline(Data_Set_Time, ActivatingRate_index(:,2));
    MthWaist_ActivatingRate_spline = spline(Data_Set_Time, ActivatingRate_index(:,3));
    
    ActivatingRate_spline = [MthHand_ActivatingRate_spline, MthShoulder_ActivatingRate_spline, MthWaist_ActivatingRate_spline]';
    
    ode = @(t, q) ode_Fcn(t, q, ActivatingRate_spline);
    
    odeOption = odeset('Events', ode_Event, 'AbsTol', absTol);
    
    [time_onbar, q, ~, ~, ie] = ode45(ode, t, q0, odeOption);
    time = time_onbar;
    
    if ~isempty(ie)
        breakNum = ie(end);
    else
        breakNum = 0;
    end
    
    ObjectiveValueData = Objective_Fcn(time_onbar, q, breakNum, ActivatingRate_index);
    
    
    rPB = q(:,1);
    thHand = q(:,2);
    thShoulder = q(:,3);
    thWaist = q(:,4);
    drPB = q(:,5);
    dthHand = q(:,6);
    dthShoulder = q(:,7);
    dthWaist = q(:,8);
    
    ddrPB = fnval(fnder(spline(time, drPB)), time);
    ddthHand = fnval(fnder(spline(time, dthHand)), time);
    ddthShoulder = fnval(fnder(spline(time, dthShoulder)), time);
    ddthWaist = fnval(fnder(spline(time, dthWaist)), time);
    
    
    
    thHand_All(index,:) = [thHand', zeros([1, size(t,2) - size(time,1)]) + NaN];
    thShoulder_All(index,:) = [thShoulder', zeros([1, size(t,2) - size(time,1)]) + NaN];
    thWaist_All(index,:) = [thWaist', zeros([1, size(t,2) - size(time,1)]) + NaN];
    
    MinThHand(index,1) = min(thHand);
    MaxDthShoulder(index,1) = max(dthShoulder);
    [MinThWaist(index,1), index_AtMinThWaist] = min(thWaist);
    
    time_AtMinThWaist(index, 1) = time(index_AtMinThWaist,1);
    
    time_AtBodyUpStraight(index, 1) = interp1(thHand+1/2*pi + thShoulder, time, 3/2*pi);
    thWaist_AtBodyUpStraight(index, 1) = interp1(time, thWaist, time_AtBodyUpStraight(index, 1));
    
    time_AtBodyUpStraight(index, 1) = interp1(thHand+1/2*pi + thShoulder, time, 3/2*pi);
    thWaist_AtBodyUpStraight(index, 1) = interp1(time, thWaist, time_AtBodyUpStraight(index, 1));
    
    time_AtBodyHorizon(index, 1) = interp1(thHand+1/2*pi + thShoulder, time, 2/2*pi);
    thWaist_AtBodyHorizon(index, 1) = interp1(time, thWaist, time_AtBodyHorizon(index, 1));
    
    thBodyDifference(index, 1) = thHand(index_AtMinThWaist,1)+1/2*pi + thShoulder(index_AtMinThWaist,1) - 3/2*pi;
    
    yHand = rPB(:,1);
    xHand = zeros(size(yHand));
    dyHand = drPB(:,1);
    dxHand = zeros(size(dyHand));
    
    pG = find_pG(mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist,xHand,yHand);
    vG = find_vG(dthHand,dthWaist,dthShoulder,dxHand,dyHand,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
    momentumG = find_momentumG(InertiaLeg,InertiaArm,InertiaBody,dthHand,dthWaist,dthShoulder,dxHand,dyHand,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist,xHand,yHand);
    
    Fx_Hand = find_Fx_Hand(ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
    Fy_Hand = find_Fy_Hand(ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
    
    height = pG(end,2) + vG(end,2)^2/(2*g) + 1.8 - rLeg;
    time_until_landing = vG(end,2)/g + (2*height/g)^0.5; %vG(end,2)がマイナスだった場合でも大丈夫
    omegaG = momentumG(end)/InertiaG;
    
    Height(index, 1) = height;
    MomentumG(index, 1) = omegaG;
    Spin_num(index, 1) = time_until_landing * omegaG /(2*pi);
    Time_Until_Landing(index, 1) = time_until_landing;
    OmegaG(index, 1) = omegaG/(2*pi);
    
    MthHand = find_MthHand(InertiaLeg,InertiaArm,InertiaBody,ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
    MthShoulder = find_MthShoulder(InertiaLeg,InertiaBody,ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,mBody,mLeg,rArm,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
    MthWaist = find_MthWaist(InertiaLeg,ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthShoulder,g,mLeg,rArm,rBody,rLegMCD,thHand,thShoulder,thWaist);
    
    Step_Time = diff(time(1:2));
    
    Power_thHand = MthHand .* dthHand;
    Power_thHand_Positive = Power_thHand(Power_thHand >= 0);
    Power_thHand_Negative = Power_thHand(Power_thHand < 0);
    Work_thHand = (sum(Power_thHand_Positive) + 0.5 * sum(abs(Power_thHand_Negative)) + sum(abs(MthHand))) * Step_Time;
    
    Power_thShoulder = MthShoulder .* dthShoulder;
    Power_thShoulder_Positive = Power_thShoulder(Power_thShoulder >= 0);
    Power_thShoulder_Negative = Power_thShoulder(Power_thShoulder < 0);
    Work_thShoulder = (sum(Power_thShoulder_Positive) + 0.5 * sum(abs(Power_thShoulder_Negative)) + sum(abs(MthShoulder))) * Step_Time;
    
    Power_thWaist = MthWaist .* dthWaist;
    Power_thWaist_Positive = Power_thWaist(Power_thWaist >= 0);
    Power_thWaist_Negative = Power_thWaist(Power_thWaist < 0);
    Work_thWaist = (sum(Power_thWaist_Positive) + 0.5 * sum(abs(Power_thWaist_Negative)) + sum(abs(MthWaist))) * Step_Time;
    
    Work_Total(index,1) = Work_thHand + Work_thShoulder + Work_thWaist;
    
    % パート分け
    %{
    [~, b1] = min(pG(:,1));
    phase1 = 1:b1;
    
    [~, b2] = max(Fy_Hand);
    b3 = find(Fy_Hand(1:b2,1) < Fy_Hand(1,1), 1, 'last');
    phase2 = (b1+1):b3;
    
    phase3 = (b3+1):size(time, 1);
    
    switch1 = time(b1);
    switch2 = time(b3);
    
    [a4, b4] = min(thWaist(phase2));
    [a5, b5] = max(thWaist(phase2));
    
    Value_phase2(index,1) = (a5 - a4) * abs(b5 - b4) / (b5 - b4);
    
    Value_phase3(index,1) = min(thWaist(phase3));
    %}
end
toc

thHand_AR = reshape(ActivatingRate(:,1,:), [size(ActivatingRate,1), size(ActivatingRate,3)]);
thShoulder_AR = reshape(ActivatingRate(:,2,:), [size(ActivatingRate,1), size(ActivatingRate,3)]);
thWaist_AR = reshape(ActivatingRate(:,3,:), [size(ActivatingRate,1), size(ActivatingRate,3)]);

[thHand_AR_Coeffs, thHand_AR_Score, thHand_AR_Latend] = pca(thHand_AR);
[thShoulder_AR_Coeffs, thShoulder_AR_Score, thShoulder_AR_Latend] = pca(thShoulder_AR);
[thWaist_AR_Coeffs, thWaist_AR_Score, thWaist_AR_Latend] = pca(thWaist_AR);

Least_Non_NaN_Colmn_Number = floor(find(isnan(thHand_All),1)/size(thHand_All,1));
thHand_All = thHand_All(:,1:Least_Non_NaN_Colmn_Number);
thShoulder_All = thShoulder_All(:,1:Least_Non_NaN_Colmn_Number);
thWaist_All = thWaist_All(:,1:Least_Non_NaN_Colmn_Number);

[thHand_All_Coeffs, thHand_All_Score, thHand_All_Latend] = pca(thHand_All);
[thShoulder_All_Coeffs, thShoulder_All_Score, thShoulder_All_Latend] = pca(thShoulder_All);
[thWaist_All_Coeffs, thWaist_All_Score, thWaist_All_Latend] = pca(thWaist_All);

tic
[idx, C] = kmeans(thWaist_All_Score(:,[1,2]), 4, 'Distance', 'sqeuclidean');
toc

figure(1)
scatter(1:size(thWaist_AR,1), thWaist_AR_Score(:,1))

figure(2)
scatter(thWaist_AR_Score(:,1), thWaist_AR_Score(:,2), [], Spin_num)
colorbar
colormap cool

figure(3)
scatter(thWaist_AR_Score(:,1), Spin_num)

figure(4)
scatter(thWaist_AR_Score(:,1), Time_Until_Landing(:,1))

figure(5)
scatter(thWaist_AR_Score(:,1), OmegaG(:,1))

figure(6)
scatter(1:size(thWaist_All,1), thWaist_All_Score(:,1))
title('順位 vs PCA1')
xlabel('順位')
ylabel('PCA1')

figure(7)
scatter(thWaist_All_Score(:,1), thWaist_All_Score(:,2), [], Spin_num)
colorbar
colormap cool
title('PCA1 vs PCA2 vs 回転数')
xlabel('PCA1')
ylabel('PCA2')

figure(8)
scatter(thWaist_All_Score(:,1), Spin_num(:,1))
title('PCA1 vs 回転数')
xlabel('PCA1')
ylabel('回転数')

figure(9)
scatter(thWaist_All_Score(:,1), Time_Until_Landing(:,1))
title('PCA1 vs 滞空時間')
xlabel('PCA1')
ylabel('滞空時間')

figure(10)
scatter(thWaist_All_Score(:,1), OmegaG(:,1))
title('PCA1 vs 回転速度')
xlabel('PCA1')
ylabel('回転速度')

figure(11)
scatter(thWaist_All_Score(idx == 1, 1), thWaist_All_Score(idx == 1, 2))
hold on
for i = 2:size(C,1)
    scatter(thWaist_All_Score(idx == i, 1), thWaist_All_Score(idx == i, 2))
end
scatter(C(:,1), C(:,2), 100, 'k', 'filled')
hold off
title('PCA1 vs PCA2 vs 回転数')
xlabel('PCA1')
ylabel('PCA2')








































