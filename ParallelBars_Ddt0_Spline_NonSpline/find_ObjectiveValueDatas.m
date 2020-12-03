function ObjectiveValueDatas = find_ObjectiveValueDatas(Para)
%UNTITLED ���̊֐��̊T�v�������ɋL�q
%   �ڍא����������ɋL�q

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

ii = 1; %{���A��} * ���U���� * �̐�

MthHand_ActivatingRate_ddt0_spline = GetActivatingRate_ddt0_pp(Data_Set_Time, ActivatingRate(ii,1,:));
MthShoulder_ActivatingRate_ddt0_spline = GetActivatingRate_ddt0_pp(Data_Set_Time, ActivatingRate(ii,2,:));
MthWaist_ActivatingRate_ddt0_spline = GetActivatingRate_ddt0_pp(Data_Set_Time, ActivatingRate(ii,3,:));

ActivatingRate_ii = [reshape(ActivatingRate(ii,1,:), size(Data_Set_Time)), reshape(ActivatingRate(ii,2,:), size(Data_Set_Time)), reshape(ActivatingRate(ii,3,:), size(Data_Set_Time))];
ActivatingRate_ii_spline = [MthHand_ActivatingRate_ddt0_spline, MthShoulder_ActivatingRate_ddt0_spline, MthWaist_ActivatingRate_ddt0_spline]';

ode = @(t, q) ddt_Ddt0(t, q, constants, ActivatingRate_ii_spline, ActivatingRate_ii, Data_Set_Time);

odeOption = odeset('Events', odeEvent, 'AbsTol', absTol);

[time, q, ~, ~, ie] = ode45(ode, t, q0, odeOption);

if ~isempty(ie)
    breakNum = ie(end);
else
    breakNum = 0;
end

ObjectiveValueData = ObjectiveFcn(time, q, constants, Spin_num_Goal, breakNum, ActivatingRate_ii_spline);

ObjectiveValueDatas = zeros(Para.pop_num, size(ObjectiveValueData,2)); %{���A��} * ���U���� * �̐�
ObjectiveValueDatas(ii,:) = ObjectiveValueData;

parfor ii = 2:pop_num %{���A��} * ���U���� * �̐�
    
    
    MthHand_ActivatingRate_ddt0_spline = GetActivatingRate_ddt0_pp(Data_Set_Time, ActivatingRate(ii,1,:));
    MthShoulder_ActivatingRate_ddt0_spline = GetActivatingRate_ddt0_pp(Data_Set_Time, ActivatingRate(ii,2,:));
    MthWaist_ActivatingRate_ddt0_spline = GetActivatingRate_ddt0_pp(Data_Set_Time, ActivatingRate(ii,3,:));
    
    ActivatingRate_ii = [reshape(ActivatingRate(ii,1,:), size(Data_Set_Time)), reshape(ActivatingRate(ii,2,:), size(Data_Set_Time)), reshape(ActivatingRate(ii,3,:), size(Data_Set_Time))];
    ActivatingRate_ii_spline = [MthHand_ActivatingRate_ddt0_spline, MthShoulder_ActivatingRate_ddt0_spline, MthWaist_ActivatingRate_ddt0_spline]';
    
    ode = @(t, q) ddt_Ddt0(t, q, constants, ActivatingRate_ii_spline, ActivatingRate_ii, Data_Set_Time);
    
    odeOption = odeset('Events', odeEvent, 'AbsTol', absTol);
    
    [time, q, ~, ~, ie] = ode45(ode, t, q0, odeOption);
    
    if ~isempty(ie)
        breakNum = ie(end);
    else
        breakNum = 0;
    end
    
    ObjectiveValueData = ObjectiveFcn(time, q, constants, Spin_num_Goal, breakNum, ActivatingRate_ii_spline);
    
    ObjectiveValueDatas(ii,:) = ObjectiveValueData;
end
end
