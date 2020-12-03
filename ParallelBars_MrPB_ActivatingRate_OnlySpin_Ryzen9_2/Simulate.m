
clear all

Para.IfScat = 0;
if Para.IfScat
    figure(100)
    hold off
    plot(0,0)
    drawnow
end


% 世代、個体にかんして
Para.pop_num = 24 * 1e2 * 1; %個体数
Para.save_pop_num = Para.pop_num; %保存する数
Para.not_reset_pop_num = 4;
Para.gen_num = 2e4; %世代数
Para.Reset_Annealing_Count_Threshold = 4;
Para.Save_Reset_Count_Threshold = 0;
Para.Annealing_gen = 4;
Para.No_Gain_gen_Threshold = 10;
% Para.No_Gain_pop_num_ratio = 0.0; %評価値が上がった動作が全体のこの割合を下回ると、焼きなましカウントが増える
Para.Average_Range = 300;
Para.Mean_Std_Threshold = 1e-4; %Average_Rangeが300で1200個体に対して0.4の平均の標準偏差。optimizationでMean_Stdを出すときにpop_numで割って全体に対するcountの割合を出してあげる。

if Para.save_pop_num > Para.pop_num
    Para.save_pop_num = Para.pop_num;
end


% データに関して
Para.constants = struct(constants_Yeadon);
Para.q0 = generate_q0(Para.constants);
% Para.thWaist_AtBodyUpStraight_Range = [-pi, pi];
Para.Data_Set_Time = (0:5e-2:1.4)';
Para.Joint_num = 3;
Para.ActivatingRate_Step_num = 10; % 1/30刻みで活性率を決める
Para.mutation_max_ratio = 5;
Para.Base_Transition_Probability = 5; %0から1に遷移するパーセント
Para.Max_Transition_Probability = 97; %焼きなまし開始時に0から1に遷移するパーセント
Para.ifResetAll = false;

% 評価値に関して
Para.Spin_num_Goal = 1.5;

% 初期値の設定
Para = generate_init_ActivatingRate(Para);
% Para = load_and_fit_init_Mdatas(Para, 'Para_0721130430_pop_1000_gen_4377', 2400);


% 積分に関して
Para.odeTime = 0:1e-3:1.4;
Para.absTol = 1e-6;
Para.odeEvent = @(t,q)Events(t,q,Para.constants);
% Para.odeEvent = @(t,q,ddpp_time_histories)Events2(t,q,Para.constants,ddpp_time_histories);
% Para.odeEvent = @(t,q)Events(t,q,Para.constants);
% Para.odeEvent = @(t,q)Events_NoneJointLimit(t,q,Para.constants);

% Para.ifstop = true;
Para.ifstop = false;
Para = optimization(Para);

savePara(Para)






































