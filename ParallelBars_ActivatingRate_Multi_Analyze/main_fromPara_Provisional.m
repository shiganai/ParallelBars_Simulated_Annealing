

clear all

% load_Str = 'Para_1014140750_pop_2400_gen_12392_Provisional_ObjectiveValue'; % 制限なし
load_Str = 'Para_1107134918_pop_2400_gen_25568_Provisional_ObjectiveValue'; % value_phase2 で腰を屈曲させる動員率を持たない制限あり

Target_Time_Index = 5;
Target_Joint_Index = 2;

load(load_Str);


constants = Para_Provisional.constants;

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

Data_Set_Time = Para_Provisional.Data_Set_Time;
t = Para_Provisional.odeTime;
q0 = Para_Provisional.q0;
absTol = Para_Provisional.absTol;
Spin_num_Goal = Para_Provisional.Spin_num_Goal;

ode_Fcn = Para_Provisional.ode_Fcn;
Objective_Fcn = Para_Provisional.Objective_Fcn;

% t = Para.odeTime;
t = 0:1e-3:2;
    
% ode_Event = Para_Provisional.ode_Event;
ode_Event = @(t,q) Events_Stability(t,q,Para_Provisional.constants);

Disturbance_step = 1/Para_Provisional.ActivatingRate_Step_num;

ActivatingRate_Step_num = Para_Provisional.ActivatingRate_Step_num;

%{
ActivatingRate_index_Provisional = Para_Provisional.ActivatingRate_index_Provisional;

MthHand_ActivatingRate_spline = spline(Data_Set_Time, ActivatingRate_index_Provisional(:,1));
MthShoulder_ActivatingRate_spline = spline(Data_Set_Time, ActivatingRate_index_Provisional(:,2));
MthWaist_ActivatingRate_spline = spline(Data_Set_Time, ActivatingRate_index_Provisional(:,3));

ActivatingRate_spline = [MthHand_ActivatingRate_spline, MthShoulder_ActivatingRate_spline, MthWaist_ActivatingRate_spline]';


ode = @(t, q) ode_Fcn(t, q, ActivatingRate_spline);

odeOption = odeset('Events', ode_Event, 'AbsTol', absTol);

[time_onbar, q, ~, ~, ie] = ode45(ode, t, q0, odeOption);
Take_Off_Time_Original = time_onbar(end);
%}

% -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
% -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
% -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------


ActivatingRate_index_Provisional = Para_Provisional.ActivatingRate_index_Provisional;

ActivatingRate_index_Provisional(Target_Time_Index, Target_Joint_Index) = ActivatingRate_index_Provisional(Target_Time_Index, Target_Joint_Index) - Disturbance_step;

MthHand_ActivatingRate_spline = spline(Data_Set_Time, ActivatingRate_index_Provisional(:,1));
MthShoulder_ActivatingRate_spline = spline(Data_Set_Time, ActivatingRate_index_Provisional(:,2));
MthWaist_ActivatingRate_spline = spline(Data_Set_Time, ActivatingRate_index_Provisional(:,3));

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

%     ObjectiveValueData = Objective_Fcn(time_onbar, q, breakNum, ActivatingRate_index);

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
ddxHand = fnval(fnder(spline(time_onbar, dxHand)), time_onbar);
ddyHand = fnval(fnder(spline(time_onbar, dyHand)), time_onbar);

ddrPB = fnval(fnder(spline(time_onbar, drPB)), time_onbar);
ddthHand = fnval(fnder(spline(time_onbar, dthHand)), time_onbar);
ddthShoulder = fnval(fnder(spline(time_onbar, dthShoulder)), time_onbar);
ddthWaist = fnval(fnder(spline(time_onbar, dthWaist)), time_onbar);

pG = find_pG(mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist,xHand,yHand);
vG = find_vG(dthHand,dthWaist,dthShoulder,dxHand,dyHand,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
momentumG = find_momentumG(InertiaLeg,InertiaArm,InertiaBody,dthHand,dthWaist,dthShoulder,dxHand,dyHand,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist,xHand,yHand);

if breakNum == 1
    height = pG(end,2) + vG(end,2)^2/(2*g) + 1.8 - rLeg;
    time_until_landing = vG(end,2)/g + (2*height/g)^0.5; %vG(end,2)がマイナスだった場合でも大丈夫
    omegaG = momentumG(end)/InertiaG;
    spinNum_Provisional = time_until_landing * omegaG /(2*pi);
    
    ObjectiveValueData_tmp = Objective_Fcn(time_onbar, q, breakNum, ActivatingRate_index_Provisional);
    ObjectiveValue_Provisional = ObjectiveValueData_tmp(1);
else
    spinNum_Provisional = 0;
    
    ObjectiveValue_Provisional = 100;
end

%{
format longE
ObjectiveValue_Provisional - Para_Provisional.ObjectiveValue_Provisional
spinNum_Provisional - Para_Provisional.spinNum_Provisional
format long
%}

ObjectiveValue_Provisional
spinNum_Provisional

MrPB = find_MrPB(ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
MthHand = find_MthHand(InertiaLeg,InertiaArm,InertiaBody,ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
MthShoulder = find_MthShoulder(InertiaLeg,InertiaBody,ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,mBody,mLeg,rArm,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
MthWaist = find_MthWaist(InertiaLeg,ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthShoulder,g,mLeg,rArm,rBody,rLegMCD,thHand,thShoulder,thWaist);

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

pHand = [xHand, yHand];
pShoulder = pHand + rArm * [cos(thHand+1/2*pi), sin(thHand+1/2*pi)];
pWaist = pShoulder + rBody * [cos(thHand+1/2*pi + thShoulder), sin(thHand+1/2*pi + thShoulder)];
pToe = pWaist + rLeg * [cos(thHand+1/2*pi + thShoulder + thWaist), sin(thHand+1/2*pi + thShoulder + thWaist)];

vHand = [dxHand, dyHand];
vShoulder = vHand + rArm * [-sin(thHand+1/2*pi), cos(thHand+1/2*pi)] .* dthHand;
vWaist = vShoulder + rBody * [-sin(thHand+1/2*pi + thShoulder), cos(thHand+1/2*pi + thShoulder)] .* (dthHand + dthShoulder);
vToe = vWaist + rLeg * [-sin(thHand+1/2*pi + thShoulder + thWaist), cos(thHand+1/2*pi + thShoulder + thWaist)] .* (dthHand + dthShoulder + dthWaist);

xArray = [pHand(:,1), pShoulder(:,1), pWaist(:,1), pToe(:,1), pG(:,1)];
yArray = [pHand(:,2), pShoulder(:,2), pWaist(:,2), pToe(:,2), pG(:,2)];

sliderTimeh = 0.1;
thDataArray = zeros(size(time));
MDataArray = [MthHand_ActivatedRate, MthShoulder_ActivatedRate, MthWaist_ActivatedRate];
otherDataArray = rad2deg([thHand, thShoulder, thWaist]);

%{
if exist('graphs_main','var')
    if isvalid(graphs_main)
        graphs_main.restartupFcn(time, xArray, yArray, thDataArray, MDataArray, otherDataArray, sliderTimeh);
    else
        graphs_main = AnimeAndData_WithSticks(time, xArray, yArray, thDataArray, MDataArray, otherDataArray, sliderTimeh);
    end
else
    graphs_main = AnimeAndData_WithSticks(time, xArray, yArray, thDataArray, MDataArray, otherDataArray, sliderTimeh);
end
%}

graphs_main = AnimeAndData_WithSticks(time, xArray, yArray, thDataArray, MDataArray, otherDataArray, sliderTimeh);
graphs_main.UIFigure.Name = "graphs_main";







































