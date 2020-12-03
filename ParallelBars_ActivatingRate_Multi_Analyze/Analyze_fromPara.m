clear all


% DataNames = {'Para_0914102653_pop_2400_gen_11784'};
DataNames = {'Para_0909114047_pop_2400_gen_16454_2';
    'Para_0914102653_pop_2400_gen_11784';
    'Para_0921094031_pop_2400_gen_13189';
    'Para_0926025811_pop_2400_gen_11904';
    'Para_0928195747_pop_2400_gen_5082';
    'Para_1004192713_pop_2400_gen_15865';
    'Para_1004192843_pop_2400_gen_19683';
    'Para_1008172649_pop_2400_gen_22945';
    };

%{
DataNames = ...
    {
    'Para_0728230411_pop_1000_gen_3000'; % 0.9 ~ 1.0
    'Para_0728164900_pop_1000_gen_3000'; % 0.8 ~ 0.9
    'Para_0728200225_pop_1000_gen_3000'; % 0.7 ~ 0.8
    'Para_0728095857_pop_1000_gen_3000'; % 0.6 ~ 0.7
    'Para_0723194555_pop_1000_gen_2978'; % 0.5 ~ 0.6
    'Para_0729101336_pop_1000_gen_3000'; % 0.4 ~ 0.5
    'Para_0724182530_pop_1000_gen_3057'; % 0.3 ~ 0.4
    'Para_0729193844_pop_1000_gen_3000'; % 0.2 ~ 0.3
    'Para_0725203010_pop_1000_gen_3059'; % 0.1 ~ 0.2
    'Para_0729230026_pop_1000_gen_3000'; % 0.0 ~ 0.1
    'Para_0726171807_pop_1000_gen_3087'; % -0.1 ~ -0.0
    'Para_0730021055_pop_1000_gen_3000'; % -0.2 ~ -0.1
    'Para_0726003002_pop_1000_gen_3503'; % -0.3 ~ -0.2
    'Para_0725164842_pop_1000_gen_3036'; % -0.4 ~ -0.3
    'Para_0726204409_pop_1000_gen_3000'; % -0.5 ~ -0.4
    'Para_0724222045_pop_1000_gen_3002'; % -0.6 ~ -0.5
    'Para_0727182307_pop_1000_gen_3000'; % -0.7 ~ -0.6
    'Para_0727214814_pop_1000_gen_3000'; % -0.8 ~ -0.7
    'Para_0728005101_pop_1000_gen_3000'; % -0.9 ~ -0.8
    'Para_0728070012_pop_1000_gen_3000'; % -1.0 ~ -0.9
    };
%}

% newcolors = {'blue','red', 'green', 'magenta', 'black'};
newcolors = 'default';

IfIsoutlier = 0;

MinThHand_Together = [];
MaxDthShoulder_Together = [];
MinThWaist_Together = [];

thWaist_AtBodyUpStraight_Together = [];
thWaist_AtBodyHorizon_Together = [];

thBodyDifference_Together = [];

time_AtBodyUpStraight_Together = [];
time_AtBodyHorizon_Together = [];
time_AtMinThWaist_Together = [];

Spin_num_Together = [];
Time_Until_Landing_Together = [];
Height_Together = [];
MomentumG_Together = [];
OmegaG_Together = [];

Work_Total_Together = [];

Value_phase2_Together = [];
Value_phase3_Together = [];

Mode_Name = "";
Mode_Number_Together = [];

for Data_Number = 1:size(DataNames,1)
%     Data_Index_Range = (1:2400)';
    
    load(DataNames{Data_Number,1})
    Para.thWaist_AtBodyUpStraight_Range = [-pi, pi];
    
    ActivatingRate = Para.ActivatingRate;
    ObjectiveValueDatas = Para.ObjectiveValueDatas;
    
%     ActivatingRate = Para.Before_Annealing_ActivatingRate;
%     ObjectiveValueDatas = Para.Before_Annealing_ObjectiveValueDatas;
    
    constants = Para.constants;
    
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
    
    
    Data_Set_Time = Para.Data_Set_Time;
    t = Para.odeTime;
    % t = 0:1e-4:4;
    q0 = Para.q0;
%     odeEvent = Para.odeEvent;
    absTol = Para.absTol;
    % absTol = 1e-8;
    Spin_num_Goal = Para.Spin_num_Goal;
    % Spin_num_Goal = 1.2;
    thWaist_AtBodyUpStraight_Range = Para.thWaist_AtBodyUpStraight_Range;
    
    ode_Fcn = Para.ode_Fcn;
    ode_Event = Para.ode_Event;
    Objective_Fcn = Para.Objective_Fcn;

%     PerformedWell_Index = find((ObjectiveValueDatas(:,2) >= 0.00)...
%         .* (ObjectiveValueDatas(:,2) <= 100-84.15));

    PerformedWell_Index = 1:200;
%     PerformedWell_Index = 1:2400;
    
%     if size(PerformedWell_Index,1) < Data_Index_Range(end)
%         Data_Index_Range = 1:size(PerformedWell_Index,1);
%     end
    
    ActivatingRate = ActivatingRate(PerformedWell_Index,:,:);
    ObjectiveValueDatas = ObjectiveValueDatas(PerformedWell_Index,:);
    
%     ActivatingRate = ActivatingRate(Data_Index_Range,:,:);
%     ObjectiveValueDatas = ObjectiveValueDatas(Data_Index_Range, :);
    
    PerformedWell_num = size(ObjectiveValueDatas,1);
    
    MinThHand = zeros([PerformedWell_num, 1]);
    MaxDthShoulder = zeros([PerformedWell_num, 1]);
    MinThWaist = zeros([PerformedWell_num, 1]);
    
    thWaist_AtBodyUpStraight = zeros([PerformedWell_num, 1]);
    thWaist_AtBodyHorizon = zeros([PerformedWell_num, 1]);
    
    thBodyDifference = zeros([PerformedWell_num, 1]);
    
    time_AtBodyUpStraight = zeros([PerformedWell_num, 1]);
    time_AtBodyHorizon = zeros([PerformedWell_num, 1]);
    time_AtMinThWaist = zeros([PerformedWell_num, 1]);
    
    Spin_num = zeros([PerformedWell_num, 1]);
    Time_Until_Landing = zeros([PerformedWell_num, 1]);
    Height = zeros([PerformedWell_num, 1]);
    MomentumG = zeros([PerformedWell_num, 1]);
    OmegaG = zeros([PerformedWell_num, 1]);
    
    Work_Total = zeros([PerformedWell_num, 1]);
    
    Value_phase2 = zeros([PerformedWell_num, 1]);
    Value_phase3 = zeros([PerformedWell_num, 1]);
    
    tic
    parfor index = 1:PerformedWell_num
        
        ActivatingRate_index = [reshape(ActivatingRate(index,1,:), size(Data_Set_Time)), reshape(ActivatingRate(index,2,:), size(Data_Set_Time)), reshape(ActivatingRate(index,3,:), size(Data_Set_Time))];
        
        MthHand_ActivatingRate_spline = spline(Data_Set_Time, ActivatingRate_index(:,1));
        MthShoulder_ActivatingRate_spline = spline(Data_Set_Time, ActivatingRate_index(:,2));
        MthWaist_ActivatingRate_spline = spline(Data_Set_Time, ActivatingRate_index(:,3));
        
        ActivatingRate_spline = [MthHand_ActivatingRate_spline, MthShoulder_ActivatingRate_spline, MthWaist_ActivatingRate_spline]';
        
        ode = @(t, q) ode_Fcn(t, q, ActivatingRate_spline);
        
        odeOption = odeset('Events', ode_Event, 'AbsTol', absTol);
        
        [time_onbar, q, ~, ~, ie] = ode45(ode, t, q0, odeOption);
        time = time_onbar;
        
        if ~isempty(ie)
            breakNum = ie(end);
        else
            breakNum = 0;
        end
        
        ObjectiveValueData = Objective_Fcn(time_onbar, q, breakNum, ActivatingRate_index);


        rPB = q(:,1);
        thHand = q(:,2);
        thShoulder = q(:,3);
        thWaist = q(:,4);
        drPB = q(:,5);
        dthHand = q(:,6);
        dthShoulder = q(:,7);
        dthWaist = q(:,8);
        
        ddrPB = fnval(fnder(spline(time, drPB)), time);
        ddthHand = fnval(fnder(spline(time, dthHand)), time);
        ddthShoulder = fnval(fnder(spline(time, dthShoulder)), time);
        ddthWaist = fnval(fnder(spline(time, dthWaist)), time);
        
        %{
        yHand = rPB(:,1);
        xHand = zeros(size(yHand));
        dyHand = drPB(:,1);
        dxHand = zeros(size(dyHand));
        %}
        
        MinThHand(index,1) = min(thHand);
        MaxDthShoulder(index,1) = max(dthShoulder);
        [MinThWaist(index,1), index_AtMinThWaist] = min(thWaist);
        
        time_AtMinThWaist(index, 1) = time(index_AtMinThWaist,1);
        
        time_AtBodyUpStraight(index, 1) = interp1(thHand+1/2*pi + thShoulder, time, 3/2*pi);
        thWaist_AtBodyUpStraight(index, 1) = interp1(time, thWaist, time_AtBodyUpStraight(index, 1));
        
        time_AtBodyUpStraight(index, 1) = interp1(thHand+1/2*pi + thShoulder, time, 3/2*pi);
        thWaist_AtBodyUpStraight(index, 1) = interp1(time, thWaist, time_AtBodyUpStraight(index, 1));
        
        time_AtBodyHorizon(index, 1) = interp1(thHand+1/2*pi + thShoulder, time, 2/2*pi);
        thWaist_AtBodyHorizon(index, 1) = interp1(time, thWaist, time_AtBodyHorizon(index, 1));
        
        thBodyDifference(index, 1) = thHand(index_AtMinThWaist,1)+1/2*pi + thShoulder(index_AtMinThWaist,1) - 3/2*pi;
        
        yHand = rPB(:,1);
        xHand = zeros(size(yHand));
        dyHand = drPB(:,1);
        dxHand = zeros(size(dyHand));
        
        pG = find_pG(mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist,xHand,yHand);
        vG = find_vG(dthHand,dthWaist,dthShoulder,dxHand,dyHand,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
        momentumG = find_momentumG(InertiaLeg,InertiaArm,InertiaBody,dthHand,dthWaist,dthShoulder,dxHand,dyHand,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist,xHand,yHand);
        
        Fx_Hand = find_Fx_Hand(ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
        Fy_Hand = find_Fy_Hand(ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
        
        height = pG(end,2) + vG(end,2)^2/(2*g) + 1.8 - rLeg;
        time_until_landing = vG(end,2)/g + (2*height/g)^0.5; %vG(end,2)‚ªƒ}ƒCƒiƒX‚¾‚Á‚½ê‡‚Å‚à‘åä•v
        omegaG = momentumG(end)/InertiaG;
        
        Height(index, 1) = height;
        MomentumG(index, 1) = omegaG;
        Spin_num(index, 1) = time_until_landing * omegaG /(2*pi);
        Time_Until_Landing(index, 1) = time_until_landing;
        OmegaG(index, 1) = omegaG/(2*pi);
        
        MthHand = find_MthHand(InertiaLeg,InertiaArm,InertiaBody,ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
        MthShoulder = find_MthShoulder(InertiaLeg,InertiaBody,ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,mBody,mLeg,rArm,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
        MthWaist = find_MthWaist(InertiaLeg,ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthShoulder,g,mLeg,rArm,rBody,rLegMCD,thHand,thShoulder,thWaist);
        
        Step_Time = diff(time(1:2));
        
        Power_thHand = MthHand .* dthHand;
        Power_thHand_Positive = Power_thHand(Power_thHand >= 0);
        Power_thHand_Negative = Power_thHand(Power_thHand < 0);
        Work_thHand = (sum(Power_thHand_Positive) + 0.5 * sum(abs(Power_thHand_Negative)) + sum(abs(MthHand))) * Step_Time;
        
        Power_thShoulder = MthShoulder .* dthShoulder;
        Power_thShoulder_Positive = Power_thShoulder(Power_thShoulder >= 0);
        Power_thShoulder_Negative = Power_thShoulder(Power_thShoulder < 0);
        Work_thShoulder = (sum(Power_thShoulder_Positive) + 0.5 * sum(abs(Power_thShoulder_Negative)) + sum(abs(MthShoulder))) * Step_Time;
        
        Power_thWaist = MthWaist .* dthWaist;
        Power_thWaist_Positive = Power_thWaist(Power_thWaist >= 0);
        Power_thWaist_Negative = Power_thWaist(Power_thWaist < 0);
        Work_thWaist = (sum(Power_thWaist_Positive) + 0.5 * sum(abs(Power_thWaist_Negative)) + sum(abs(MthWaist))) * Step_Time;
        
        Work_Total(index,1) = Work_thHand + Work_thShoulder + Work_thWaist;
        
        %{
    yHand = rPB(:,1);
    xHand = zeros(size(yHand));
    dyHand = drPB(:,1);
    dxHand = zeros(size(dyHand));
    
    ddrPB = ppval(fnder(spline(time_onbar, drPB)), time_onbar);
    ddthHand = ppval(fnder(spline(time_onbar, dthHand)), time_onbar);
    ddthShoulder = ppval(fnder(spline(time_onbar, dthShoulder)), time_onbar);
    ddthWaist = ppval(fnder(spline(time_onbar, dthWaist)), time_onbar);
    
    MrPB = find_MrPB(ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,kPB,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,rPB,thHand,thShoulder,thWaist);
    MthHand = find_MthHand(InertiaLeg,InertiaArm,InertiaBody,ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
    MthShoulder = find_MthShoulder(InertiaLeg,InertiaBody,ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,mBody,mLeg,rArm,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
    MthWaist = find_MthWaist(InertiaLeg,ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthShoulder,g,mLeg,rArm,rBody,rLegMCD,thHand,thShoulder,thWaist);
    
    KE = find_KE(InertiaLeg,InertiaArm,InertiaBody,dthHand,dthWaist,dthShoulder,dxHand,dyHand,g,kPB,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist,yHand);
    % dKE = find_dKE(InertiaLeg,InertiaArm,InertiaBody,ddthHand,ddthWaist,ddthShoulder,ddxHand,ddyHand,dthHand,dthWaist,dthShoulder,dxHand,dyHand,g,kPB,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist,yHand);
    dKE = ppval(fnder(spline(time_onbar, KE)), time_onbar);
    
    pHand = [xHand, yHand];
    pShoulder = pHand + rArm * [cos(thHand+1/2*pi), sin(thHand+1/2*pi)];
    pWaist = pShoulder + rBody * [cos(thHand+1/2*pi + thShoulder), sin(thHand+1/2*pi + thShoulder)];
    pToe = pWaist + rLeg * [cos(thHand+1/2*pi + thShoulder + thWaist), sin(thHand+1/2*pi + thShoulder + thWaist)];
    
    vHand = [dxHand, dyHand];
    vShoulder = vHand + rArm * [-sin(thHand+1/2*pi), cos(thHand+1/2*pi)] .* dthHand;
    vWaist = vShoulder + rBody * [-sin(thHand+1/2*pi + thShoulder), cos(thHand+1/2*pi + thShoulder)] .* (dthHand + dthShoulder);
    vToe = vWaist + rLeg * [-sin(thHand+1/2*pi + thShoulder + thWaist), cos(thHand+1/2*pi + thShoulder + thWaist)] .* (dthHand + dthShoulder + dthWaist);
    
    PrPB = MrPB .* drPB;
    PthHand = MthHand .* dthHand;
    PthShoulder = MthHand .* dthShoulder;
    PthWaist = MthWaist .* dthWaist;
    
    pG = find_pG(mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist,xHand,yHand);
    vG = find_vG(dthHand,dthWaist,dthShoulder,dxHand,dyHand,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
    momentumG = find_momentumG(dthHand,dthWaist,dthShoulder,dxHand,dyHand,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLeg,rLegMCD,thHand,thShoulder,thWaist,xHand,yHand);
        %}
        
        % ƒp[ƒg•ª‚¯
        [~, b1] = min(pG(:,1));
        phase1 = 1:b1;
        
        [~, b2] = max(Fy_Hand);
        b3 = find(Fy_Hand(1:b2,1) < Fy_Hand(1,1), 1, 'last');
        phase2 = (b1+1):b3;
        
        phase3 = (b3+1):size(time, 1);
        
        switch1 = time(b1);
        switch2 = time(b3);
        
        [a4, b4] = min(thWaist(phase2));
        [a5, b5] = max(thWaist(phase2));
        
        Value_phase2(index,1) = (a5 - a4) * abs(b5 - b4) / (b5 - b4);
        
        Value_phase3(index,1) = min(thWaist(phase3));
    end
    toc
    
    %{
    PhysicsValue = [MinThHand, MinThWaist, thWaist_AtBodyUpStraight, MaxDthShoulder, thBodyDifference, Height, MomentumG];
    TimeDifference = time_AtMinThWaist - time_AtBodyUpStraight;
    
    Average_Range_Analyze = 10;
    Average_PhysicsValue = zeros([ceil(PerformedWell_num/Average_Range_Analyze), size(PhysicsValue,2)]);
    Average_ObjectiveValueDatas = zeros([ceil(PerformedWell_num/Average_Range_Analyze), size(ObjectiveValueDatas,2)]);
    Average_TimeDifference = zeros([ceil(PerformedWell_num/Average_Range_Analyze), size(TimeDifference,2)]);
    for ii = 1:size(Average_PhysicsValue, 1)
        StartIndex_tmp = (ii-1) * Average_Range_Analyze + 1;
        StopIndex_tmp = min(ii * Average_Range_Analyze, size(PhysicsValue, 1));
        
        Average_PhysicsValue(ii, :) = mean(PhysicsValue(StartIndex_tmp:StopIndex_tmp, :));
        Average_ObjectiveValueDatas(ii, :) = mean(ObjectiveValueDatas(StartIndex_tmp:StopIndex_tmp, :));
        Average_TimeDifference(ii, :) = mean(TimeDifference(StartIndex_tmp:StopIndex_tmp, :));
    end
    
    % AllData_Matrix = [PhysicsValue, ObjectiveValueDatas, TimeDifference];
    AllData_Matrix = [PhysicsValue(:,1:4), ObjectiveValueDatas, TimeDifference, PhysicsValue(:,5), Height, MomentumG];
    corrcoefs = corrcoef(AllData_Matrix, 'Rows','complete');
    %}
    
    
    %{
    if IfIsoutlier
        TF_Height = isoutlier(Height);
        TF_Time_Until_Landing = isoutlier(Time_Until_Landing);
        TF_MomentumG = isoutlier(MomentumG);
        TF_OmegaG = isoutlier(OmegaG);
    else
        TF_Height = false([PerformedWell_num, 1]);
        TF_Time_Until_Landing = false([PerformedWell_num, 1]);
        TF_MomentumG = false([PerformedWell_num, 1]);
        TF_OmegaG = false([PerformedWell_num, 1]);
    end
    
    Spin_num_ForFit = Spin_num(~TF_Height);
    Height_ForFit = Height(~TF_Height);
    PolyFit_Height = polyfit(Spin_num_ForFit, Height_ForFit, 1);
    PolyFit_Height_Value = polyval(PolyFit_Height, Spin_num);
    
    Spin_num_ForFit = Spin_num(~TF_Time_Until_Landing);
    Time_Until_Landing_ForFit = Time_Until_Landing(~TF_Time_Until_Landing);
    PolyFit_Time_Until_Landing = polyfit(Spin_num_ForFit, Time_Until_Landing_ForFit, 1);
    PolyFit_Time_Until_Landing_Value = polyval(PolyFit_Time_Until_Landing, Spin_num);
    
    Spin_num_ForFit = Spin_num(~TF_MomentumG);
    MomentumG_ForFit = MomentumG(~TF_MomentumG);
    PolyFit_MomentumG = polyfit(Spin_num_ForFit, MomentumG_ForFit, 1);
    PolyFit_MomentumG_Value = polyval(PolyFit_MomentumG, Spin_num);
    
    Spin_num_ForFit = Spin_num(~TF_OmegaG);
    OmegaG_ForFit = OmegaG(~TF_OmegaG);
    PolyFit_OmegaG = polyfit(Spin_num_ForFit, OmegaG_ForFit, 1);
    PolyFit_OmegaG_Value = polyval(PolyFit_OmegaG, Spin_num);
    %}
    
    LegendName = Para.Mode_String;
%     LegendName = strcat("“·‘Ì‚ª‰”’¼Žž‚Ì˜Šp“x‚ª ", num2str(Para.thWaist_AtBodyUpStraight_Range(1,1)),...
%         " ` ", num2str(Para.thWaist_AtBodyUpStraight_Range(1,2)), 'rad');
%     LegendName = DataNames{Data_Number,1};
    RowDataSize = 1;
    IsoutlierSize = 100;
    
    
    figure(1)
    if Data_Number ~= 1
        hold on
    else 
        clf('reset')
        colororder(newcolors)
    end
    line_tmp = scatter(1:PerformedWell_num, Spin_num, RowDataSize, '+', 'DisplayName', LegendName);
    hold off
    legend
    xlabel('‡ˆÊ')
    ylabel('‰ñ“]”')
    drawnow
    
    figure(2)
    if Data_Number ~= 1
        hold on
    else 
        clf('reset')
    end
    scatter(Spin_num, Height, RowDataSize, '+', 'DisplayName', LegendName, 'MarkerEdgeColor', line_tmp.CData)
    hold on
%     plot(Spin_num, PolyFit_Height_Value, 'DisplayName', strcat('fitted'), 'Color', line_tmp.CData);
%     if any(TF_Height)
%         scatter(Spin_num(TF_Height), Height(TF_Height), IsoutlierSize, 'o', 'DisplayName', strcat(LegendName, ' ŠO‚ê’l'), 'MarkerEdgeColor', line_tmp.CData)
%     end
    hold off
    legend
    xlabel('’…’n‚Ü‚Å‚Ì‰ñ“]”')
    ylabel('‚‚³(m)')
    drawnow
    
    figure(3)
    if Data_Number ~= 1
        hold on
    else 
        clf('reset')
    end
    scatter(Spin_num, MomentumG, RowDataSize, '+', 'DisplayName', LegendName, 'MarkerEdgeColor', line_tmp.CData)
    hold on
%     plot(Spin_num, PolyFit_MomentumG_Value, 'DisplayName', strcat('fitted'), 'Color', line_tmp.CData)
%     if any(TF_MomentumG)
%         scatter(Spin_num(TF_MomentumG), MomentumG(TF_MomentumG), IsoutlierSize, 'o', 'DisplayName', strcat(LegendName, ' ŠO‚ê’l'), 'MarkerEdgeColor', line_tmp.CData)
%     end
%     hold off
    legend
    xlabel('’…’n‚Ü‚Å‚Ì‰ñ“]”')
    ylabel('‹ó’†‚Å‚ÌŠp‘¬“x(rads^{-1})')
    drawnow
    
    figure(4)
    if Data_Number ~= 1
        hold on
    else 
        clf('reset')
    end
    scatter(Spin_num, Time_Until_Landing, RowDataSize, '+', 'DisplayName', LegendName, 'MarkerEdgeColor', line_tmp.CData)
    hold on
%     plot(Spin_num, PolyFit_Time_Until_Landing_Value, 'DisplayName', strcat('fitted'), 'Color', line_tmp.CData);
%     if any(TF_Time_Until_Landing)
%         scatter(Spin_num(TF_Time_Until_Landing), Time_Until_Landing(TF_Time_Until_Landing), IsoutlierSize, 'o', 'DisplayName', strcat(LegendName, ' ŠO‚ê’l'), 'MarkerEdgeColor', line_tmp.CData)
%     end
%     hold off
    legend
    xlabel('’…’n‚Ü‚Å‚Ì‰ñ“]”')
    ylabel('‘Ø‹óŽžŠÔ(s)')
    drawnow
    
    figure(5)
    if Data_Number ~= 1
        hold on
    else 
        clf('reset')
    end
    scatter(Spin_num, OmegaG, RowDataSize, '+', 'DisplayName', LegendName, 'MarkerEdgeColor', line_tmp.CData)
    hold on
%     plot(Spin_num, PolyFit_OmegaG_Value, 'DisplayName', strcat('fitted'), 'Color', line_tmp.CData);
%     if any(TF_MomentumG)
%         scatter(Spin_num(TF_OmegaG), OmegaG(TF_OmegaG), IsoutlierSize, 'o', 'DisplayName', strcat(LegendName, ' ŠO‚ê’l'), 'MarkerEdgeColor', line_tmp.CData)
%     end
    hold off
    legend
    xlabel('’…’n‚Ü‚Å‚Ì‰ñ“]”')
    ylabel('‰ñ“]‘¬“x(s^{-1})')
    drawnow
    
    figure(6)
    if Data_Number ~= 1
        hold on
    else 
        clf('reset')
    end
    scatter(1:PerformedWell_num, thWaist_AtBodyUpStraight, RowDataSize, '+', 'DisplayName', LegendName, 'MarkerEdgeColor', line_tmp.CData)
    hold off
    legend
    xlabel('‡ˆÊ')
    ylabel('“·‘Ì‰”’¼Žž‚Ì˜Šp“x')
    drawnow
    
    figure(7)
    if Data_Number ~= 1
        hold on
    else 
        clf('reset')
    end
    scatter(1:PerformedWell_num, thWaist_AtBodyHorizon, RowDataSize, '+', 'DisplayName', LegendName, 'MarkerEdgeColor', line_tmp.CData)
    hold off
    legend
    xlabel('‡ˆÊ')
    ylabel('“·‘Ì…•½Žž‚Ì˜Šp“x')
    drawnow
    
    figure(8)
    if Data_Number ~= 1
        hold on
    else 
        clf('reset')
    end
    scatter(Spin_num, thWaist_AtBodyUpStraight, RowDataSize, '+', 'DisplayName', LegendName, 'MarkerEdgeColor', line_tmp.CData)
    xlabel('’…’n‚Ü‚Å‚Ì‰ñ“]”')
    ylabel('“·‘Ì‰”’¼Žž‚Ì˜Šp“x')
    drawnow
    
    PolyFit_thBodyAtStraight_TimeUntilLanding = polyfit(thWaist_AtBodyUpStraight, Time_Until_Landing, 1);
    PolyFit_thBodyAtStraight_TimeUntilLanding_Value = polyval(PolyFit_thBodyAtStraight_TimeUntilLanding, thWaist_AtBodyUpStraight);
    
    figure(9)
    if Data_Number ~= 1
        hold on
    else 
        clf('reset')
    end
    scatter(thWaist_AtBodyUpStraight, Time_Until_Landing, RowDataSize, '+', 'DisplayName', LegendName, 'MarkerEdgeColor', line_tmp.CData)
    line(thWaist_AtBodyUpStraight, PolyFit_thBodyAtStraight_TimeUntilLanding_Value)
    xlabel('“·‘Ì‰”’¼Žž‚Ì˜Šp“x')
    ylabel('‘Ø‹óŽžŠÔ [s]')
    drawnow
    
    PolyFit_thBodyAtStraight_OmegaG = polyfit(thWaist_AtBodyUpStraight, OmegaG, 1);
    PolyFit_thBodyAtStraight_OmegaG_Value = polyval(PolyFit_thBodyAtStraight_OmegaG, thWaist_AtBodyUpStraight);
    
    figure(10)
    if Data_Number ~= 1
        hold on
    else 
        clf('reset')
    end
    scatter(thWaist_AtBodyUpStraight, OmegaG, RowDataSize, '+', 'DisplayName', LegendName, 'MarkerEdgeColor', line_tmp.CData)
    line(thWaist_AtBodyUpStraight, PolyFit_thBodyAtStraight_OmegaG_Value)
    xlabel('“·‘Ì‰”’¼Žž‚Ì˜Šp“x')
    ylabel('‰ñ“]‘¬“x[s^{-1}]')
    drawnow
    
    figure(11)
    if Data_Number ~= 1
        hold on
    else 
        clf('reset')
    end
    scatter(thWaist_AtBodyUpStraight, ObjectiveValueDatas(:,1), RowDataSize, '+', 'DisplayName', LegendName, 'MarkerEdgeColor', line_tmp.CData)
    xlabel('“·‘Ì‰”’¼Žž‚Ì˜Šp“x')
    ylabel('‘S‘Ì‚Ì•]‰¿’l')
    legend
    drawnow
    
    figure(12)
    if Data_Number ~= 1
        hold on
    else 
        clf('reset')
    end
    scatter(thWaist_AtBodyUpStraight, Spin_num, RowDataSize, '+', 'DisplayName', LegendName, 'MarkerEdgeColor', line_tmp.CData)
    xlabel('“·‘Ì‰”’¼Žž‚Ì˜Šp“x')
    ylabel('‰ñ“]”')
    legend
    drawnow
    
    figure(13)
    if Data_Number ~= 1
        hold on
    else 
        clf('reset')
    end
    scatter(thWaist_AtBodyUpStraight, ObjectiveValueDatas(:,3), RowDataSize, '+', 'DisplayName', LegendName, 'MarkerEdgeColor', line_tmp.CData)
    xlabel('“·‘Ì‰”’¼Žž‚Ì˜Šp“x')
    ylabel('“®ˆõ—¦•Ï‰»‚ÉŠÖ‚·‚é•]‰¿’l')
    legend
    drawnow
    
    figure(14)
    if Data_Number ~= 1
        hold on
    else 
        clf('reset')
    end
    scatter(thWaist_AtBodyUpStraight, Work_Total, RowDataSize, '+', 'DisplayName', LegendName, 'MarkerEdgeColor', line_tmp.CData)
    xlabel('“·‘Ì‰”’¼Žž‚Ì˜Šp“x')
    ylabel('Á”ïƒGƒlƒ‹ƒM[')
    legend
    drawnow
    
    figure(15)
    if Data_Number ~= 1
        hold on
    else 
        clf('reset')
    end
    scatter(thWaist_AtBodyUpStraight, thWaist_AtBodyHorizon, RowDataSize, '+', 'DisplayName', LegendName, 'MarkerEdgeColor', line_tmp.CData)
    xlabel('“·‘Ì‰”’¼Žž‚Ì˜Šp“x')
    ylabel('“·‘Ì…•½Žž‚Ì˜Šp“x')
    legend
    drawnow
    
    figure(16)
    if Data_Number ~= 1
        hold on
    else 
        clf('reset')
    end
    scatter(Value_phase2, Value_phase3, RowDataSize, '+', 'DisplayName', LegendName, 'MarkerEdgeColor', line_tmp.CData)
    xlabel('phase2 ‚Å‚Ì ”»’f’l')
    ylabel('phase3 ‚Å‚Ì ”»’f’l')
    legend
    drawnow
    
    figure(17)
    if Data_Number ~= 1
        hold on
    else 
        clf('reset')
    end
    scatter(Value_phase2, Value_phase3, flip(1:PerformedWell_num)/10, 'o', 'DisplayName', LegendName, 'MarkerEdgeColor', line_tmp.CData)
    xlabel('phase2 ‚Å‚Ì ”»’f’l')
    ylabel('phase3 ‚Å‚Ì ”»’f’l')
    legend
    drawnow
    
    if any(Mode_Name == convertCharsToStrings(Para.Mode_String))
        Mode_Index = find(Mode_Name == Para.Mode_String, 1);
    else
        Mode_Name = [Mode_Name; convertCharsToStrings(Para.Mode_String)];
        Mode_Index = size(Mode_Name,1);
    end
    
    Mode_Number_Together = [Mode_Number_Together; zeros([PerformedWell_num, 1]) + Mode_Index];
    
    %{
    MinThHand_Together = [MinThHand_Together; MinThHand, Mode_Index];
    MaxDthShoulder_Together = [MaxDthShoulder_Together; MaxDthShoulder, Mode_Index];
    MinThWaist_Together = [MinThWaist_Together; MinThWaist, Mode_Index];
    
    thWaist_AtBodyUpStraight_Together = [thWaist_AtBodyUpStraight_Together; thWaist_AtBodyUpStraight, Mode_Index];
    thWaist_AtBodyHorizon_Together = [thWaist_AtBodyHorizon_Together; thWaist_AtBodyHorizon, Mode_Index];
    
    thBodyDifference_Together = [thBodyDifference_Together; thBodyDifference, Mode_Index];
    
    time_AtBodyUpStraight_Together = [time_AtBodyUpStraight_Together; time_AtBodyUpStraight, Mode_Index];
    time_AtBodyHorizon_Together = [time_AtBodyHorizon_Together; time_AtBodyHorizon, Mode_Index];
    time_AtMinThWaist_Together = [time_AtMinThWaist_Together; time_AtMinThWaist, Mode_Index];
    
    Spin_num_Together = [Spin_num_Together; Spin_num, Mode_Index];
    Time_Until_Landing_Together = [Time_Until_Landing_Together; Time_Until_Landing, Mode_Index];
    Height_Together = [Height_Together; Height, Mode_Index];
    MomentumG_Together = [MomentumG_Together; MomentumG, Mode_Index];
    OmegaG_Together = [OmegaG_Together; OmegaG, Mode_Index];
    
    Work_Total_Together = [Work_Total_Together; Work_Total, Mode_Index];
    
    Value_phase2_Together = [Value_phase2_Together; Value_phase2, Mode_Index];
    Value_phase3_Together = [Value_phase3_Together; Value_phase3, Mode_Index];
    %}
    
    %{/
    MinThHand_Together = [MinThHand_Together; MinThHand];
    MaxDthShoulder_Together = [MaxDthShoulder_Together; MaxDthShoulder];
    MinThWaist_Together = [MinThWaist_Together; MinThWaist];
    
    thWaist_AtBodyUpStraight_Together = [thWaist_AtBodyUpStraight_Together; thWaist_AtBodyUpStraight];
    thWaist_AtBodyHorizon_Together = [thWaist_AtBodyHorizon_Together; thWaist_AtBodyHorizon];
    
    thBodyDifference_Together = [thBodyDifference_Together; thBodyDifference];
    
    time_AtBodyUpStraight_Together = [time_AtBodyUpStraight_Together; time_AtBodyUpStraight];
    time_AtBodyHorizon_Together = [time_AtBodyHorizon_Together; time_AtBodyHorizon];
    time_AtMinThWaist_Together = [time_AtMinThWaist_Together; time_AtMinThWaist];
    
    Spin_num_Together = [Spin_num_Together; Spin_num];
    Time_Until_Landing_Together = [Time_Until_Landing_Together; Time_Until_Landing];
    Height_Together = [Height_Together; Height];
    MomentumG_Together = [MomentumG_Together; MomentumG];
    OmegaG_Together = [OmegaG_Together; OmegaG];
    
    Work_Total_Together = [Work_Total_Together; Work_Total];
    
    Value_phase2_Together = [Value_phase2_Together; Value_phase2];
    Value_phase3_Together = [Value_phase3_Together; Value_phase3];
    %}
end

for i = 1:size(Mode_Name,1)-1
    
    Plotting_Index = Mode_Number_Together == i+1;
    Plotting_Legend = Mode_Name(i+1);
    
    figure(18)
    if i ~= 1
        hold on
    else 
        clf('reset')
    end
    scatter(Value_phase2_Together(Plotting_Index), Value_phase3_Together(Plotting_Index), 'DisplayName', Plotting_Legend)
    hold off
    xlabel('phase2 ‚Å‚Ì ”»’f’l')
    ylabel('phase3 ‚Å‚Ì ”»’f’l')
    legend
    drawnow
    
    figure(19)
    if i ~= 1
        hold on
    else 
        clf('reset')
    end
    scatter(Value_phase2_Together(Plotting_Index), Spin_num_Together(Plotting_Index), 'DisplayName', Plotting_Legend)
    hold off
    xlabel('phase2 ‚Å‚Ì ”»’f’l')
    ylabel('‰ñ“]”')
    legend
    drawnow
    
    figure(20)
    if i ~= 1
        hold on
    else 
        clf('reset')
    end
    scatter(Value_phase3_Together(Plotting_Index), Spin_num_Together(Plotting_Index), 'DisplayName', Plotting_Legend)
    hold off
    xlabel('phase3 ‚Å‚Ì ”»’f’l')
    ylabel('‰ñ“]”')
    legend
    drawnow
    
    figure(21)
    if i ~= 1
        hold on
    else 
        clf('reset')
    end
    scatter(Value_phase2_Together(Plotting_Index), Time_Until_Landing_Together(Plotting_Index), 'DisplayName', Plotting_Legend)
    hold off
    xlabel('phase2 ‚Å‚Ì ”»’f’l')
    ylabel('‘Ø‹óŽžŠÔ(s)')
    legend
    drawnow
    
    figure(22)
    if i ~= 1
        hold on
    else 
        clf('reset')
    end
    scatter(Value_phase3_Together(Plotting_Index), Time_Until_Landing_Together(Plotting_Index), 'DisplayName', Plotting_Legend)
    hold off
    xlabel('phase3 ‚Å‚Ì ”»’f’l')
    ylabel('‘Ø‹óŽžŠÔ(s)')
    legend
    drawnow
    
    figure(23)
    if i ~= 1
        hold on
    else 
        clf('reset')
    end
    scatter(Value_phase2_Together(Plotting_Index), OmegaG_Together(Plotting_Index), 'DisplayName', Plotting_Legend)
    hold off
    xlabel('phase2 ‚Å‚Ì ”»’f’l')
    ylabel('‰ñ“]‘¬“x(s^{-1})')
    legend
    drawnow
    
    figure(24)
    if i ~= 1
        hold on
    else 
        clf('reset')
    end
    scatter(Value_phase3_Together(Plotting_Index), OmegaG_Together(Plotting_Index), 'DisplayName', Plotting_Legend)
    hold off
    xlabel('phase3 ‚Å‚Ì ”»’f’l')
    ylabel('‰ñ“]‘¬“x(s^{-1})')
    legend
    drawnow
end

figure(25)
scatter3(Value_phase2_Together, Value_phase3_Together, Spin_num_Together, [], Spin_num_Together)
colorbar
view(2)
xlabel('phase2 ‚Å‚Ì ”»’f’l')
ylabel('phase3 ‚Å‚Ì ”»’f’l')
title('‰ñ“]”')

figure(26)
scatter3(Value_phase2_Together, Value_phase3_Together, Time_Until_Landing_Together, [], Time_Until_Landing_Together)
colorbar
view(2)
xlabel('phase2 ‚Å‚Ì ”»’f’l')
ylabel('phase3 ‚Å‚Ì ”»’f’l')
title('‘Ø‹óŽžŠÔ(s)')

figure(27)
scatter3(Value_phase2_Together, Value_phase3_Together, OmegaG_Together, [], OmegaG_Together)
colorbar
view(2)
xlabel('phase2 ‚Å‚Ì ”»’f’l')
ylabel('phase3 ‚Å‚Ì ”»’f’l')
title('‰ñ“]‘¬“x(s^{-1})')

Spin_Num_Corrcoef = corrcoef([Spin_num_Together, Value_phase2_Together, Value_phase3_Together])
Time_Until_Landing_Corrcoef = corrcoef([Time_Until_Landing_Together, Value_phase2_Together, Value_phase3_Together])
OmegaG_Corrcoef = corrcoef([OmegaG_Together, Value_phase2_Together, Value_phase3_Together])

%{
figure(18)
scatter(Value_phase2_Together, Value_phase3_Together)
xlabel('phase2 ‚Å‚Ì ”»’f’l')
ylabel('phase3 ‚Å‚Ì ”»’f’l')
legend
drawnow

figure(19)
scatter(Value_phase2_Together, Spin_num_Together)
xlabel('phase2 ‚Å‚Ì ”»’f’l')
ylabel('‰ñ“]”')
legend
drawnow

figure(20)
scatter(Value_phase3_Together, Spin_num_Together)
xlabel('phase3 ‚Å‚Ì ”»’f’l')
ylabel('‰ñ“]”')
legend
drawnow

corrcoef([Spin_num_Together, Value_phase2_Together, Value_phase3_Together])
%}



%{
figure_Number = figure_Number + 1;
figure(figure_Number)
clf('reset')
plot(1:PerformedWell_num, -PhysicsValue(:,1), ':blue')
hold on
plot((1:size(Average_PhysicsValue, 1))*Average_Range_Analyze, -Average_PhysicsValue(:,1), 'red', 'LineWidth', Average_LineWidth)
hold off
legend({'Žè‚ÌÅ¬Šp“x(‘O‘¤‚É‚Ç‚ê‚¾‚¯ŒX‚¢‚½‚©)','•½‹Ï'})
xlabel('‰½”Ô–Ú‚É—Ç‚¢“®‚«‚©(¶‚Ù‚Ç—Ç‚¢)')
ylabel('Šp“x(rad)')

figure_Number = figure_Number + 1;
figure(figure_Number)
clf('reset')
plot(1:PerformedWell_num, -PhysicsValue(:,2), ':blue')
hold on
plot((1:size(Average_PhysicsValue, 1))*Average_Range_Analyze, -Average_PhysicsValue(:,2), 'red', 'LineWidth', Average_LineWidth)
hold off
legend({'˜‚ÌÅ‘åL“WŠp“x','•½‹Ï'})
xlabel('‰½”Ô–Ú‚É—Ç‚¢“®‚«‚©(¶‚Ù‚Ç—Ç‚¢)')
ylabel('Šp“x(rad)')

figure_Number = figure_Number + 1;
figure(figure_Number)
clf('reset')
plot(1:PerformedWell_num, -PhysicsValue(:,3), ':blue')
hold on
plot((1:size(Average_PhysicsValue, 1))*Average_Range_Analyze, -Average_PhysicsValue(:,3), 'red', 'LineWidth', Average_LineWidth)
hold off
legend({'“·‘Ì‚’¼Žž‚Ì˜‚ÌŠp“x','•½‹Ï'})
xlabel('‰½”Ô–Ú‚É—Ç‚¢“®‚«‚©(¶‚Ù‚Ç—Ç‚¢)')
ylabel('Šp“x(rad)')

figure_Number = figure_Number + 1;
figure(figure_Number)
clf('reset')
plot(1:PerformedWell_num, PhysicsValue(:,4), ':blue')
hold on
plot((1:size(Average_PhysicsValue, 1))*Average_Range_Analyze, Average_PhysicsValue(:,4), 'red', 'LineWidth', Average_LineWidth)
hold off
legend({'Œ¨ŠÖßŠp‘¬“x‚ÌÅ‘å','•½‹Ï'})
xlabel('‰½”Ô–Ú‚É—Ç‚¢“®‚«‚©(¶‚Ù‚Ç—Ç‚¢)')
ylabel('Šp‘¬“x(rad/s)')

figure_Number = figure_Number + 1;
figure(figure_Number)
clf('reset')
plot(1:PerformedWell_num, ObjectiveValueDatas(:,3)/1e1, ':blue')
hold on
plot((1:size(Average_PhysicsValue, 1))*Average_Range_Analyze, Average_ObjectiveValueDatas(:,3)/1e1, 'red', 'LineWidth', Average_LineWidth)
hold off
legend({'dthSwitchValue','•½‹Ï'})
xlabel('‰½”Ô–Ú‚É—Ç‚¢“®‚«‚©(¶‚Ù‚Ç—Ç‚¢)')
ylabel('•]‰¿(’á‚¢‚Ù‚Ç—Ç‚¢)')

figure_Number = figure_Number + 1;
figure(figure_Number)
clf('reset')
plot(1:PerformedWell_num, ObjectiveValueDatas(:,4)/1e0, ':blue')
hold on
plot((1:size(Average_PhysicsValue, 1))*Average_Range_Analyze, Average_ObjectiveValueDatas(:,4)/1e0, 'red', 'LineWidth', Average_LineWidth)
hold off
legend({'MthValue','•½‹Ï'})
xlabel('‰½”Ô–Ú‚É—Ç‚¢“®‚«‚©(¶‚Ù‚Ç—Ç‚¢)')
ylabel('•]‰¿(’á‚¢‚Ù‚Ç—Ç‚¢)')

figure_Number = figure_Number + 1;
figure(figure_Number)
clf('reset')
plot(1:PerformedWell_num, TimeDifference, ':blue')
hold on
plot((1:size(Average_PhysicsValue, 1))*Average_Range_Analyze, Average_TimeDifference, 'red', 'LineWidth', Average_LineWidth)
hold off
legend({'˜‚ÌÅ‘åi“WŽž‚Æ“·‘Ì‚’¼Žž‚ÌŽžŠÔ·','•½‹Ï'})
xlabel('‰½”Ô–Ú‚É—Ç‚¢“®‚«‚©(¶‚Ù‚Ç—Ç‚¢)')
ylabel('ŽžŠÔ·(s)')

figure_Number = figure_Number + 1;
figure(figure_Number)
clf('reset')
plot(1:PerformedWell_num, PhysicsValue(:,5), ':blue')
hold on
plot((1:size(Average_PhysicsValue, 1))*Average_Range_Analyze, Average_PhysicsValue(:,5), 'red', 'LineWidth', Average_LineWidth)
hold off
legend({'˜‚ÌÅ‘åi“WŽž‚Ì“·‘ÌŠp“x‚Ì‚’¼‰º‚©‚ç‚Ì‚¸‚ê','•½‹Ï'})
xlabel('‰½”Ô–Ú‚É—Ç‚¢“®‚«‚©(¶‚Ù‚Ç—Ç‚¢)')
ylabel('Šp“x(rad)')

figure_Number = figure_Number + 1;
figure(figure_Number)
clf('reset')
plot(1:PerformedWell_num, Height, ':blue')
hold on
plot((1:size(Average_PhysicsValue, 1))*Average_Range_Analyze, Average_PhysicsValue(:, 6), 'red', 'LineWidth', Average_LineWidth)
hold off
legend({'‚‚³','•½‹Ï'})
xlabel('‰½”Ô–Ú‚É—Ç‚¢“®‚«‚©(¶‚Ù‚Ç—Ç‚¢)')
ylabel('‚‚³(m)')

figure_Number = figure_Number + 1;
figure(figure_Number)
clf('reset')
plot(1:PerformedWell_num, MomentumG, ':blue')
hold on
plot((1:size(Average_PhysicsValue, 1))*Average_Range_Analyze, Average_PhysicsValue(:, 7), 'red', 'LineWidth', Average_LineWidth)
hold off
legend({'Šp‰^“®—Ê','•½‹Ï'})
xlabel('‰½”Ô–Ú‚É—Ç‚¢“®‚«‚©(¶‚Ù‚Ç—Ç‚¢)')
ylabel('Šp‰^“®—Ê(rads^{-1})')
%}

%“ñŽ²‚Å‚Ì•\‚µ•ûB•Û‘¶‚µ‚Ä‚¨‚­‚×‚«
%{
figure_Number = figure_Number + 1;
figure(figure_Number)
clf('reset')
colororder({'black','red'})
yyaxis right
ax = gca;
ax.YAxis(2,1).Color = [1,0,0];
yyaxis left
plot((1:PerformedWell_num)', [MinThHand, MinThWaist, thWaist_AtBodyUpStraight], 'Color', ax.YAxis(1,1).Color)
yyaxis right
plot((1:PerformedWell_num)', MaxDthShoulder, 'Color', ax.YAxis(2,1).Color)
legend({'Žè‚ÌÅ¬Šp“x','˜‚ÌÅ¬Šp“x','^‰º‚Å‚Ì˜Šp“x','Œ¨Šp‘¬“x‚ÌÅ‘å’l'})

figure_Number = figure_Number + 1;
figure(figure_Number)
clf('reset')
colororder({'black','red'})
yyaxis right
ax = gca;
ax.YAxis(2,1).Color = [1,0,0];
yyaxis left
plot(1:PerformedWell_num, ObjectiveValueDatas(1:PerformedWell_num,2:4)./[1e2, 1e1, 1e0], 'Color', ax.YAxis(1,1).Color)
% hold on
% plot(1:PerformedWell_num, ObjectiveValueDatas(1:PerformedWell_num,3)/1e1)
% plot(1:PerformedWell_num, ObjectiveValueDatas(1:PerformedWell_num,4)/1e0)
% hold off
yyaxis right
plot(1:PerformedWell_num, ObjectiveValueDatas(1:PerformedWell_num,1), 'Color', ax.YAxis(2,1).Color)
legend({'spinValue', 'dthSwitchValue', 'MthValue', 'ObjectiveValue'})

PhysicsValue = [MinThHand, MinThWaist, thWaist_AtBodyUpStraight, MaxDthShoulder];
TimeDifference = time_AtMinThWaist - time_AtBodyUpStraight;


figure_Number = figure_Number + 1;
figure(figure_Number)
clf('reset')
colororder({'black','red'})
yyaxis right
ax = gca;
ax.YAxis(2,1).Color = [1,0,0];
yyaxis left
% plot((1:size(Average_PhysicsValue, 1))'*Average_Range_MaxTh_fromPara, Average_PhysicsValue(:,1:2))
plot((1:size(Average_PhysicsValue, 1))'*Average_Range_Analyze, Average_PhysicsValue(:,1:3), 'Color', ax.YAxis(1,1).Color)
yyaxis right
plot((1:size(Average_PhysicsValue, 1))'*Average_Range_Analyze, Average_PhysicsValue(:,4), 'Color', ax.YAxis(2,1).Color)
legend({'Žè‚ÌÅ¬Šp“x‚Ì•½‹Ï','˜‚ÌÅ¬Šp“x‚Ì•½‹Ï','^‰º‚Å‚Ì˜Šp“x‚Ì•½‹Ï','Œ¨Šp‘¬“x‚ÌÅ‘å’l‚Ì•½‹Ï'})

figure_Number = figure_Number + 1;
figure(figure_Number)
clf('reset')
colororder({'black','red'})
yyaxis right
ax = gca;
ax.YAxis(2,1).Color = [1,0,0];
yyaxis left
plot((1:size(Average_PhysicsValue, 1))'*Average_Range_Analyze, Average_ObjectiveValueDatas(:,2:4)./[1e2, 1e1, 1e0], 'Color', ax.YAxis(1,1).Color)
yyaxis right
plot((1:size(Average_PhysicsValue, 1))'*Average_Range_Analyze, Average_ObjectiveValueDatas(:,1), 'Color', ax.YAxis(2,1).Color)
legend({'spinValue‚Ì•½‹Ï', 'dthSwitchValue‚Ì•½‹Ï', 'MthValue‚Ì•½‹Ï', 'ObjectiveValue‚Ì•½‹Ï'})

figure_Number = figure_Number + 1;
figure(figure_Number)
clf('reset')
plot(1:PerformedWell_num, TimeDifference, ':blue',...
    (1:size(Average_PhysicsValue, 1))*Average_Range_Analyze, Average_TimeDifference, 'red')
legend({'˜‚ÌÅ‘åi“WŽž‚Æ“·‘Ì‚’¼Žž‚ÌŽžŠÔ·','•½‹Ï'})
%}
















































