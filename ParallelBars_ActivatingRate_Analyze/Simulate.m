
clear all

Para.IfScat = 0;
if Para.IfScat
    figure(100)
    hold off
    plot(0,0)
    drawnow
end


% ����A�̂ɂ��񂵂�
Para.pop_num = 24 * 1e2 * 1; %�̐�
Para.save_pop_num = Para.pop_num; %�ۑ����鐔
Para.not_reset_pop_num = 4;
Para.gen_num = 2e4; %���㐔
Para.Reset_Annealing_Count_Threshold = 4;
Para.Save_Reset_Count_Threshold = 0;
Para.Annealing_gen = 4;
Para.No_Gain_gen_Threshold = 10;
% Para.No_Gain_pop_num_ratio = 0.0; %�]���l���オ�������삪�S�̂̂��̊����������ƁA�Ă��Ȃ܂��J�E���g��������
Para.Average_Range = 300;
Para.Mean_Std_Threshold = 0.4/1200; %Average_Range��300��1200�̂ɑ΂���0.4�̕��ς̕W���΍��Boptimization��Mean_Std���o���Ƃ���pop_num�Ŋ����đS�̂ɑ΂���count�̊������o���Ă�����B

if Para.save_pop_num > Para.pop_num
    Para.save_pop_num = Para.pop_num;
end


% �f�[�^�Ɋւ���
Para.constants = struct(constants_Yeadon);
Para.q0 = generate_q0(Para.constants);
Para.Data_Set_Time = (0:5e-2:2)';
Para.Joint_num = 3;
Para.ActivatingRate_Step_num = 10; % 1/30���݂Ŋ����������߂�
Para.mutation_max_ratio = 5;
Para.Base_Transition_Probability = 1; %0����1�ɑJ�ڂ���p�[�Z���g
Para.Max_Transition_Probability = 99; %�Ă��Ȃ܂��J�n����0����1�ɑJ�ڂ���p�[�Z���g
Para.ifResetAll = false;

% �]���l�Ɋւ���
Para.Spin_num_Goal = 1.0;

% �����l�̐ݒ�
% Para = generate_init_ActivatingRate(Para);
Para = load_and_fit_init_Mdatas(Para, 'MidtermPara', 2400);


% �ϕ��Ɋւ���
Para.odeTime = 0:1e-3:2;
Para.absTol = 1e-6;
Para.odeEvent = @(t,q)Events(t,q,Para.constants);
% Para.odeEvent = @(t,q,ddpp_time_histories)Events2(t,q,Para.constants,ddpp_time_histories);
% Para.odeEvent = @(t,q)Events(t,q,Para.constants);
% Para.odeEvent = @(t,q)Events_NoneJointLimit(t,q,Para.constants);

% Para.ifstop = true;
Para.ifstop = false;
Para = optimization(Para);

savePara(Para)





































