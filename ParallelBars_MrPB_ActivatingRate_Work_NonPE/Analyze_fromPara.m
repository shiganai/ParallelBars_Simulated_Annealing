clear all


% DataNames = {'Para_0702221941_pop_2400_gen_7307_BeforeAnnealing'};

DataNames = ...
    {
    'Para_0719185828_pop_1000_gen_3338';
    'Para_0719074144_pop_1000_gen_3351';
    'Para_0719185900_pop_1000_gen_5116';
    };

% newcolors = {'blue','red', 'green', 'magenta', 'black'};
newcolors = 'default';

IfIsoutlier = 0;

for Data_Number = 1:size(DataNames,1)
%     Data_Index_Range = (1:2400)';
    
    load(DataNames{Data_Number,1})
    
    ActivatingRate = Para.ActivatingRate;
    ObjectiveValueDatas = Para.ObjectiveValueDatas;
    
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
    odeEvent = Para.odeEvent;
    absTol = Para.absTol;
    % absTol = 1e-8;
    Spin_num_Goal = Para.Spin_num_Goal;
    % Spin_num_Goal = 1.2;
    thWaist_AtBodyUpStraight_Range = Para.thWaist_AtBodyUpStraight_Range;
    

    PerformedWell_Index = find((ObjectiveValueDatas(:,2) >= 0.00)...
        .* (ObjectiveValueDatas(:,2) <= 100));
    
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
    
    tic
    parfor index = 1:PerformedWell_num
        
        ActivatingRate_index = [reshape(ActivatingRate(index,1,:), size(Data_Set_Time)), reshape(ActivatingRate(index,2,:), size(Data_Set_Time)), reshape(ActivatingRate(index,3,:), size(Data_Set_Time))];
        
        MthHand_ActivatingRate_spline = spline(Data_Set_Time, ActivatingRate_index(:,1));
        MthShoulder_ActivatingRate_spline = spline(Data_Set_Time, ActivatingRate_index(:,2));
        MthWaist_ActivatingRate_spline = spline(Data_Set_Time, ActivatingRate_index(:,3));
        
        ActivatingRate_spline = [MthHand_ActivatingRate_spline, MthShoulder_ActivatingRate_spline, MthWaist_ActivatingRate_spline]';
        ode = @(t, q) ddt_ActivatingRate(t, q, constants, ActivatingRate_spline);
        odeOption = odeset('Events', odeEvent, 'AbsTol', absTol);
        [time_onbar, q, ~, ~, ie] = ode45(ode, t, q0, odeOption);
        time = time_onbar;
        if ~isempty(ie)
            breakNum = ie(end);
        else
            breakNum = 0;
        end
        ObjectiveValueData = ObjectiveFcn(time_onbar, q, constants, Spin_num_Goal, breakNum, ActivatingRate_index, Data_Set_Time, thWaist_AtBodyUpStraight_Range);


        rPB = q(:,1);
        thHand = q(:,2);
        thShoulder = q(:,3);
        thWaist = q(:,4);
        drPB = q(:,5);
        dthHand = q(:,6);
        dthShoulder = q(:,7);
        dthWaist = q(:,8);
        
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
        
        height = pG(end,2) + vG(end,2)^2/(2*g) + 1.8 - rLeg;
        time_until_landing = vG(end,2)/g + (2*height/g)^0.5; %vG(end,2)がマイナスだった場合でも大丈夫
        omegaG = momentumG(end)/InertiaG;
        
        Height(index, 1) = height;
        MomentumG(index, 1) = omegaG;
        Spin_num(index, 1) = time_until_landing * omegaG /(2*pi);
        Time_Until_Landing(index, 1) = time_until_landing;
        OmegaG(index, 1) = omegaG/(2*pi);
        
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
    
    LegendName = strcat("胴体が鉛直時の腰角度が ", num2str(Para.thWaist_AtBodyUpStraight_Range(1,1)),...
        " 〜 ", num2str(Para.thWaist_AtBodyUpStraight_Range(1,2)), 'rad');
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
    xlabel('順位')
    ylabel('回転数')
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
%         scatter(Spin_num(TF_Height), Height(TF_Height), IsoutlierSize, 'o', 'DisplayName', strcat(LegendName, ' 外れ値'), 'MarkerEdgeColor', line_tmp.CData)
%     end
    hold off
    legend
    xlabel('着地までの回転数')
    ylabel('高さ(m)')
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
%         scatter(Spin_num(TF_MomentumG), MomentumG(TF_MomentumG), IsoutlierSize, 'o', 'DisplayName', strcat(LegendName, ' 外れ値'), 'MarkerEdgeColor', line_tmp.CData)
%     end
%     hold off
    legend
    xlabel('着地までの回転数')
    ylabel('空中での角速度(rads^{-1})')
    drawnow
    
    figure(4)
    if Data_Number ~= 1
        hold on
    else 
        clf('reset')
    end
    scatter(Spin_num, Time_Until_Landing, RowDataSize, '+', 'DisplayName', LegendName, 'MarkerEdgeColor', line_tmp.CData)
    hold on
    plot(Spin_num, PolyFit_Time_Until_Landing_Value, 'DisplayName', strcat('fitted'), 'Color', line_tmp.CData);
%     if any(TF_Time_Until_Landing)
%         scatter(Spin_num(TF_Time_Until_Landing), Time_Until_Landing(TF_Time_Until_Landing), IsoutlierSize, 'o', 'DisplayName', strcat(LegendName, ' 外れ値'), 'MarkerEdgeColor', line_tmp.CData)
%     end
%     hold off
    legend
    xlabel('着地までの回転数')
    ylabel('滞空時間(s)')
    drawnow
    
    figure(5)
    if Data_Number ~= 1
        hold on
    else 
        clf('reset')
    end
    scatter(Spin_num, OmegaG, RowDataSize, '+', 'DisplayName', LegendName, 'MarkerEdgeColor', line_tmp.CData)
    hold on
    plot(Spin_num, PolyFit_OmegaG_Value, 'DisplayName', strcat('fitted'), 'Color', line_tmp.CData);
%     if any(TF_MomentumG)
%         scatter(Spin_num(TF_OmegaG), OmegaG(TF_OmegaG), IsoutlierSize, 'o', 'DisplayName', strcat(LegendName, ' 外れ値'), 'MarkerEdgeColor', line_tmp.CData)
%     end
    hold off
    legend
    xlabel('着地までの回転数')
    ylabel('回転速度(s^{-1})')
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
    xlabel('順位')
    ylabel('胴体鉛直時の腰角度')
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
    xlabel('順位')
    ylabel('胴体水平時の腰角度')
    drawnow
    
    figure(8)
    if Data_Number ~= 1
        hold on
    else 
        clf('reset')
    end
    scatter(Spin_num, thWaist_AtBodyUpStraight, RowDataSize, '+', 'DisplayName', LegendName, 'MarkerEdgeColor', line_tmp.CData)
    xlabel('着地までの回転数')
    ylabel('胴体鉛直時の腰角度')
    drawnow
    
    figure(9)
    if Data_Number ~= 1
        hold on
    else 
        clf('reset')
    end
    scatter(thWaist_AtBodyUpStraight, Time_Until_Landing, RowDataSize, '+', 'DisplayName', LegendName, 'MarkerEdgeColor', line_tmp.CData)
    xlabel('胴体鉛直時の腰角度')
    ylabel('滞空時間 [s]')
    drawnow
    
    figure(10)
    if Data_Number ~= 1
        hold on
    else 
        clf('reset')
    end
    scatter(thWaist_AtBodyUpStraight, OmegaG, RowDataSize, '+', 'DisplayName', LegendName, 'MarkerEdgeColor', line_tmp.CData)
    xlabel('胴体鉛直時の腰角度')
    ylabel('回転速度[s^{-1}]')
    drawnow
    
    figure(11)
    if Data_Number ~= 1
        hold on
    else 
        clf('reset')
    end
    scatter(1:PerformedWell_num, ObjectiveValueDatas(:,1), RowDataSize, '+', 'DisplayName', LegendName, 'MarkerEdgeColor', line_tmp.CData)
    xlabel('順位')
    ylabel('全体の評価値')
    legend
    drawnow
    
    figure(12)
    if Data_Number ~= 1
        hold on
    else 
        clf('reset')
    end
    scatter(1:PerformedWell_num, ObjectiveValueDatas(:,2), RowDataSize, '+', 'DisplayName', LegendName, 'MarkerEdgeColor', line_tmp.CData)
    xlabel('順位')
    ylabel('回転数に関する評価値')
    legend
    drawnow
    
    figure(13)
    if Data_Number ~= 1
        hold on
    else 
        clf('reset')
    end
    scatter(1:PerformedWell_num, ObjectiveValueDatas(:,3), RowDataSize, '+', 'DisplayName', LegendName, 'MarkerEdgeColor', line_tmp.CData)
    xlabel('順位')
    ylabel('動員率変化に関する評価値')
    legend
    drawnow
    
    figure(14)
    if Data_Number ~= 1
        hold on
    else 
        clf('reset')
    end
    scatter(1:PerformedWell_num, ObjectiveValueDatas(:,4), RowDataSize, '+', 'DisplayName', LegendName, 'MarkerEdgeColor', line_tmp.CData)
    xlabel('順位')
    ylabel('消費エネルギーに関する評価値')
    legend
    drawnow
    
end

%{
figure_Number = figure_Number + 1;
figure(figure_Number)
clf('reset')
plot(1:PerformedWell_num, -PhysicsValue(:,1), ':blue')
hold on
plot((1:size(Average_PhysicsValue, 1))*Average_Range_Analyze, -Average_PhysicsValue(:,1), 'red', 'LineWidth', Average_LineWidth)
hold off
legend({'手の最小角度(前側にどれだけ傾いたか)','平均'})
xlabel('何番目に良い動きか(左ほど良い)')
ylabel('角度(rad)')

figure_Number = figure_Number + 1;
figure(figure_Number)
clf('reset')
plot(1:PerformedWell_num, -PhysicsValue(:,2), ':blue')
hold on
plot((1:size(Average_PhysicsValue, 1))*Average_Range_Analyze, -Average_PhysicsValue(:,2), 'red', 'LineWidth', Average_LineWidth)
hold off
legend({'腰の最大伸展角度','平均'})
xlabel('何番目に良い動きか(左ほど良い)')
ylabel('角度(rad)')

figure_Number = figure_Number + 1;
figure(figure_Number)
clf('reset')
plot(1:PerformedWell_num, -PhysicsValue(:,3), ':blue')
hold on
plot((1:size(Average_PhysicsValue, 1))*Average_Range_Analyze, -Average_PhysicsValue(:,3), 'red', 'LineWidth', Average_LineWidth)
hold off
legend({'胴体垂直時の腰の角度','平均'})
xlabel('何番目に良い動きか(左ほど良い)')
ylabel('角度(rad)')

figure_Number = figure_Number + 1;
figure(figure_Number)
clf('reset')
plot(1:PerformedWell_num, PhysicsValue(:,4), ':blue')
hold on
plot((1:size(Average_PhysicsValue, 1))*Average_Range_Analyze, Average_PhysicsValue(:,4), 'red', 'LineWidth', Average_LineWidth)
hold off
legend({'肩関節角速度の最大','平均'})
xlabel('何番目に良い動きか(左ほど良い)')
ylabel('角速度(rad/s)')

figure_Number = figure_Number + 1;
figure(figure_Number)
clf('reset')
plot(1:PerformedWell_num, ObjectiveValueDatas(:,3)/1e1, ':blue')
hold on
plot((1:size(Average_PhysicsValue, 1))*Average_Range_Analyze, Average_ObjectiveValueDatas(:,3)/1e1, 'red', 'LineWidth', Average_LineWidth)
hold off
legend({'dthSwitchValue','平均'})
xlabel('何番目に良い動きか(左ほど良い)')
ylabel('評価(低いほど良い)')

figure_Number = figure_Number + 1;
figure(figure_Number)
clf('reset')
plot(1:PerformedWell_num, ObjectiveValueDatas(:,4)/1e0, ':blue')
hold on
plot((1:size(Average_PhysicsValue, 1))*Average_Range_Analyze, Average_ObjectiveValueDatas(:,4)/1e0, 'red', 'LineWidth', Average_LineWidth)
hold off
legend({'MthValue','平均'})
xlabel('何番目に良い動きか(左ほど良い)')
ylabel('評価(低いほど良い)')

figure_Number = figure_Number + 1;
figure(figure_Number)
clf('reset')
plot(1:PerformedWell_num, TimeDifference, ':blue')
hold on
plot((1:size(Average_PhysicsValue, 1))*Average_Range_Analyze, Average_TimeDifference, 'red', 'LineWidth', Average_LineWidth)
hold off
legend({'腰の最大進展時と胴体垂直時の時間差','平均'})
xlabel('何番目に良い動きか(左ほど良い)')
ylabel('時間差(s)')

figure_Number = figure_Number + 1;
figure(figure_Number)
clf('reset')
plot(1:PerformedWell_num, PhysicsValue(:,5), ':blue')
hold on
plot((1:size(Average_PhysicsValue, 1))*Average_Range_Analyze, Average_PhysicsValue(:,5), 'red', 'LineWidth', Average_LineWidth)
hold off
legend({'腰の最大進展時の胴体角度の垂直下からのずれ','平均'})
xlabel('何番目に良い動きか(左ほど良い)')
ylabel('角度(rad)')

figure_Number = figure_Number + 1;
figure(figure_Number)
clf('reset')
plot(1:PerformedWell_num, Height, ':blue')
hold on
plot((1:size(Average_PhysicsValue, 1))*Average_Range_Analyze, Average_PhysicsValue(:, 6), 'red', 'LineWidth', Average_LineWidth)
hold off
legend({'高さ','平均'})
xlabel('何番目に良い動きか(左ほど良い)')
ylabel('高さ(m)')

figure_Number = figure_Number + 1;
figure(figure_Number)
clf('reset')
plot(1:PerformedWell_num, MomentumG, ':blue')
hold on
plot((1:size(Average_PhysicsValue, 1))*Average_Range_Analyze, Average_PhysicsValue(:, 7), 'red', 'LineWidth', Average_LineWidth)
hold off
legend({'角運動量','平均'})
xlabel('何番目に良い動きか(左ほど良い)')
ylabel('角運動量(rads^{-1})')
%}

%二軸での表し方。保存しておくべき
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
legend({'手の最小角度','腰の最小角度','真下での腰角度','肩角速度の最大値'})

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
legend({'手の最小角度の平均','腰の最小角度の平均','真下での腰角度の平均','肩角速度の最大値の平均'})

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
legend({'spinValueの平均', 'dthSwitchValueの平均', 'MthValueの平均', 'ObjectiveValueの平均'})

figure_Number = figure_Number + 1;
figure(figure_Number)
clf('reset')
plot(1:PerformedWell_num, TimeDifference, ':blue',...
    (1:size(Average_PhysicsValue, 1))*Average_Range_Analyze, Average_TimeDifference, 'red')
legend({'腰の最大進展時と胴体垂直時の時間差','平均'})
%}
















































