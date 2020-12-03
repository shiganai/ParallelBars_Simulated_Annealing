function ObjectiveValueDatas = find_ObjectiveValueDatas(Para)
%UNTITLED この関数の概要をここに記述
%   詳細説明をここに記述

constants = Para.constants;
% g = constants.g;
% kPB = constants.kPB;
% cPB = constants.cPB;
% mAll = constants.mAll;
% mPB = constants.mPB;
% mArm = constants.mArm;
% mBody = constants.mBody;
% mLeg = constants.mLeg;
% rArm = constants.rArm;
% rBody = constants.rBody;
% rLeg = constants.rLeg;
% InertiaModel = constants.InertiaModel;
% rArmMCD = constants.rArmMCD;
% rBodyMCD = constants.rBodyMCD;
% rLegMCD = constants.rLegMCD;
% InertiaArm = constants.InertiaArm;
% InertiaBody = constants.InertiaBody;
% InertiaLeg = constants.InertiaLeg;
% InertiaG = constants.InertiaG;

pop_num = Para.pop_num;
t = Para.odeTime;
q0 = Para.q0;
odeEvent = Para.odeEvent;
absTol = Para.absTol;

Spin_num_Goal = Para.Spin_num_Goal;

Data_Set_Time = Para.Data_Set_Time;
ActivatingRate = Para.ActivatingRate;

% MthHand_ActivatingRate = ActivatingRate(:,1,:);
% MthShoulder_ActivatingRate = ActivatingRate(:,2,:);
% MthWaist_ActivatingRate = ActivatingRate(:,3,:);

ii = 1; %{肩、腰} * 離散時間 * 個体数

MthHand_ActivatingRate_spline = spline(Data_Set_Time, ActivatingRate(ii,1,:));
MthShoulder_ActivatingRate_spline = spline(Data_Set_Time, ActivatingRate(ii,2,:));
MthWaist_ActivatingRate_spline = spline(Data_Set_Time, ActivatingRate(ii,3,:));

% ddpp_TH = [fnval(ddthHand_pp, t_fnval)', fnval(ddthShoulder_pp, t_fnval)', fnval(ddthWaist_pp, t_fnval)'];
ActivatingRate_spline = [MthHand_ActivatingRate_spline, MthShoulder_ActivatingRate_spline, MthWaist_ActivatingRate_spline]';

ode = @(t, q) ddt_Ddt0(t, q, constants, ActivatingRate_spline);

odeOption = odeset('Events', odeEvent, 'AbsTol', absTol);

[time, q, ~, ~, ie] = ode45(ode, t, q0, odeOption);

if ~isempty(ie)
    breakNum = ie(end);
else
    breakNum = 0;
end

ObjectiveValueData = ObjectiveFcn(time, q, constants, Spin_num_Goal, breakNum);

ObjectiveValueDatas = zeros(Para.pop_num, size(ObjectiveValueData,2)); %{肩、腰} * 離散時間 * 個体数
ObjectiveValueDatas(ii,:) = ObjectiveValueData;

parfor ii = 2:pop_num %{肩、腰} * 離散時間 * 個体数

    MthHand_ActivatingRate_spline = spline(Data_Set_Time, ActivatingRate(ii,1,:));
    MthShoulder_ActivatingRate_spline = spline(Data_Set_Time, ActivatingRate(ii,2,:));
    MthWaist_ActivatingRate_spline = spline(Data_Set_Time, ActivatingRate(ii,3,:));
    
    % ddpp_TH = [fnval(ddthHand_pp, t_fnval)', fnval(ddthShoulder_pp, t_fnval)', fnval(ddthWaist_pp, t_fnval)'];
    ActivatingRate_spline = [MthHand_ActivatingRate_spline, MthShoulder_ActivatingRate_spline, MthWaist_ActivatingRate_spline]';
    
    ode = @(t, q) ddt_Ddt0(t, q, constants, ActivatingRate_spline);
    
    odeOption = odeset('Events', odeEvent, 'AbsTol', absTol);
    
    [time, q, ~, ~, ie] = ode45(ode, t, q0, odeOption);
    
    if ~isempty(ie)
        breakNum = ie(end);
    else
        breakNum = 0;
    end
    
    ObjectiveValueData = ObjectiveFcn(time, q, constants, Spin_num_Goal, breakNum);
    
    ObjectiveValueDatas(ii,:) = ObjectiveValueData;
end
end

