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
absTol = Para.absTol;

ode_Fcn = Para.ode_Fcn;
ode_Event = Para.ode_Event;
Objective_Fcn = Para.Objective_Fcn;

Data_Set_Time = Para.Data_Set_Time;
ActivatingRate = Para.ActivatingRate;

index = 1; %{肩、腰} * 離散時間 * 個体数

ActivatingRate_index = [reshape(ActivatingRate(index,1,:), size(Data_Set_Time)), reshape(ActivatingRate(index,2,:), size(Data_Set_Time)), reshape(ActivatingRate(index,3,:), size(Data_Set_Time))];

MthHand_ActivatingRate_spline = spline(Data_Set_Time, ActivatingRate_index(:,1));
MthShoulder_ActivatingRate_spline = spline(Data_Set_Time, ActivatingRate_index(:,2));
MthWaist_ActivatingRate_spline = spline(Data_Set_Time, ActivatingRate_index(:,3));

ActivatingRate_spline = [MthHand_ActivatingRate_spline, MthShoulder_ActivatingRate_spline, MthWaist_ActivatingRate_spline]';

ode = @(t, q) ode_Fcn(t, q, ActivatingRate_spline);

odeOption = odeset('Events', ode_Event, 'AbsTol', absTol);

[time_onbar, q, ~, ~, ie] = ode45(ode, t, q0, odeOption);

if ~isempty(ie)
    breakNum = ie(end);
else
    breakNum = 0;
end

ObjectiveValueData = Objective_Fcn(time_onbar, q, breakNum, ActivatingRate_index);

ObjectiveValueDatas = zeros(Para.pop_num, size(ObjectiveValueData,2)); %{肩、腰} * 離散時間 * 個体数
ObjectiveValueDatas(index,:) = ObjectiveValueData;

parfor index = 2:pop_num %{肩、腰} * 離散時間 * 個体数
    
%     fprintf(num2str(index))
%     fprintf('\n')
    
    ActivatingRate_index = [reshape(ActivatingRate(index,1,:), size(Data_Set_Time)), reshape(ActivatingRate(index,2,:), size(Data_Set_Time)), reshape(ActivatingRate(index,3,:), size(Data_Set_Time))];
    
    MthHand_ActivatingRate_spline = spline(Data_Set_Time, ActivatingRate_index(:,1));
    MthShoulder_ActivatingRate_spline = spline(Data_Set_Time, ActivatingRate_index(:,2));
    MthWaist_ActivatingRate_spline = spline(Data_Set_Time, ActivatingRate_index(:,3));
    
    ActivatingRate_spline = [MthHand_ActivatingRate_spline, MthShoulder_ActivatingRate_spline, MthWaist_ActivatingRate_spline]';
    
    ode = @(t, q) ode_Fcn(t, q, ActivatingRate_spline);
    
    odeOption = odeset('Events', ode_Event, 'AbsTol', absTol);
    
    [time_onbar, q, ~, ~, ie] = ode45(ode, t, q0, odeOption);
    
    if ~isempty(ie)
        breakNum = ie(end);
    else
        breakNum = 0;
    end
    
    ObjectiveValueData = Objective_Fcn(time_onbar, q, breakNum, ActivatingRate_index);
    
    ObjectiveValueDatas(index,:) = ObjectiveValueData;
end
end

