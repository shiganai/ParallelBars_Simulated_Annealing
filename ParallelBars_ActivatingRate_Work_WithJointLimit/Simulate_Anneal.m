
figure(100)
hold off
plot(0,0)
xlabel('���㐔')
ylabel('�]���l(�Ⴂ�قǗǂ�)')
drawnow
clear all

%����A�̂ɂ��񂵂�
Para.pop_num = 24*1e2 * 1; %�̐�
Para.save_pop_num = Para.pop_num; %�ۑ����鐔
% Para.reset_gen_num = 60;
Para.Annealing_gen_Range = 20;
Para.gen_num = Para.Annealing_gen_Range + 1; %���㐔
Para.No_Gain_gen_Threshold = 10;
% Para.No_Gain_pop_num_ratio = 0.0; %�]���l���オ�������삪�S�̂̂��̊����������ƁA�Ă��Ȃ܂��J�E���g��������
Para.Average_Range = 300;
Para.Mean_Std_Threshold = 0.4/1200; %Average_Range��300��1200�̂ɑ΂���0.4�̕��ς̕W���΍��Boptimization��Mean_Std���o���Ƃ���pop_num�Ŋ����đS�̂ɑ΂���count�̊������o���Ă�����B

if Para.save_pop_num > Para.pop_num
    Para.save_pop_num = Para.pop_num;
end

%�f�[�^�Ɋւ���
Para = SetParaConstants(Para, constants_HH);
Para.q0 = generate_q0(Para.constants);
Para.Time_Limit = 2;
Para.Joint_num = 3;
Para.Omega_max = [10, 10, 10]';
Para.ExtreamPoint_num_max = 15;
Para.Time_step_num = 30;
Para.Omega_step_num = 10; %�p���x�����������邩
Para.mutation_max_ratio = 5;
% Para.Base_Beta_Transition = 4.6052; %0����111�ɑJ�ڂ���m����Beta_Transition = 0.0062��50%, 0.0207��10%, 0.0415��1%�B0����1�ɑJ�ڂ���m����0.0415��95%, 2.3026��10%, 4.6052��1%
% Para.Min_Beta_Transition = 0.0207; %�������قǕ]���֐��̒l���������ɂ��ǂ��J�ڂ���B
Para.Base_Transition_Probability = 1; %0����1�ɑJ�ڂ���p�[�Z���g
Para.Max_Transition_Probability = 99; %�Ă��Ȃ܂��J�n����0����1�ɑJ�ڂ���p�[�Z���g
Para.ifResetAll = false;

%�����l�̐ݒ�
Para = load_and_fit_init_Mdatas(Para, 'Para_0524161726_pop_2400_gen_2795', 2400);


%�ϕ��Ɋւ���
Para.odeTime = 0:1e-3:2;
Para.absTol = 1e-6;
Para.odeEvent = @(t,q,ddpp_time_histories)Events(t,q,Para.constants,ddpp_time_histories);
% Para.odeEvent = @(t,q,ddpp_time_histories)Events2(t,q,Para.constants,ddpp_time_histories);
% Para.odeEvent = @(t,q)Events(t,q,Para.constants);
% Para.odeEvent = @(t,q)Events_NoneJointLimit(t,q,Para.constants);

Para.ifstop = false;
Para = optimization_Anneal(Para);

savePara_Anneal(Para)















































