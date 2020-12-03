if ~exist('ifsave','var')
    ifsave = false;
end

load('Para_0909114047_pop_2400_gen_16454_2')

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
% t = 0:1e-4:4;
q0 = Para.q0;
absTol = Para.absTol;
% absTol = 1e-8;
Spin_num_Goal = Para.Spin_num_Goal;

ode_Fcn = Para.ode_Fcn;
ode_Event = Para.ode_Event;
Objective_Fcn = Para.Objective_Fcn;

for index = 1:size(ActivatingRate,1)
    
    fprintf(strcat("index = ", num2str(index), "\n"))
    
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
    
    DispObjectiveValueData(ObjectiveValueData, 0)
    
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
    
    ddrPB = fnval(fnder(spline(time_onbar, drPB)), time_onbar);
    ddthHand = fnval(fnder(spline(time_onbar, dthHand)), time_onbar);
    ddthShoulder = fnval(fnder(spline(time_onbar, dthShoulder)), time_onbar);
    ddthWaist = fnval(fnder(spline(time_onbar, dthWaist)), time_onbar);
    
    % ddthHand = fnval(ddthHand_pp, time_onbar);
    % ddthShoulder = fnval(ddthShoulder_pp, time_onbar);
    % ddthWaist = fnval(ddthWaist_pp, time_onbar);
    
    % MrPB = -cPB * drPB;
    MrPB = find_MrPB(ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
    MthHand = find_MthHand(InertiaLeg,InertiaArm,InertiaBody,ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
    MthShoulder = find_MthShoulder(InertiaLeg,InertiaBody,ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,mBody,mLeg,rArm,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
    MthWaist = find_MthWaist(InertiaLeg,ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthShoulder,g,mLeg,rArm,rBody,rLegMCD,thHand,thShoulder,thWaist);

    % 最大トルクダブルチェック機構
    %{
Index_AtOverMaxTorque = min([find(abs(MthHand) > thHand_MaxTorque, 1), find(abs(MthShoulder) > thShoulder_MaxTorque, 1), find(abs(MthWaist) > thWaist_MaxTorque, 1)]);

if ~isempty(Index_AtOverMaxTorque)
    time_onbar = time_onbar(1:Index_AtOverMaxTorque,1);
    time = time_onbar;
    q = q(1:Index_AtOverMaxTorque,:);
    
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
    
    ddrPB = ppval(fnder(spline(time_onbar, drPB)), time_onbar);
    
    ddthHand = fnval(ddthHand_pp, time_onbar);
    ddthShoulder = fnval(ddthShoulder_pp, time_onbar);
    ddthWaist = fnval(ddthWaist_pp, time_onbar);
    
    MrPB = -cPB * drPB;
    MthHand = find_MthHand(InertiaLeg,InertiaArm,InertiaBody,ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
    MthShoulder = find_MthShoulder(InertiaLeg,InertiaBody,ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,mBody,mLeg,rArm,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
    MthWaist = find_MthWaist(InertiaLeg,ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthShoulder,g,mLeg,rArm,rBody,rLegMCD,thHand,thShoulder,thWaist);
end
    %}
    
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
    momentumG = find_momentumG(InertiaLeg,InertiaArm,InertiaBody,dthHand,dthWaist,dthShoulder,dxHand,dyHand,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist,xHand,yHand);
    % dmomentumG = find_dmomentumG(InertiaLeg,InertiaArm,InertiaBody,ddthHand,ddthWaist,ddthShoulder,ddxHand,ddyHand,dthHand,dthWaist,dthShoulder,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist,xHand,yHand);
    
    
    Fx_Hand = find_Fx_Hand(ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
    Fy_Hand = find_Fy_Hand(ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);

    thHand_degree = rad2deg(thHand);
    thShoulder_degree = rad2deg(thShoulder);
    thWaist_degree = rad2deg(thWaist);
    dthHand_degree = rad2deg(dthHand);
    dthShoulder_degree = rad2deg(dthShoulder);
    dthWaist_degree = rad2deg(dthWaist);
    
    thHand_degree_VT = thHand_degree;
    thHand_degree_VT(thHand_degree < Hand_Para.theta_PE_1_Ext) = Hand_Para.theta_PE_1_Ext;
    thHand_degree_VT(thHand_degree > Hand_Para.theta_PE_1_Flex) = Hand_Para.theta_PE_1_Flex;
    
    
    MthHand_MaxTorque = VoluntaryTorque(Hand_Para, thHand_degree_VT, dthHand_degree, 1) * 2;
    MthHand_MinTorque = VoluntaryTorque(Hand_Para, thHand_degree_VT, dthHand_degree, -1) * 2;
    MthHand_PassiveTorque = VoluntaryTorque(Hand_Para, thHand_degree_VT, dthHand_degree, 0) * 2;
    MthShoulder_MaxTorque = VoluntaryTorque(Shoulder_Para, thShoulder_degree, dthShoulder_degree, 1) * 2;
    MthShoulder_MinTorque = VoluntaryTorque(Shoulder_Para, thShoulder_degree, dthShoulder_degree, -1) * 2;
    MthShoulder_PassiveTorque = VoluntaryTorque(Shoulder_Para, thShoulder_degree, dthShoulder_degree, 0) * 2;
    MthWaist_MaxTorque = VoluntaryTorque(Waist_Para, thWaist_degree, dthWaist_degree, 1) * 2;
    MthWaist_MinTorque = VoluntaryTorque(Waist_Para, thWaist_degree, dthWaist_degree, -1) * 2;
    MthWaist_PassiveTorque = VoluntaryTorque(Waist_Para, thWaist_degree, dthWaist_degree, 0) * 2;
    
    MthHand_ActivatedRate_Ext = (MthHand - MthHand_PassiveTorque) ./ (MthHand_MaxTorque - MthHand_PassiveTorque);
    MthHand_ActivatedRate_Flex = (MthHand_PassiveTorque - MthHand) ./ (MthHand_PassiveTorque - MthHand_MinTorque);
    MthShoulder_ActivatedRate_Ext = (MthShoulder - MthShoulder_PassiveTorque) ./ (MthShoulder_MaxTorque - MthShoulder_PassiveTorque);
    MthShoulder_ActivatedRate_Flex = (MthShoulder_PassiveTorque - MthShoulder) ./ (MthShoulder_PassiveTorque - MthShoulder_MinTorque);
    MthWaist_ActivatedRate_Ext = (MthWaist - MthWaist_PassiveTorque) ./ (MthWaist_MaxTorque - MthWaist_PassiveTorque);
    MthWaist_ActivatedRate_Flex = (MthWaist_PassiveTorque - MthWaist) ./ (MthWaist_PassiveTorque - MthWaist_MinTorque);
    
    MthHand_ActivatedRate = MthHand_ActivatedRate_Ext;
    MthHand_ActivatedRate(MthHand_ActivatedRate < 0) = -MthHand_ActivatedRate_Flex(MthHand_ActivatedRate < 0);
    
    MthShoulder_ActivatedRate = MthShoulder_ActivatedRate_Ext;
    MthShoulder_ActivatedRate(MthShoulder_ActivatedRate < 0) = -MthShoulder_ActivatedRate_Flex(MthShoulder_ActivatedRate < 0);
    
    MthWaist_ActivatedRate = MthWaist_ActivatedRate_Ext;
    MthWaist_ActivatedRate(MthWaist_ActivatedRate < 0) = -MthWaist_ActivatedRate_Flex(MthWaist_ActivatedRate < 0);
    
    %{
    figure(1)
    plot(time, [MthHand_ActivatedRate, MthShoulder_ActivatedRate, MthWaist_ActivatedRate])
    legend({'手首の動員率', '肩の動員率', '腰の動員率'})
    
    figure(2)
    plot(pG(:,1), pG(:,2))
    xlim([-1, 1])
    ylim([-1, 1])
    pbaspect([1, 1, 1])
    grid on
    
    figure(3)
    plot(time, [MthHand, MthShoulder, MthWaist])
    legend({'手首のトルク','肩のトルク','腰のトルク'},'location','best')
    
    figure(4)
    plot(time, [dthHand, dthShoulder, dthWaist])
    legend({'手首の角速度','肩の角速度','腰の角速度'},'location','best')
    
    figure(5)
    plot(time, rad2deg([thHand, thShoulder, thWaist]))
    legend({'手首の角度','肩の角度','腰の角度'},'location','best')
    yticks(-360:90:360)
    ax = gca;
    ax.YGrid = 'on';
    
    figure(6)
    plot(time, pG(:,1))
    legend('重心の水平座標')
    grid on
    
    figure(7)
    plot(time, FxPB)
    legend('重心の鉛直座標')
    grid on
    
    figure(8)
    plot(time, FyPB)
    legend('鉛直方向の反力')
    grid on
    
    figure(9)
    plot(time, - pG(:,1) .* FyPB)
    legend('鉛直方向の反力による重心周りのトルク')
    grid on
    
    figure(2)
    
    % plot(time, MthShoulder, time, [MthShoulder_MaxTorque, MthShoulder_MinTorque], '-.')
    %}
    
    time_AtBodyUpStraight = interp1(thHand+1/2*pi + thShoulder, time, 3/2*pi);
    thWaist_AtBodyUpStraight = rad2deg(interp1(time, thWaist, time_AtBodyUpStraight));
    fprintf(strcat("thWaist_AtBodyUpStraight = ", num2str(thWaist_AtBodyUpStraight), "[°]\n"));

    if breakNum == 1
        height = pG(end,2) + vG(end,2)^2/(2*g) + 1.8 - rLeg;
        time_until_landing = vG(end,2)/g + (2*height/g)^0.5; %vG(end,2)がマイナスだった場合でも大丈夫
        omegaG = momentumG(end)/InertiaG;
        spinNum = time_until_landing * omegaG /(2*pi);
        
        fprintf(strcat("spinNum = ", num2str(spinNum), "\n"))
    end
    
    Anime_main
    graphs_main.FirstPlay()
    
    % パート分け
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
    
    value_phase2 = (a5 - a4) * abs(b5 - b4) / (b5 - b4);
    
    value_phase3 = min(thWaist(phase3));
    
    fprintf(...
        strcat("value_phase2 = ", num2str(value_phase2),...
        ", value_phase3 = ", num2str(value_phase3),...
        '\n')...
        )
    
    inputStr = input("if done, input e : ", 's');
    if isequal(inputStr, 'e')
        break
    end
end












