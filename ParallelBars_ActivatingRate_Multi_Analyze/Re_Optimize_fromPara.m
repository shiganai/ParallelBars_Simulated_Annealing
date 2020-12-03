
clear all

% load_Str = 'Para_1014140750_pop_2400_gen_12392'; % 制限なし
load_Str = 'Para_1107134918_pop_2400_gen_25568'; % value_phase2 で腰を屈曲させる動員率を持たない制限あり

load(load_Str);

index = 1;
ActivatingRate = Para.ActivatingRate;

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
q0 = Para.q0;
absTol = Para.absTol;
Spin_num_Goal = Para.Spin_num_Goal;

ode_Fcn = Para.ode_Fcn;
ode_Event = Para.ode_Event;
Objective_Fcn = Para.Objective_Fcn;

Disturbance_step = 1/Para.ActivatingRate_Step_num;

ActivatingRate_index_Original = [reshape(ActivatingRate(index,1,:), size(Data_Set_Time)), reshape(ActivatingRate(index,2,:), size(Data_Set_Time)), reshape(ActivatingRate(index,3,:), size(Data_Set_Time))];

MthHand_ActivatingRate_spline = spline(Data_Set_Time, ActivatingRate_index_Original(:,1));
MthShoulder_ActivatingRate_spline = spline(Data_Set_Time, ActivatingRate_index_Original(:,2));
MthWaist_ActivatingRate_spline = spline(Data_Set_Time, ActivatingRate_index_Original(:,3));

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

ObjectiveValueData = Objective_Fcn(time_onbar, q, breakNum, ActivatingRate_index_Original);

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
    spinNum_Original = time_until_landing * omegaG /(2*pi);
else
    spinNum_Original = -1;
end

spinNum_Provisional = spinNum_Original;
ObjectiveValue_Provisional = ObjectiveValueData(1);
ActivatingRate_index_Provisional = ActivatingRate_index_Original;

while true

    spinNum_tmp_positive = zeros(size(ActivatingRate_index_Provisional));
    spinNum_tmp_negative = zeros(size(ActivatingRate_index_Provisional));
    spinNum_tmp_positive_ifchanged = ones(size(ActivatingRate_index_Provisional));
    spinNum_tmp_negative_ifchanged = ones(size(ActivatingRate_index_Provisional));
    
    
    ObjectiveValue_tmp_positive = zeros(size(ActivatingRate_index_Provisional));
    ObjectiveValue_tmp_negative = zeros(size(ActivatingRate_index_Provisional));
    ObjectiveValue_tmp_positive_ifchanged = true(size(ActivatingRate_index_Provisional));
    ObjectiveValue_tmp_negative_ifchanged = true(size(ActivatingRate_index_Provisional));
    
    tic
    parfor Disturbance_index = 1:size(ActivatingRate_index_Provisional(:),1)
        
        if abs(ActivatingRate_index_Provisional(Disturbance_index) - 1) < 1e-2 % 1なら
            spinNum_tmp_positive(Disturbance_index) = spinNum_Provisional;
            spinNum_tmp_positive_ifchanged(Disturbance_index) = 0;
            
            ObjectiveValue_tmp_positive(Disturbance_index) = ObjectiveValue_Provisional;
            ObjectiveValue_tmp_positive_ifchanged(Disturbance_index) = false;
        else % 1じゃないなら
            
            ActivatingRate_index_tmp = ActivatingRate_index_Provisional;
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
                spinNum_tmp_positive(Disturbance_index) = time_until_landing * omegaG /(2*pi);
                
                ObjectiveValueData_tmp = Objective_Fcn(time_onbar, q, breakNum, ActivatingRate_index_tmp);
                ObjectiveValue_tmp_positive(Disturbance_index) = ObjectiveValueData_tmp(1);
            else
                spinNum_tmp_positive(Disturbance_index) = 0;
            
                ObjectiveValue_tmp_positive(Disturbance_index) = 100;
            end
        end
        
        
        if abs(ActivatingRate_index_Provisional(Disturbance_index) - -1) < 1e-2 % -1なら
            spinNum_tmp_negative(Disturbance_index) = spinNum_Provisional;
            spinNum_tmp_negative_ifchanged(Disturbance_index) = 0;
        
            ObjectiveValue_tmp_negative(Disturbance_index) = ObjectiveValue_Provisional;
            ObjectiveValue_tmp_negative_ifchanged(Disturbance_index) = false;
        else % -1じゃないなら
            
            ActivatingRate_index_tmp = ActivatingRate_index_Provisional;
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
                spinNum_tmp_negative(Disturbance_index) = time_until_landing * omegaG /(2*pi);
            
                ObjectiveValueData_tmp = Objective_Fcn(time_onbar, q, breakNum, ActivatingRate_index_tmp);
                ObjectiveValue_tmp_negative(Disturbance_index) = ObjectiveValueData_tmp(1);
            else
                spinNum_tmp_negative(Disturbance_index) = 0;
            
            ObjectiveValue_tmp_negative(Disturbance_index) = 100;
            end
        end
    end
    toc
    
    % spinNum 版
    %{
    spinNum_tmp_All = [spinNum_tmp_positive(:); spinNum_tmp_negative(:)];
    spinNum_tmp_ifchanged_All = [spinNum_tmp_positive_ifchanged(:); spinNum_tmp_negative_ifchanged(:)];
    Max_spinNum_tmp_All = max(spinNum_tmp_All, [], 'all');
    Max_spinNum_tmp_All_Index = find(spinNum_tmp_All == Max_spinNum_tmp_All);
    
    if size(Max_spinNum_tmp_All_Index, 1) ~= 1 % もし最高回転のものが複数あったら
        if any(spinNum_tmp_ifchanged_All(Max_spinNum_tmp_All_Index)) % もしどれかが変化させたうえで一致していたら
            
            changed_Max_spinNum_Index = Max_spinNum_tmp_All_Index(spinNum_tmp_ifchanged_All(Max_spinNum_tmp_All_Index));
            Next_Provisional_Max_spinNum_tmp_All_Index = randi(size(changed_Max_spinNum_Index,1), 1);
            Next_Provisional_Index = Max_spinNum_tmp_All_Index(Next_Provisional_Max_spinNum_tmp_All_Index);
            
        else % もしどれもが変化させていなかったら (spinNum_Provisionalと一致しているはず)
            break
        end
    else % もし最高回転のものが1つだけだったら
        if spinNum_tmp_ifchanged_All(Max_spinNum_tmp_All_Index) % 最高回転の場所が変化させたものだったら
            Next_Provisional_Index = Max_spinNum_tmp_All_Index;
        else % 最高回転の場所が変化させてないものだったら
            break
        end
    end
    
    if Max_spinNum_tmp_All_Index <= size(spinNum_tmp_positive(:), 1) % 正への外乱
        ActivatingRate_index_Provisional(Max_spinNum_tmp_All_Index) = ActivatingRate_index_Provisional(Max_spinNum_tmp_All_Index) + Disturbance_step;
    else  % 負への外乱
        ActivatingRate_index_Provisional(Max_spinNum_tmp_All_Index - size(spinNum_tmp_positive(:), 1)) = ActivatingRate_index_Provisional(Max_spinNum_tmp_All_Index - size(spinNum_tmp_positive(:), 1)) - Disturbance_step;
    end
    %}
    
    % ObjectiveValue 版
    %{/
    ObjectiveValue_tmp_All = [ObjectiveValue_tmp_positive(:); ObjectiveValue_tmp_negative(:)];
    ObjectiveValue_tmp_ifchanged_All = [ObjectiveValue_tmp_positive_ifchanged(:); ObjectiveValue_tmp_negative_ifchanged(:)];
    Min_ObjectiveValue_tmp_All = min(ObjectiveValue_tmp_All, [], 'all');
    Min_ObjectiveValue_tmp_All_Index = find(ObjectiveValue_tmp_All == Min_ObjectiveValue_tmp_All);
    Min_ObjectiveValue_tmp_All_Index = Min_ObjectiveValue_tmp_All_Index(:);
    
    if size(Min_ObjectiveValue_tmp_All_Index, 1) ~= 1 % もし最高評価のものが複数あったら
        if any(ObjectiveValue_tmp_ifchanged_All(Min_ObjectiveValue_tmp_All_Index)) % もしどれかが変化させたうえで一致していたら
            
            changed_Max_ObjectiveValue_Index = Min_ObjectiveValue_tmp_All_Index(ObjectiveValue_tmp_ifchanged_All(Min_ObjectiveValue_tmp_All_Index));
            Next_Provisional_Max_ObjectiveValue_tmp_All_Index = randi(size(changed_Max_ObjectiveValue_Index,1), 1);
            Next_Provisional_Index = Min_ObjectiveValue_tmp_All_Index(Next_Provisional_Max_ObjectiveValue_tmp_All_Index);
            
        else % もしどれもが変化させていなかったら (ObjectiveValue_Provisionalと一致しているはず)
            break
        end
    else % もし最高評価のものが1つだけだったら
        if ObjectiveValue_tmp_ifchanged_All(Min_ObjectiveValue_tmp_All_Index) % 最高評価の場所が変化させたものだったら
            Next_Provisional_Index = Min_ObjectiveValue_tmp_All_Index;
        else % 最高評価の場所が変化させてないものだったら
            break
        end
    end
    
    if Min_ObjectiveValue_tmp_All_Index <= size(ObjectiveValue_tmp_positive(:), 1) % 正への外乱
        ActivatingRate_index_Provisional(Min_ObjectiveValue_tmp_All_Index) = ActivatingRate_index_Provisional(Min_ObjectiveValue_tmp_All_Index) + Disturbance_step;
    else  % 負への外乱
        ActivatingRate_index_Provisional(Min_ObjectiveValue_tmp_All_Index - size(ObjectiveValue_tmp_positive(:), 1))...
            = ActivatingRate_index_Provisional(Min_ObjectiveValue_tmp_All_Index - size(ObjectiveValue_tmp_positive(:), 1)) - Disturbance_step;
    end
    %}
    
    
    % 以下再計算
    ActivatingRate_index_tmp = ActivatingRate_index_Provisional;
    
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
        spinNum_Provisional = time_until_landing * omegaG /(2*pi);
        
        ObjectiveValueData_tmp = Objective_Fcn(time_onbar, q, breakNum, ActivatingRate_index_tmp);
        ObjectiveValue_Provisional = ObjectiveValueData_tmp(1);
    else
        spinNum_Provisional = 0;
        
        ObjectiveValue_Provisional = 100;
    end
end

save_Name = '_Provisional_ObjectiveValue';

ifsave = input(strcat('Para', save_Name, 'を上書きしますか？ 1/0 [0]---'));
if isempty(ifsave)
    ifsave = 0;
end

if ifsave
    Para_Provisional.constants = Para.constants;
    
    Para_Provisional.Data_Set_Time = Para.Data_Set_Time;
    Para_Provisional.odeTime = Para.odeTime;
    Para_Provisional.q0 = Para.q0;
    Para_Provisional.absTol = Para.absTol;
    Para_Provisional.Spin_num_Goal = Para.Spin_num_Goal;
    
    Para_Provisional.ode_Fcn = Para.ode_Fcn;
    Para_Provisional.ode_Event = Para.ode_Event;
    Para_Provisional.Objective_Fcn = Para.Objective_Fcn;
    
    Para_Provisional.ActivatingRate_Step_num = Para.ActivatingRate_Step_num;
    
    Para_Provisional.ActivatingRate_index_Provisional = ActivatingRate_index_Provisional;
    Para_Provisional.ObjectiveValue_Provisional = ObjectiveValue_Provisional;
    Para_Provisional.spinNum_Provisional= spinNum_Provisional;
    
    save(strcat(load_Str, save_Name), 'Para_Provisional')
end








































