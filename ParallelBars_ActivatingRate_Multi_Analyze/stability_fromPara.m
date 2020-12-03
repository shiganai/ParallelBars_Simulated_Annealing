
clear all

%{
load('Para_1014140750_pop_2400_gen_12392_Provisional_ObjectiveValue') % 制限なし
figure_Base_Num = 0;
%}

%{
load('Para_1107134918_pop_2400_gen_25568_Provisional_ObjectiveValue') % value_phase2 で腰を屈曲させる動員率を持たない制限あり
figure_Base_Num = 10;
%}


DataNames = {'Para_1014140750_pop_2400_gen_12392_Provisional_ObjectiveValue', 0, '制限なし';
    'Para_1107134918_pop_2400_gen_25568_Provisional_ObjectiveValue', 10, 'value\_phase2 で腰を屈曲させる動員率を持たない制限あり';
    };

ifScat_not_changed = 0;
ifHold_on = 0;

% xLim = [Inf, -Inf];
% yLim = [Inf, -Inf];


for DataNames_Index = 1:1:size(DataNames,1)
    
    load(DataNames{DataNames_Index,1})
    figure_Base_Num = DataNames{DataNames_Index,2};
    title_Str = DataNames{DataNames_Index,3};
    
    % index = 1;
    % ActivatingRate = Para.ActivatingRate;
    % ActivatingRate_index = [reshape(ActivatingRate(index,1,:), size(Data_Set_Time)), reshape(ActivatingRate(index,2,:), size(Data_Set_Time)), reshape(ActivatingRate(index,3,:), size(Data_Set_Time))];
    
    Para = Para_Provisional;
    ActivatingRate_index = Para.ActivatingRate_index_Provisional;
    
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
    q0 = Para.q0;
    absTol = Para.absTol;
    Spin_num_Goal = Para.Spin_num_Goal;
    
    ode_Fcn = Para.ode_Fcn;
    Objective_Fcn = Para.Objective_Fcn;
    
%     t = Para.odeTime;
    t = 0:1e-3:2;
    
    % ode_Event = Para.ode_Event;
    ode_Event = @(t,q) Events_Stability(t,q,Para.constants);
    
    MthHand_ActivatingRate_spline = spline(Data_Set_Time, ActivatingRate_index(:,1));
    MthShoulder_ActivatingRate_spline = spline(Data_Set_Time, ActivatingRate_index(:,2));
    MthWaist_ActivatingRate_spline = spline(Data_Set_Time, ActivatingRate_index(:,3));
    
    ActivatingRate_spline = [MthHand_ActivatingRate_spline, MthShoulder_ActivatingRate_spline, MthWaist_ActivatingRate_spline]';
    
    ode = @(t, q) ode_Fcn(t, q, ActivatingRate_spline);
    
    odeOption = odeset('Events', ode_Event, 'AbsTol', absTol);
    
    [time_onbar, q, ~, ~, ie] = ode45(ode, t, q0, odeOption);
    time = time_onbar;
    Take_Off_Time_Original = time_onbar(end);
    
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
    
    yHand = rPB(:,1);
    xHand = zeros(size(yHand));
    dyHand = drPB(:,1);
    dxHand = zeros(size(dyHand));
    ddxHand = fnval(fnder(spline(time_onbar, dxHand)), time_onbar);
    ddyHand = fnval(fnder(spline(time_onbar, dyHand)), time_onbar);
    
    ddrPB = fnval(fnder(spline(time_onbar, drPB)), time_onbar);
    ddthHand = fnval(fnder(spline(time_onbar, dthHand)), time_onbar);
    ddthShoulder = fnval(fnder(spline(time_onbar, dthShoulder)), time_onbar);
    ddthWaist = fnval(fnder(spline(time_onbar, dthWaist)), time_onbar);
    
    pG = find_pG(mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist,xHand,yHand);
    vG = find_vG(dthHand,dthWaist,dthShoulder,dxHand,dyHand,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
    momentumG = find_momentumG(InertiaLeg,InertiaArm,InertiaBody,dthHand,dthWaist,dthShoulder,dxHand,dyHand,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist,xHand,yHand);
    
    if breakNum == 1
        height = pG(end,2) + vG(end,2)^2/(2*g) + 1.8 - rLeg;
        time_until_landing = vG(end,2)/g + (2*height/g)^0.5; %vG(end,2)がマイナスだった場合でも大丈夫
        omegaG = momentumG(end)/InertiaG;
        spinNum = time_until_landing * omegaG /(2*pi);
    else
        spinNum = -1;
    end
    
    Disturbance_step = 1/Para.ActivatingRate_Step_num;
    spinNum_stability_positive = zeros(size(ActivatingRate_index));
    spinNum_stability_negative = zeros(size(ActivatingRate_index));
    spinNum_stability_positive_ifchanged = true(size(ActivatingRate_index));
    spinNum_stability_negative_ifchanged = true(size(ActivatingRate_index));
    
    ObjectiveValue_stability_positive = zeros(size(ActivatingRate_index));
    ObjectiveValue_stability_negative = zeros(size(ActivatingRate_index));
    ObjectiveValue_stability_positive_ifchanged = true(size(ActivatingRate_index));
    ObjectiveValue_stability_negative_ifchanged = true(size(ActivatingRate_index));
    
    tic
    parfor Disturbance_index = 1:size(ActivatingRate_index(:),1)
        
        if abs(ActivatingRate_index(Disturbance_index) - 1) < 1e-2 % 1なら
            spinNum_stability_positive(Disturbance_index) = spinNum;
            spinNum_stability_positive_ifchanged(Disturbance_index) = false;
            
            ObjectiveValue_stability_positive(Disturbance_index) = ObjectiveValueData(1);
            ObjectiveValue_stability_positive_ifchanged(Disturbance_index) = false;
        else % 1じゃないなら
            
            ActivatingRate_index_tmp = ActivatingRate_index;
            ActivatingRate_index_tmp(Disturbance_index) = ActivatingRate_index_tmp(Disturbance_index) + Disturbance_step;
            
            MthHand_ActivatingRate_spline = spline(Data_Set_Time, ActivatingRate_index_tmp(:,1));
            MthShoulder_ActivatingRate_spline = spline(Data_Set_Time, ActivatingRate_index_tmp(:,2));
            MthWaist_ActivatingRate_spline = spline(Data_Set_Time, ActivatingRate_index_tmp(:,3));
            
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
            
            
            rPB = q(:,1);
            thHand = q(:,2);
            thShoulder = q(:,3);
            thWaist = q(:,4);
            drPB = q(:,5);
            dthHand = q(:,6);
            dthShoulder = q(:,7);
            dthWaist = q(:,8);
            
            yHand = rPB(:,1);
            xHand = zeros(size(yHand));
            dyHand = drPB(:,1);
            dxHand = zeros(size(dyHand));
            %     ddxHand = fnval(fnder(spline(time_onbar, dxHand)), time_onbar);
            %     ddyHand = fnval(fnder(spline(time_onbar, dyHand)), time_onbar);
            %
            %     ddrPB = fnval(fnder(spline(time_onbar, drPB)), time_onbar);
            %     ddthHand = fnval(fnder(spline(time_onbar, dthHand)), time_onbar);
            %     ddthShoulder = fnval(fnder(spline(time_onbar, dthShoulder)), time_onbar);
            %     ddthWaist = fnval(fnder(spline(time_onbar, dthWaist)), time_onbar);
            
            pG = find_pG(mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist,xHand,yHand);
            vG = find_vG(dthHand,dthWaist,dthShoulder,dxHand,dyHand,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
            momentumG = find_momentumG(InertiaLeg,InertiaArm,InertiaBody,dthHand,dthWaist,dthShoulder,dxHand,dyHand,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist,xHand,yHand);
            
            if breakNum == 1
                height = pG(end,2) + vG(end,2)^2/(2*g) + 1.8 - rLeg;
                time_until_landing = vG(end,2)/g + (2*height/g)^0.5; %vG(end,2)がマイナスだった場合でも大丈夫
                omegaG = momentumG(end)/InertiaG;
                spinNum_stability_positive(Disturbance_index) = time_until_landing * omegaG /(2*pi);
                
                ObjectiveValueData_tmp = Objective_Fcn(time_onbar, q, breakNum, ActivatingRate_index_tmp);
                ObjectiveValue_stability_positive(Disturbance_index) = ObjectiveValueData_tmp(1);
            elseif breakNum == 0
                warning('動作が完了しきらなかったものがあります')
            else
                spinNum_stability_positive(Disturbance_index) = 0;
                
                ObjectiveValue_stability_positive(Disturbance_index) = 0;
            end
        end
        
        
        if abs(ActivatingRate_index(Disturbance_index) - -1) < 1e-2 % -1なら
            spinNum_stability_negative(Disturbance_index) = spinNum;
            spinNum_stability_negative_ifchanged(Disturbance_index) = false;
            
            ObjectiveValue_stability_negative(Disturbance_index) = ObjectiveValueData(1);
            ObjectiveValue_stability_negative_ifchanged(Disturbance_index) = false;
        else % -1じゃないなら
            
            ActivatingRate_index_tmp = ActivatingRate_index;
            ActivatingRate_index_tmp(Disturbance_index) = ActivatingRate_index_tmp(Disturbance_index) - Disturbance_step;
            
            MthHand_ActivatingRate_spline = spline(Data_Set_Time, ActivatingRate_index_tmp(:,1));
            MthShoulder_ActivatingRate_spline = spline(Data_Set_Time, ActivatingRate_index_tmp(:,2));
            MthWaist_ActivatingRate_spline = spline(Data_Set_Time, ActivatingRate_index_tmp(:,3));
            
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
            
            %     ObjectiveValueData = Objective_Fcn(time_onbar, q, breakNum, ActivatingRate_index);
            
            rPB = q(:,1);
            thHand = q(:,2);
            thShoulder = q(:,3);
            thWaist = q(:,4);
            drPB = q(:,5);
            dthHand = q(:,6);
            dthShoulder = q(:,7);
            dthWaist = q(:,8);
            
            yHand = rPB(:,1);
            xHand = zeros(size(yHand));
            dyHand = drPB(:,1);
            dxHand = zeros(size(dyHand));
            %     ddxHand = fnval(fnder(spline(time_onbar, dxHand)), time_onbar);
            %     ddyHand = fnval(fnder(spline(time_onbar, dyHand)), time_onbar);
            %
            %     ddrPB = fnval(fnder(spline(time_onbar, drPB)), time_onbar);
            %     ddthHand = fnval(fnder(spline(time_onbar, dthHand)), time_onbar);
            %     ddthShoulder = fnval(fnder(spline(time_onbar, dthShoulder)), time_onbar);
            %     ddthWaist = fnval(fnder(spline(time_onbar, dthWaist)), time_onbar);
            
            pG = find_pG(mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist,xHand,yHand);
            vG = find_vG(dthHand,dthWaist,dthShoulder,dxHand,dyHand,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
            momentumG = find_momentumG(InertiaLeg,InertiaArm,InertiaBody,dthHand,dthWaist,dthShoulder,dxHand,dyHand,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist,xHand,yHand);
            
            if breakNum == 1
                height = pG(end,2) + vG(end,2)^2/(2*g) + 1.8 - rLeg;
                time_until_landing = vG(end,2)/g + (2*height/g)^0.5; %vG(end,2)がマイナスだった場合でも大丈夫
                omegaG = momentumG(end)/InertiaG;
                spinNum_stability_negative(Disturbance_index) = time_until_landing * omegaG /(2*pi);
                
                ObjectiveValueData_tmp = Objective_Fcn(time_onbar, q, breakNum, ActivatingRate_index_tmp);
                ObjectiveValue_stability_negative(Disturbance_index) = ObjectiveValueData_tmp(1);
            elseif breakNum == 0
                warning('動作が完了しきらなかったものがあります')
            else
                spinNum_stability_negative(Disturbance_index) = 0;
                
                ObjectiveValue_stability_negative(Disturbance_index) = 0;
            end
        end
    end
    toc
    
    changed_Marker = '^';
    negative_Marker = 'v';
    not_changed_Marker = '+';
    
%     xLim = [0.7 1.4];
    xLim = 'auto';
    
%     yLim = [0.9, 1.1];
    yLim = 'auto';
    
%     if DataNames_Index == 1
%         xLim = 'auto';
%         yLim = 'auto';
%     else
%     end

    Data_Set_Time = Data_Set_Time - Take_Off_Time_Original;
    
    figure(1 + figure_Base_Num)
    Target_Joint = 1;
    if ifHold_on
        hold on
    end
    Scatter_tmp_positive = scatter(Data_Set_Time(spinNum_stability_positive_ifchanged(:,Target_Joint)),...
        spinNum_stability_positive(spinNum_stability_positive_ifchanged(:,Target_Joint),Target_Joint)./spinNum,...
        changed_Marker, 'DisplayName', '正への外乱：手首の活性水準');
    hold on
    Scatter_tmp_negative = scatter(Data_Set_Time(spinNum_stability_negative_ifchanged(:,Target_Joint)),...
        spinNum_stability_negative(spinNum_stability_negative_ifchanged(:,Target_Joint),Target_Joint)./spinNum, [],...
        negative_Marker, 'DisplayName', '負への外乱：手首の活性水準');
    if ifScat_not_changed
        scatter(Data_Set_Time(~spinNum_stability_positive_ifchanged(:,Target_Joint)),...
            spinNum_stability_positive(~spinNum_stability_positive_ifchanged(:,Target_Joint),Target_Joint)./spinNum, [],...
            Scatter_tmp_positive.CData, not_changed_Marker, 'DisplayName', '+1だった時間：手首の活性水準')
        scatter(Data_Set_Time(~spinNum_stability_negative_ifchanged(:,Target_Joint)),...
            spinNum_stability_negative(~spinNum_stability_negative_ifchanged(:,Target_Joint),Target_Joint)./spinNum, [],...
            Scatter_tmp_negative.CData, not_changed_Marker, 'DisplayName', '-1だった時間：手首の活性水準')
    end
    hold off
    title(title_Str)
    xlabel('外乱の時刻 (0 がもともとの離手)')
    ylabel('外乱後の回転数/元の回転数')
    legend
    xlim(xLim)
    ylim(yLim)
    
    figure(2 + figure_Base_Num)
    Target_Joint = 2;
    if ifHold_on
        hold on
    end
    Scatter_tmp_positive = scatter(Data_Set_Time(spinNum_stability_positive_ifchanged(:,Target_Joint)),...
        spinNum_stability_positive(spinNum_stability_positive_ifchanged(:,Target_Joint),Target_Joint)./spinNum,...
        changed_Marker, 'DisplayName', '正への外乱：肩の活性水準');
    hold on
    Scatter_tmp_negative = scatter(Data_Set_Time(spinNum_stability_negative_ifchanged(:,Target_Joint)),...
        spinNum_stability_negative(spinNum_stability_negative_ifchanged(:,Target_Joint),Target_Joint)./spinNum, [],...
        negative_Marker, 'DisplayName', '負への外乱：肩の活性水準');
    if ifScat_not_changed
        scatter(Data_Set_Time(~spinNum_stability_positive_ifchanged(:,Target_Joint)),...
            spinNum_stability_positive(~spinNum_stability_positive_ifchanged(:,Target_Joint),Target_Joint)./spinNum, [],...
            Scatter_tmp_positive.CData, not_changed_Marker, 'DisplayName', '+1だった時間：肩の活性水準')
        scatter(Data_Set_Time(~spinNum_stability_negative_ifchanged(:,Target_Joint)),...
            spinNum_stability_negative(~spinNum_stability_negative_ifchanged(:,Target_Joint),Target_Joint)./spinNum, [],...
            Scatter_tmp_negative.CData, not_changed_Marker, 'DisplayName', '-1だった時間：肩の活性水準')
    end
    hold off
    title(title_Str)
    xlabel('外乱の時刻 (0 がもともとの離手)')
    ylabel('外乱後の回転数/元の回転数')
    legend
    xlim(xLim)
    ylim(yLim)
    
    figure(3 + figure_Base_Num)
    Target_Joint = 3;
    if ifHold_on
        hold on
    end
    Scatter_tmp_positive = scatter(Data_Set_Time(spinNum_stability_positive_ifchanged(:,Target_Joint)),...
        spinNum_stability_positive(spinNum_stability_positive_ifchanged(:,Target_Joint),Target_Joint)./spinNum,...
        changed_Marker, 'DisplayName', '正への外乱：腰の活性水準');
    hold on
    Scatter_tmp_negative = scatter(Data_Set_Time(spinNum_stability_negative_ifchanged(:,Target_Joint)),...
        spinNum_stability_negative(spinNum_stability_negative_ifchanged(:,Target_Joint),Target_Joint)./spinNum, [],...
        negative_Marker, 'DisplayName', '負への外乱：腰の活性水準');
    if ifScat_not_changed
        scatter(Data_Set_Time(~spinNum_stability_positive_ifchanged(:,Target_Joint)),...
            spinNum_stability_positive(~spinNum_stability_positive_ifchanged(:,Target_Joint),Target_Joint)./spinNum, [],...
            Scatter_tmp_positive.CData, not_changed_Marker, 'DisplayName', '+1だった時間：腰の活性水準')
        scatter(Data_Set_Time(~spinNum_stability_negative_ifchanged(:,Target_Joint)),...
            spinNum_stability_negative(~spinNum_stability_negative_ifchanged(:,Target_Joint),Target_Joint)./spinNum, [],...
            Scatter_tmp_negative.CData, not_changed_Marker, 'DisplayName', '-1だった時間：腰の活性水準')
    end
    hold off
    title(title_Str)
    xlabel('外乱の時刻 (0 がもともとの離手)')
    ylabel('外乱後の回転数/元の回転数')
    legend
    xlim(xLim)
    ylim(yLim)
    
    
    figure(4 + figure_Base_Num)
    Target_Joint = 1;
    if ifHold_on
        hold on
    end
    Scatter_tmp_positive = scatter(Data_Set_Time(ObjectiveValue_stability_positive_ifchanged(:,Target_Joint)),...
        ObjectiveValue_stability_positive(ObjectiveValue_stability_positive_ifchanged(:,Target_Joint),Target_Joint)./ObjectiveValueData(1),...
        changed_Marker, 'DisplayName', '正への外乱：手首の活性水準');
    hold on
    Scatter_tmp_negative = scatter(Data_Set_Time(ObjectiveValue_stability_negative_ifchanged(:, Target_Joint)),...
        ObjectiveValue_stability_negative(ObjectiveValue_stability_negative_ifchanged(:, Target_Joint), Target_Joint)./ObjectiveValueData(1), [],...
        negative_Marker, 'DisplayName', '負への外乱：手首の活性水準');
    if ifScat_not_changed
        scatter(Data_Set_Time(~ObjectiveValue_stability_positive_ifchanged(:, Target_Joint)),...
            ObjectiveValue_stability_positive(~ObjectiveValue_stability_positive_ifchanged(:, Target_Joint), Target_Joint)./ObjectiveValueData(1), [],...
            Scatter_tmp_positive.CData, not_changed_Marker, 'DisplayName', '+1だった時間：手首の活性水準')
        scatter(Data_Set_Time(~ObjectiveValue_stability_negative_ifchanged(:, Target_Joint)),...
            ObjectiveValue_stability_negative(~ObjectiveValue_stability_negative_ifchanged(:, Target_Joint), Target_Joint)./ObjectiveValueData(1), [],...
            Scatter_tmp_negative.CData, not_changed_Marker, 'DisplayName', '-1だった時間：手首の活性水準')
    end
    hold off
    title(title_Str)
    xlabel('外乱の時刻 (0 がもともとの離手)')
    ylabel('外乱後の評価値/元の評価値')
    legend
    xlim(xLim)
    ylim(yLim)
    
    figure(5 + figure_Base_Num)
    Target_Joint = 2;
    if ifHold_on
        hold on
    end
    Scatter_tmp_positive = scatter(Data_Set_Time(ObjectiveValue_stability_positive_ifchanged(:,Target_Joint)),...
        ObjectiveValue_stability_positive(ObjectiveValue_stability_positive_ifchanged(:,Target_Joint),Target_Joint)./ObjectiveValueData(1),...
        changed_Marker, 'DisplayName', '正への外乱：肩の活性水準');
    hold on
    Scatter_tmp_negative = scatter(Data_Set_Time(ObjectiveValue_stability_negative_ifchanged(:, Target_Joint)),...
        ObjectiveValue_stability_negative(ObjectiveValue_stability_negative_ifchanged(:, Target_Joint), Target_Joint)./ObjectiveValueData(1), [],...
        negative_Marker, 'DisplayName', '負への外乱：肩の活性水準');
    if ifScat_not_changed
        scatter(Data_Set_Time(~ObjectiveValue_stability_positive_ifchanged(:, Target_Joint)),...
            ObjectiveValue_stability_positive(~ObjectiveValue_stability_positive_ifchanged(:, Target_Joint), Target_Joint)./ObjectiveValueData(1), [],...
            Scatter_tmp_positive.CData, not_changed_Marker, 'DisplayName', '+1だった時間：肩の活性水準')
        scatter(Data_Set_Time(~ObjectiveValue_stability_negative_ifchanged(:, Target_Joint)),...
            ObjectiveValue_stability_negative(~ObjectiveValue_stability_negative_ifchanged(:, Target_Joint), Target_Joint)./ObjectiveValueData(1), [],...
            Scatter_tmp_negative.CData, not_changed_Marker, 'DisplayName', '-1だった時間：肩の活性水準')
    end
    hold off
    title(title_Str)
    xlabel('外乱の時刻 (0 がもともとの離手)')
    ylabel('外乱後の評価値/元の評価値')
    legend
    xlim(xLim)
    ylim(yLim)
    
    figure(6 + figure_Base_Num)
    Target_Joint = 3;
    if ifHold_on
        hold on
    end
    Scatter_tmp_positive = scatter(Data_Set_Time(ObjectiveValue_stability_positive_ifchanged(:,Target_Joint)),...
        ObjectiveValue_stability_positive(ObjectiveValue_stability_positive_ifchanged(:,Target_Joint),Target_Joint)./ObjectiveValueData(1),...
        changed_Marker, 'DisplayName', '正への外乱：腰の活性水準');
    hold on
    Scatter_tmp_negative = scatter(Data_Set_Time(ObjectiveValue_stability_negative_ifchanged(:, Target_Joint)),...
        ObjectiveValue_stability_negative(ObjectiveValue_stability_negative_ifchanged(:, Target_Joint), Target_Joint)./ObjectiveValueData(1), [],...
        negative_Marker, 'DisplayName', '負への外乱：腰の活性水準');
    if ifScat_not_changed
        scatter(Data_Set_Time(~ObjectiveValue_stability_positive_ifchanged(:, Target_Joint)),...
            ObjectiveValue_stability_positive(~ObjectiveValue_stability_positive_ifchanged(:, Target_Joint), Target_Joint)./ObjectiveValueData(1), [],...
            Scatter_tmp_positive.CData, not_changed_Marker, 'DisplayName', '+1だった時間：腰の活性水準')
        scatter(Data_Set_Time(~ObjectiveValue_stability_negative_ifchanged(:, Target_Joint)),...
            ObjectiveValue_stability_negative(~ObjectiveValue_stability_negative_ifchanged(:, Target_Joint), Target_Joint)./ObjectiveValueData(1), [],...
            Scatter_tmp_negative.CData, not_changed_Marker, 'DisplayName', '-1だった時間：腰の活性水準')
    end
    hold off
    title(title_Str)
    xlabel('外乱の時刻 (0 がもともとの離手)')
    ylabel('外乱後の評価値/元の評価値')
    legend
    xlim(xLim)
    ylim(yLim)
    
end












































