
clear all
rng shuffle

Para.IfScat = 0;


Para.Take_Over = true;
% Para.Take_Over = false;

if Para.Take_Over
    Take_Over_Str = "Para_1120104512_pop_1200_gen_19242";
    load(Take_Over_Str)
    
    Para.Take_Over = true;
    Para.Take_Over_Str = [Para.Take_Over_Str; Take_Over_Str];
else

    Para.Take_Over_Str = "";
    % ����A�̂ɂ��񂵂�
    Para.pop_num = 12 * 1e2 * 1; %�̐�
    Para.save_pop_num = Para.pop_num; %�ۑ����鐔
    Para.not_reset_pop_num = 4;
    % Para.gen_num = 2e4; %���㐔
    Para.Reset_Annealing_Count_Threshold = 4;
    Para.Save_Reset_Count_Threshold = 0;
    Para.Annealing_gen = 4;
    Para.No_Gain_gen_Threshold = 10;
    % Para.No_Gain_pop_num_ratio = 0.0; %�]���l���オ�������삪�S�̂̂��̊����������ƁA�Ă��Ȃ܂��J�E���g��������
    Para.Average_Range = 300;
    Para.Mean_Std_Threshold = 1e-4; %Average_Range��300��1200�̂ɑ΂���0.4�̕��ς̕W���΍��Boptimization��Mean_Std���o���Ƃ���pop_num�Ŋ����đS�̂ɑ΂���count�̊������o���Ă�����B
    
    if Para.save_pop_num > Para.pop_num
        Para.save_pop_num = Para.pop_num;
    end
    
    
    % �f�[�^�Ɋւ���
    Para.constants = struct(constants_HH_AE_Hand_Weakened);
    Para.q0 = generate_q0(Para.constants);
    Para.Data_Set_Time = (0:5e-2:1.4)';
    Para.Joint_num = 3;
    Para.ActivatingRate_Step_num = 10; % 1/30���݂Ŋ����������߂�
    Para.mutation_max_ratio = 5;
    Para.Base_Transition_Probability = 5; %0����1�ɑJ�ڂ���p�[�Z���g
    Para.Max_Transition_Probability = 97; %�Ă��Ȃ܂��J�n����0����1�ɑJ�ڂ���p�[�Z���g
    Para.ifResetAll = false;
    
    % �����l�̐ݒ�
    Para = generate_init_ActivatingRate(Para);
%     Para = load_and_fit_init_Mdatas(Para, 'Para_1025173328_pop_2400_gen_6595', 2400);
    
    % �ϕ��ׂ̍����Ɋւ���
    Para.odeTime = 0:1e-3:1.4;
    Para.absTol = 1e-6;
    
    % �����̊Ǘ�
    
    % ��������
    %{
    Para.Mode_String = '�����Ȃ�';
    Para.Spin_num_Goal = 1.5; % �]���l�Ɋւ���
    Para.ode_Fcn = @(t,q,ActivatingRate_spline) ddt_ActivatingRate(t, q, Para.constants, ActivatingRate_spline); % �ϕ���
    Para.ode_Event = @(t,q) Events(t,q,Para.constants); %�C�x���g�̊Ǘ�
    Para.Objective_Fcn = @(time, q, breakNum, ActivatingRate_index) ObjectiveFcn_OnlySpin(time, q, Para.constants, Para.Spin_num_Goal, breakNum, ActivatingRate_index, Para.Data_Set_Time); % �]�����@
    %}
    
    % ���s�_�}�C�i�X�ψʂ���
    %{/
    Para.Mode_String = '���s�_�}�C�i�X�ψʂ���';
    Para.Spin_num_Goal = 1.5; % �]���l�Ɋւ���
    Para.ode_Fcn = @(t,q,ActivatingRate_spline) ddt_ActivatingRate(t, q, Para.constants, ActivatingRate_spline); % �ϕ���
    Para.ode_Event = @(t,q) Events_Non_rPB(t,q,Para.constants); %�C�x���g�̊Ǘ�
    Para.Objective_Fcn = @(time, q, breakNum, ActivatingRate_index) ObjectiveFcn_OnlySpin(time, q, Para.constants, Para.Spin_num_Goal, breakNum, ActivatingRate_index, Para.Data_Set_Time); % �]�����@
    %}
    
    % �^���O�̍��̋��ȂȂ��̐�������
    %{
    Para.Mode_String = '�^���O�̍��̋��ȂȂ��̐�������';
    Para.Spin_num_Goal = 1.5; % �]���l�Ɋւ���
    Para.ode_Fcn = @(t,q,ActivatingRate_spline) ddt_ActivatingRate(t, q, Para.constants, ActivatingRate_spline); % �ϕ���
    Para.ode_Event = @(t,q) Events_thWaistLimited_AtHorizon(t,q,Para.constants); %�C�x���g�̊Ǘ�
    Para.Objective_Fcn = @(time, q, breakNum, ActivatingRate_index) ObjectiveFcn_OnlySpin(time, q, Para.constants, Para.Spin_num_Goal, breakNum, ActivatingRate_index, Para.Data_Set_Time); % �]�����@
    %}
    
    % �^���ł̍��̊p�x�̐�������
    %{
    Para.Mode_String = '�^���ł̍��̊p�x�̐�������';
    Para.Spin_num_Goal = 1.5; % �]���l�Ɋւ���
    Para.thWaist_AtBodyUpStraight_Range = [-pi, 0]; %���̊p�x�͈̔�
    Para.ode_Fcn = @(t,q,ActivatingRate_spline) ddt_ActivatingRate(t, q, Para.constants, ActivatingRate_spline); % �ϕ���
    Para.ode_Event = @(t,q) Events(t,q,Para.constants); %�C�x���g�̊Ǘ�
    Para.Objective_Fcn = @(time, q, breakNum, ActivatingRate_index) ObjectiveFcn_OnlySpin_WithJL_thWaist(time, q, Para.constants, Para.Spin_num_Goal, breakNum, ActivatingRate_index, Para.Data_Set_Time, Para.thWaist_AtBodyUpStraight_Range); % �]�����@
    %}
    
    % value_phase2 �� value_phase3 �ɐ�������
    %{
    Para.Mode_String = 'value_phase2 �� value_phase3 �ɐ�������';
    Para.Spin_num_Goal = 1.5; % �]���l�Ɋւ���
    Para.thWaist_AtBodyUpStraight_Range = [-pi, 0]; %���̊p�x�͈̔�
    Para.Value_phase2_Range = [0.9, 1.0];
    Para.Value_phase3_Range = [0, 0.4];
    Para.ode_Fcn = @(t,q,ActivatingRate_spline) ddt_ActivatingRate(t, q, Para.constants, ActivatingRate_spline); % �ϕ���
    Para.ode_Event = @(t,q) Events(t,q,Para.constants); %�C�x���g�̊Ǘ�
    Para.Objective_Fcn = @(time, q, breakNum, ActivatingRate_index) ObjectiveFcn_OnlySpin_ValueLimit(time, q, Para.constants, Para.Spin_num_Goal, breakNum, ActivatingRate_index, Para.Data_Set_Time, Para.Value_phase2_Range, Para.Value_phase3_Range); % �]�����@
    %}
    
    % value_phase2 �ō������Ȃ����铮�����������Ȃ���������
    %{
    Para.Mode_String = 'value_phase2 �ō������Ȃ����铮�����������Ȃ���������';
    Para.Spin_num_Goal = 1.5; % �]���l�Ɋւ���
    Para.ode_Fcn = @(t,q,ActivatingRate_spline) ddt_ActivatingRate(t, q, Para.constants, ActivatingRate_spline); % �ϕ���
    Para.ode_Event = @(t,q) Events(t,q,Para.constants); %�C�x���g�̊Ǘ�
    Para.Objective_Fcn = @(time, q, breakNum, ActivatingRate_index) ObjectiveFcn_OnlySpin_NonBent_AtPhase2(time, q, Para.constants, Para.Spin_num_Goal, breakNum, ActivatingRate_index, Para.Data_Set_Time); % �]�����@
    %}
    
    % value_phase3 �ō���L�W�����铮�����������Ȃ���������
    %{
    Para.Mode_String = 'value_phase3 �ō������Ȃ����铮�����������Ȃ���������';
    Para.Spin_num_Goal = 1.5; % �]���l�Ɋւ���
    Para.ode_Fcn = @(t,q,ActivatingRate_spline) ddt_ActivatingRate(t, q, Para.constants, ActivatingRate_spline); % �ϕ���
    Para.ode_Event = @(t,q) Events(t,q,Para.constants); %�C�x���g�̊Ǘ�
    Para.Objective_Fcn = @(time, q, breakNum, ActivatingRate_index) ObjectiveFcn_OnlySpin_NonStrech_AtPhase3(time, q, Para.constants, Para.Spin_num_Goal, breakNum, ActivatingRate_index, Para.Data_Set_Time); % �]�����@
    %}
    
    % value_phase3 �ō���L�W�����铮�����������Ȃ���������ver2
    %{
    Para.Mode_String = 'value_phase3 �ō������Ȃ����铮�����������Ȃ���������ver2';
    Para.Spin_num_Goal = 1.5; % �]���l�Ɋւ���
    Para.ode_Fcn = @(t,q,ActivatingRate_spline) ddt_ActivatingRate(t, q, Para.constants, ActivatingRate_spline); % �ϕ���
    Para.ode_Event = @(t,q) Events(t,q,Para.constants); %�C�x���g�̊Ǘ�
    Para.Objective_Fcn = @(time, q, breakNum, ActivatingRate_index) ObjectiveFcn_OnlySpin_NonStrech_AtPhase3_2(time, q, Para.constants, Para.Spin_num_Goal, breakNum, ActivatingRate_index, Para.Data_Set_Time); % �]�����@
    %}
    
    % value_phase3 �ō���L�W�����铮�����������Ȃ���������ver3
    %{
    Para.Mode_String = 'value_phase3 �ō������Ȃ����铮�����������Ȃ���������ver3';
    Para.Spin_num_Goal = 1.5; % �]���l�Ɋւ���
    Para.ode_Fcn = @(t,q,ActivatingRate_spline) ddt_ActivatingRate(t, q, Para.constants, ActivatingRate_spline); % �ϕ���
    Para.ode_Event = @(t,q) Events(t,q,Para.constants); %�C�x���g�̊Ǘ�
    Para.Objective_Fcn = @(time, q, breakNum, ActivatingRate_index) ObjectiveFcn_OnlySpin_NonStrech_AtPhase3_3(time, q, Para.constants, Para.Spin_num_Goal, breakNum, ActivatingRate_index, Para.Data_Set_Time); % �]�����@
    %}
end

% Para.ifstop = true;
Para.ifstop = false;

Para = optimization(Para);

savePara(Para)






































