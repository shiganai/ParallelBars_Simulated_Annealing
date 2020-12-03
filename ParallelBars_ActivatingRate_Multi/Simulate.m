
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
    % 世代、個体にかんして
    Para.pop_num = 12 * 1e2 * 1; %個体数
    Para.save_pop_num = Para.pop_num; %保存する数
    Para.not_reset_pop_num = 4;
    % Para.gen_num = 2e4; %世代数
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
    Para.constants = struct(constants_HH_AE_Hand_Weakened);
    Para.q0 = generate_q0(Para.constants);
    Para.Data_Set_Time = (0:5e-2:1.4)';
    Para.Joint_num = 3;
    Para.ActivatingRate_Step_num = 10; % 1/30刻みで活性率を決める
    Para.mutation_max_ratio = 5;
    Para.Base_Transition_Probability = 5; %0から1に遷移するパーセント
    Para.Max_Transition_Probability = 97; %焼きなまし開始時に0から1に遷移するパーセント
    Para.ifResetAll = false;
    
    % 初期値の設定
    Para = generate_init_ActivatingRate(Para);
%     Para = load_and_fit_init_Mdatas(Para, 'Para_1025173328_pop_2400_gen_6595', 2400);
    
    % 積分の細かさに関して
    Para.odeTime = 0:1e-3:1.4;
    Para.absTol = 1e-6;
    
    % 制限の管理
    
    % 制限無し
    %{
    Para.Mode_String = '制限なし';
    Para.Spin_num_Goal = 1.5; % 評価値に関して
    Para.ode_Fcn = @(t,q,ActivatingRate_spline) ddt_ActivatingRate(t, q, Para.constants, ActivatingRate_spline); % 積分式
    Para.ode_Event = @(t,q) Events(t,q,Para.constants); %イベントの管理
    Para.Objective_Fcn = @(time, q, breakNum, ActivatingRate_index) ObjectiveFcn_OnlySpin(time, q, Para.constants, Para.Spin_num_Goal, breakNum, ActivatingRate_index, Para.Data_Set_Time); % 評価方法
    %}
    
    % 平行棒マイナス変位あり
    %{/
    Para.Mode_String = '平行棒マイナス変位あり';
    Para.Spin_num_Goal = 1.5; % 評価値に関して
    Para.ode_Fcn = @(t,q,ActivatingRate_spline) ddt_ActivatingRate(t, q, Para.constants, ActivatingRate_spline); % 積分式
    Para.ode_Event = @(t,q) Events_Non_rPB(t,q,Para.constants); %イベントの管理
    Para.Objective_Fcn = @(time, q, breakNum, ActivatingRate_index) ObjectiveFcn_OnlySpin(time, q, Para.constants, Para.Spin_num_Goal, breakNum, ActivatingRate_index, Para.Data_Set_Time); % 評価方法
    %}
    
    % 真下前の腰の屈曲なしの制限あり
    %{
    Para.Mode_String = '真下前の腰の屈曲なしの制限あり';
    Para.Spin_num_Goal = 1.5; % 評価値に関して
    Para.ode_Fcn = @(t,q,ActivatingRate_spline) ddt_ActivatingRate(t, q, Para.constants, ActivatingRate_spline); % 積分式
    Para.ode_Event = @(t,q) Events_thWaistLimited_AtHorizon(t,q,Para.constants); %イベントの管理
    Para.Objective_Fcn = @(time, q, breakNum, ActivatingRate_index) ObjectiveFcn_OnlySpin(time, q, Para.constants, Para.Spin_num_Goal, breakNum, ActivatingRate_index, Para.Data_Set_Time); % 評価方法
    %}
    
    % 真下での腰の角度の制限あり
    %{
    Para.Mode_String = '真下での腰の角度の制限あり';
    Para.Spin_num_Goal = 1.5; % 評価値に関して
    Para.thWaist_AtBodyUpStraight_Range = [-pi, 0]; %腰の角度の範囲
    Para.ode_Fcn = @(t,q,ActivatingRate_spline) ddt_ActivatingRate(t, q, Para.constants, ActivatingRate_spline); % 積分式
    Para.ode_Event = @(t,q) Events(t,q,Para.constants); %イベントの管理
    Para.Objective_Fcn = @(time, q, breakNum, ActivatingRate_index) ObjectiveFcn_OnlySpin_WithJL_thWaist(time, q, Para.constants, Para.Spin_num_Goal, breakNum, ActivatingRate_index, Para.Data_Set_Time, Para.thWaist_AtBodyUpStraight_Range); % 評価方法
    %}
    
    % value_phase2 と value_phase3 に制限あり
    %{
    Para.Mode_String = 'value_phase2 と value_phase3 に制限あり';
    Para.Spin_num_Goal = 1.5; % 評価値に関して
    Para.thWaist_AtBodyUpStraight_Range = [-pi, 0]; %腰の角度の範囲
    Para.Value_phase2_Range = [0.9, 1.0];
    Para.Value_phase3_Range = [0, 0.4];
    Para.ode_Fcn = @(t,q,ActivatingRate_spline) ddt_ActivatingRate(t, q, Para.constants, ActivatingRate_spline); % 積分式
    Para.ode_Event = @(t,q) Events(t,q,Para.constants); %イベントの管理
    Para.Objective_Fcn = @(time, q, breakNum, ActivatingRate_index) ObjectiveFcn_OnlySpin_ValueLimit(time, q, Para.constants, Para.Spin_num_Goal, breakNum, ActivatingRate_index, Para.Data_Set_Time, Para.Value_phase2_Range, Para.Value_phase3_Range); % 評価方法
    %}
    
    % value_phase2 で腰を屈曲させる動員率を持たない制限あり
    %{
    Para.Mode_String = 'value_phase2 で腰を屈曲させる動員率を持たない制限あり';
    Para.Spin_num_Goal = 1.5; % 評価値に関して
    Para.ode_Fcn = @(t,q,ActivatingRate_spline) ddt_ActivatingRate(t, q, Para.constants, ActivatingRate_spline); % 積分式
    Para.ode_Event = @(t,q) Events(t,q,Para.constants); %イベントの管理
    Para.Objective_Fcn = @(time, q, breakNum, ActivatingRate_index) ObjectiveFcn_OnlySpin_NonBent_AtPhase2(time, q, Para.constants, Para.Spin_num_Goal, breakNum, ActivatingRate_index, Para.Data_Set_Time); % 評価方法
    %}
    
    % value_phase3 で腰を伸展させる動員率を持たない制限あり
    %{
    Para.Mode_String = 'value_phase3 で腰を屈曲させる動員率を持たない制限あり';
    Para.Spin_num_Goal = 1.5; % 評価値に関して
    Para.ode_Fcn = @(t,q,ActivatingRate_spline) ddt_ActivatingRate(t, q, Para.constants, ActivatingRate_spline); % 積分式
    Para.ode_Event = @(t,q) Events(t,q,Para.constants); %イベントの管理
    Para.Objective_Fcn = @(time, q, breakNum, ActivatingRate_index) ObjectiveFcn_OnlySpin_NonStrech_AtPhase3(time, q, Para.constants, Para.Spin_num_Goal, breakNum, ActivatingRate_index, Para.Data_Set_Time); % 評価方法
    %}
    
    % value_phase3 で腰を伸展させる動員率を持たない制限ありver2
    %{
    Para.Mode_String = 'value_phase3 で腰を屈曲させる動員率を持たない制限ありver2';
    Para.Spin_num_Goal = 1.5; % 評価値に関して
    Para.ode_Fcn = @(t,q,ActivatingRate_spline) ddt_ActivatingRate(t, q, Para.constants, ActivatingRate_spline); % 積分式
    Para.ode_Event = @(t,q) Events(t,q,Para.constants); %イベントの管理
    Para.Objective_Fcn = @(time, q, breakNum, ActivatingRate_index) ObjectiveFcn_OnlySpin_NonStrech_AtPhase3_2(time, q, Para.constants, Para.Spin_num_Goal, breakNum, ActivatingRate_index, Para.Data_Set_Time); % 評価方法
    %}
    
    % value_phase3 で腰を伸展させる動員率を持たない制限ありver3
    %{
    Para.Mode_String = 'value_phase3 で腰を屈曲させる動員率を持たない制限ありver3';
    Para.Spin_num_Goal = 1.5; % 評価値に関して
    Para.ode_Fcn = @(t,q,ActivatingRate_spline) ddt_ActivatingRate(t, q, Para.constants, ActivatingRate_spline); % 積分式
    Para.ode_Event = @(t,q) Events(t,q,Para.constants); %イベントの管理
    Para.Objective_Fcn = @(time, q, breakNum, ActivatingRate_index) ObjectiveFcn_OnlySpin_NonStrech_AtPhase3_3(time, q, Para.constants, Para.Spin_num_Goal, breakNum, ActivatingRate_index, Para.Data_Set_Time); % 評価方法
    %}
end

% Para.ifstop = true;
Para.ifstop = false;

Para = optimization(Para);

savePara(Para)






































