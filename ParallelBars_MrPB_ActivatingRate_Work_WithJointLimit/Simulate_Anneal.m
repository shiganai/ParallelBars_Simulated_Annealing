
figure(100)
hold off
plot(0,0)
xlabel('世代数')
ylabel('評価値(低いほど良い)')
drawnow
clear all

%世代、個体にかんして
Para.pop_num = 24*1e2 * 1; %個体数
Para.save_pop_num = Para.pop_num; %保存する数
% Para.reset_gen_num = 60;
Para.Annealing_gen_Range = 20;
Para.gen_num = Para.Annealing_gen_Range + 1; %世代数
Para.No_Gain_gen_Threshold = 10;
% Para.No_Gain_pop_num_ratio = 0.0; %評価値が上がった動作が全体のこの割合を下回ると、焼きなましカウントが増える
Para.Average_Range = 300;
Para.Mean_Std_Threshold = 0.4/1200; %Average_Rangeが300で1200個体に対して0.4の平均の標準偏差。optimizationでMean_Stdを出すときにpop_numで割って全体に対するcountの割合を出してあげる。

if Para.save_pop_num > Para.pop_num
    Para.save_pop_num = Para.pop_num;
end

%データに関して
Para = SetParaConstants(Para, constants_HH);
Para.q0 = generate_q0(Para.constants);
Para.Time_Limit = 2;
Para.Joint_num = 3;
Para.Omega_max = [10, 10, 10]';
Para.ExtreamPoint_num_max = 15;
Para.Time_step_num = 30;
Para.Omega_step_num = 10; %角速度を何等分するか
Para.mutation_max_ratio = 5;
% Para.Base_Beta_Transition = 4.6052; %0から111に遷移する確率はBeta_Transition = 0.0062で50%, 0.0207で10%, 0.0415で1%。0から1に遷移する確率は0.0415で95%, 2.3026で10%, 4.6052で1%
% Para.Min_Beta_Transition = 0.0207; %小さいほど評価関数の値が高い方にも良く遷移する。
Para.Base_Transition_Probability = 1; %0から1に遷移するパーセント
Para.Max_Transition_Probability = 99; %焼きなまし開始時に0から1に遷移するパーセント
Para.ifResetAll = false;

%初期値の設定
Para = load_and_fit_init_Mdatas(Para, 'Para_0524161726_pop_2400_gen_2795', 2400);


%積分に関して
Para.odeTime = 0:1e-3:2;
Para.absTol = 1e-6;
Para.odeEvent = @(t,q,ddpp_time_histories)Events(t,q,Para.constants,ddpp_time_histories);
% Para.odeEvent = @(t,q,ddpp_time_histories)Events2(t,q,Para.constants,ddpp_time_histories);
% Para.odeEvent = @(t,q)Events(t,q,Para.constants);
% Para.odeEvent = @(t,q)Events_NoneJointLimit(t,q,Para.constants);

Para.ifstop = false;
Para = optimization_Anneal(Para);

savePara_Anneal(Para)















































