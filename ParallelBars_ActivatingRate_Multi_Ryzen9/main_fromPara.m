

% Para_0524161726_pop_2400_gen_2795
% load('Para_0818045928_pop_2400_gen_10503')
% load('Para_0820213137_pop_2400_gen_10561')
load('Para_1123123230_pop_1200_gen_36902')
index = 1;

ActivatingRate = Para.ActivatingRate;

% Para_0618183451_pop_2400_gen_4746 用 index = 1 用チューニング
%{
ActivatingRate(index,1, 2:3) = 0.7;
ActivatingRate(index,1, 4:5) = 0.5;
% ActivatingRate(index,1, 7) = 1;
ActivatingRate(index,1, 9) = 1;
ActivatingRate(index,1, 10) = 0.7;
ActivatingRate(index,1, 11) = 0.8;
% ActivatingRate(index,1, 1:11) = 1;
ActivatingRate(index,1, 13) = 0.5;
ActivatingRate(index, 1, 19:21) = -1;
% ActivatingRate(index, 1, 21) = -0.6;
ActivatingRate(index, 1, 22) = 1;

ActivatingRate(index, 3, 5:7) = 0.2;
ActivatingRate(index, 3, 8) = -0.1;
ActivatingRate(index, 3, 9) = -0.5;
ActivatingRate(index, 3, 14) = -0.8;
%}
% Para_0619064319_pop_2400_gen_7364 用 index = 1 用チューニング
%{
ActivatingRate(index, 3, 1) = -0.0;
ActivatingRate(index, 3, 2) = -0.1;
ActivatingRate(index, 3, 3) = 0;
ActivatingRate(index, 3, 4) = 0.2;
ActivatingRate(index, 3, 5) = 0.2;
ActivatingRate(index, 3, 6) = -0.2;

ActivatingRate(index, 1, 20:23) = -1;

ActivatingRate(index, 3, 16) = 0.0;
ActivatingRate(index, 3, 17) = 0.0;
ActivatingRate(index, 3, 18) = 0.0;
ActivatingRate(index, 3, 19) = 0.0;
ActivatingRate(index, 3, 20) = 0.2;
ActivatingRate(index, 3, 21) = 0.3;
ActivatingRate(index, 3, 22) = 0.2;
ActivatingRate(index, 3, 23) = 0.1;
ActivatingRate(index, 3, 24) = 0.2;

ActivatingRate(index, 1, 24) = -1;
%}
% Para_0619143622_pop_2400_gen_9060 用 index = 1 用チューニング
%{
ActivatingRate(index, 3, 1:10) = ActivatingRate(index, 3, 1:10) - 0.2;
ActivatingRate(index, 3, 1) = ActivatingRate(index, 3, 1) - 0.3;
ActivatingRate(index, 3, 2) = ActivatingRate(index, 3, 2) + 0.2;
ActivatingRate(index, 3, 3) = ActivatingRate(index, 3, 3) - 0.1;
ActivatingRate(index, 3, 5) = ActivatingRate(index, 3, 5) + 0.1;
ActivatingRate(index, 3, 6) = ActivatingRate(index, 3, 6) - 0.1;
ActivatingRate(index, 3, 10:12) = ActivatingRate(index, 3, 10:12) - 0.4;
ActivatingRate(index, 3, 10) = ActivatingRate(index, 3, 10) - 0.1;
ActivatingRate(index, 3, 11) = ActivatingRate(index, 3, 11) - 0.3;
ActivatingRate(index, 3, 12) = ActivatingRate(index, 3, 12) - 0.1;
ActivatingRate(index, 3, 8) = ActivatingRate(index, 3, 8) + 0.5;
ActivatingRate(index, 3, 7) = ActivatingRate(index, 3, 7) + 0.4;
ActivatingRate(index, 3, 9) = ActivatingRate(index, 3, 9) + 0.7;
ActivatingRate(index, 3, 10) = ActivatingRate(index, 3, 10) + 0.6;

ActivatingRate(index, 1, 18:23) = ActivatingRate(index, 1, 18:23) - 2;

% ActivatingRate(index, 1, 18:21) = ActivatingRate(index, 1, 18:21) - 0.5;
%}
% Para_0702211636_pop_2400_gen_7088 用 index = 1 用チューニング
%{
ActivatingRate(index, 3, 6) = -0.7;
ActivatingRate(index, 3, 6) = -0.7;
%}

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
absTol = Para.absTol;
% absTol = 1e-8;
Spin_num_Goal = Para.Spin_num_Goal;
% Spin_num_Goal = 1.2;
% thWaist_AtBodyUpStraight_Range = Para.thWaist_AtBodyUpStraight_Range;

ode_Fcn = Para.ode_Fcn;
ode_Event = Para.ode_Event;
Objective_Fcn = Para.Objective_Fcn;

ActivatingRate_index = [reshape(ActivatingRate(index,1,:), size(Data_Set_Time)), reshape(ActivatingRate(index,2,:), size(Data_Set_Time)), reshape(ActivatingRate(index,3,:), size(Data_Set_Time))];

MthHand_ActivatingRate_spline = spline(Data_Set_Time, ActivatingRate_index(:,1));
MthShoulder_ActivatingRate_spline = spline(Data_Set_Time, ActivatingRate_index(:,2));
MthWaist_ActivatingRate_spline = spline(Data_Set_Time, ActivatingRate_index(:,3));

ActivatingRate_spline = [MthHand_ActivatingRate_spline, MthShoulder_ActivatingRate_spline, MthWaist_ActivatingRate_spline]';

ode = @(t, q) ode_Fcn(t, q, ActivatingRate_spline);

odeOption = odeset('Events', ode_Event, 'AbsTol', absTol);

[time_onbar, q, ~, ~, ie] = ode45(ode, t, q0, odeOption);
time = time_onbar - time_onbar(end);

if ~isempty(ie)
    breakNum = ie(end);
else
    breakNum = 0;
end

ObjectiveValueData = Objective_Fcn(time_onbar, q, breakNum, ActivatingRate_index);

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

% ddthHand = fnval(ddthHand_pp, time_onbar);
% ddthShoulder = fnval(ddthShoulder_pp, time_onbar);
% ddthWaist = fnval(ddthWaist_pp, time_onbar);

MrPB = find_MrPB(ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
MthHand = find_MthHand(InertiaLeg,InertiaArm,InertiaBody,ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
MthShoulder = find_MthShoulder(InertiaLeg,InertiaBody,ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,mBody,mLeg,rArm,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
MthWaist = find_MthWaist(InertiaLeg,ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthShoulder,g,mLeg,rArm,rBody,rLegMCD,thHand,thShoulder,thWaist);

% 最大トルクダブルチェック機構
%{
Index_AtOverMaxTorque = min([find(abs(MthHand) > thHand_MaxTorque, 1), find(abs(MthShoulder) > thShoulder_MaxTorque, 1), find(abs(MthWaist) > thWaist_MaxTorque, 1)]);

if ~isempty(Index_AtOverMaxTorque)
    time_onbar = time_onbar(1:Index_AtOverMaxTorque,1);
    time = time_onbar;
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
    
    MrPB = -cPB * drPB;
    MthHand = find_MthHand(InertiaLeg,InertiaArm,InertiaBody,ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
    MthShoulder = find_MthShoulder(InertiaLeg,InertiaBody,ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,mBody,mLeg,rArm,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
    MthWaist = find_MthWaist(InertiaLeg,ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthShoulder,g,mLeg,rArm,rBody,rLegMCD,thHand,thShoulder,thWaist);
end
%}

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
momentumG = find_momentumG(InertiaLeg,InertiaArm,InertiaBody,dthHand,dthWaist,dthShoulder,dxHand,dyHand,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist,xHand,yHand);
% dmomentumG = find_dmomentumG(InertiaLeg,InertiaArm,InertiaBody,ddthHand,ddthWaist,ddthShoulder,ddxHand,ddyHand,dthHand,dthWaist,dthShoulder,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist,xHand,yHand);


% FxPB = find_FxPB(ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
% FyPB = -kPB * rPB - cPB * drPB;

Fx_Hand = find_Fx_Hand(ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
Fy_Hand = find_Fy_Hand(ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);

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

MthHand_ActivatedRate(MthHand_ActivatedRate > 1) = 1;
MthShoulder_ActivatedRate(MthShoulder_ActivatedRate > 1) = 1;
MthWaist_ActivatedRate(MthWaist_ActivatedRate > 1) = 1;

MthHand_ActivatedRate(MthHand_ActivatedRate < -1) = -1;
MthShoulder_ActivatedRate(MthShoulder_ActivatedRate < -1) = -1;
MthWaist_ActivatedRate(MthWaist_ActivatedRate < -1) = -1;

MthHand_ddt0 = find_MthHand(InertiaLeg,InertiaArm,InertiaBody,ddrPB,0,0,0,dthHand,dthWaist,dthShoulder,g,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
MthShoulder_ddt0 = find_MthShoulder(InertiaLeg,InertiaBody,ddrPB,0,0,0,dthHand,dthWaist,dthShoulder,g,mBody,mLeg,rArm,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
MthWaist_ddt0 = find_MthWaist(InertiaLeg,ddrPB,0,0,0,dthHand,dthShoulder,g,mLeg,rArm,rBody,rLegMCD,thHand,thShoulder,thWaist);

MthHand_ActivatedRate_Ext_ddt0 = (MthHand_ddt0 - MthHand_PassiveTorque) ./ (MthHand_MaxTorque - MthHand_PassiveTorque);
MthHand_ActivatedRate_Flex_ddt0 = (MthHand_PassiveTorque - MthHand_ddt0) ./ (MthHand_PassiveTorque - MthHand_MinTorque);
MthShoulder_ActivatedRate_Ext_ddt0 = (MthShoulder_ddt0 - MthShoulder_PassiveTorque) ./ (MthShoulder_MaxTorque - MthShoulder_PassiveTorque);
MthShoulder_ActivatedRate_Flex_ddt0 = (MthShoulder_PassiveTorque - MthShoulder_ddt0) ./ (MthShoulder_PassiveTorque - MthShoulder_MinTorque);
MthWaist_ActivatedRate_Ext_ddt0 = (MthWaist_ddt0 - MthWaist_PassiveTorque) ./ (MthWaist_MaxTorque - MthWaist_PassiveTorque);
MthWaist_ActivatedRate_Flex_ddt0 = (MthWaist_PassiveTorque - MthWaist_ddt0) ./ (MthWaist_PassiveTorque - MthWaist_MinTorque);

MthHand_ActivatedRate_ddt0 = MthHand_ActivatedRate_Ext_ddt0;
MthHand_ActivatedRate_ddt0(MthHand_ActivatedRate_ddt0 < 0) = -MthHand_ActivatedRate_Flex_ddt0(MthHand_ActivatedRate_ddt0 < 0);

MthShoulder_ActivatedRate_ddt0 = MthShoulder_ActivatedRate_Ext_ddt0;
MthShoulder_ActivatedRate_ddt0(MthShoulder_ActivatedRate_ddt0 < 0) = -MthShoulder_ActivatedRate_Flex_ddt0(MthShoulder_ActivatedRate_ddt0 < 0);

MthWaist_ActivatedRate_ddt0 = MthWaist_ActivatedRate_Ext_ddt0;
MthWaist_ActivatedRate_ddt0(MthWaist_ActivatedRate_ddt0 < 0) = -MthWaist_ActivatedRate_Flex_ddt0(MthWaist_ActivatedRate_ddt0 < 0);

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


time_AtBodyUpStraight = interp1(thHand+1/2*pi + thShoulder, time, 3/2*pi);
thWaist_AtBodyUpStraight = rad2deg(interp1(time, thWaist, time_AtBodyUpStraight));
fprintf(strcat("thWaist_AtBodyUpStraight = ", num2str(thWaist_AtBodyUpStraight), "[°]\n"));

if breakNum == 1
    height = pG(end,2) + vG(end,2)^2/(2*g) + 1.8 - rLeg;
    time_until_landing = vG(end,2)/g + (2*height/g)^0.5; %vG(end,2)がマイナスだった場合でも大丈夫
    omegaG = momentumG(end)/InertiaG;
    spinNum = time_until_landing * omegaG /(2*pi);
    
    fprintf(strcat("spinNum = ", num2str(spinNum), "\n"))
end

%{
figure(1)
clf('reset')
line_ActivatedRate = plot(time, [MthHand_ActivatedRate, MthShoulder_ActivatedRate, MthWaist_ActivatedRate]);
hold on
scatter(Data_Set_Time(Data_Set_Time<time(end)),ActivatingRate(index,1,Data_Set_Time<time(end)), 'MarkerEdgeColor', line_ActivatedRate(1,1).Color)
scatter(Data_Set_Time(Data_Set_Time<time(end)),ActivatingRate(index,2,Data_Set_Time<time(end)), 'MarkerEdgeColor', line_ActivatedRate(2,1).Color)
scatter(Data_Set_Time(Data_Set_Time<time(end)),ActivatingRate(index,3,Data_Set_Time<time(end)), 'MarkerEdgeColor', line_ActivatedRate(3,1).Color)
hold off
legend(line_ActivatedRate,{'手首の動員率', '肩の動員率', '腰の動員率'})
xlabel('時間 [s]')
ylabel('動員率')
ylim([-1.5, 1.5])

figure(2)
clf('reset')
plot(pG(:,1), pG(:,2))
xlim([-1, 1])
ylim([-1, 1])
pbaspect([1, 1, 1])
xlabel('x')
ylabel('y')
grid on

figure(3)
clf('reset')
plot(time, [MthHand, MthShoulder, MthWaist])
legend({'手首のトルク','肩のトルク','腰のトルク'},'location','best')
xlabel('時間 [s]')
ylabel('トルク [N・m]')

figure(4)
clf('reset')
plot(time, rad2deg([dthHand, dthShoulder, dthWaist]))
legend({'手首の角速度','肩の角速度','腰の角速度'},'location','best')
xlabel('時間 [s]')
ylabel('角速度 [°・s^{-1}]')
grid on

figure(5)
clf('reset')
plot(time, rad2deg([thHand, thShoulder, thWaist]))
legend({'手首の角度','肩の角度','腰の角度'},'location','best')
xlabel('時間 [s]')
ylabel('角度 [°]')
yticks(-360:90:360)
ax = gca;
ax.YGrid = 'on';

figure(6)
clf('reset')
plot(time, pG(:,1))
legend('重心の水平座標')
xlabel('時間 [s]')
ylabel('重心の水平座標 [m]')
grid on

figure(7)
clf('reset')
plot(time, pG(:,2))
legend('重心の鉛直座標')
xlabel('時間 [s]')
ylabel('重心の鉛直座標 [m]')
grid on

figure(8)
clf('reset')
plot(time, Fx_Hand)
legend('手にかかる水平方向の力')
xlabel('時間 [s]')
ylabel('力 [N]')
grid on

figure(9)
clf('reset')
plot(time, Fy_Hand)
legend('手にかかる鉛直方向の力')
xlabel('時間 [s]')
ylabel('力 [N]')
grid on

figure(10)
clf('reset')
plot(time, - pG(:,1) .* Fy_Hand + pG(:,2) .* Fx_Hand)
legend('棒反力による重心周りのトルク')
grid on

% figure(4)

% plot(time, MthShoulder, time, [MthShoulder_MaxTorque, MthShoulder_MinTorque], '-.')
%}

Anime_main_WithStick

% Analyze_Coeffs














































