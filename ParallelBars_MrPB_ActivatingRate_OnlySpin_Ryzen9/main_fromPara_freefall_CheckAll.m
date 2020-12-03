if ~exist('ifsave','var')
    ifsave = false;
end

load('Para_0518104752_pop_2400_gen_5824')

% ExtreamPoint = Para.ExtreamPoint;
% ExtreamPoint_num = Para.ExtreamPoint_num;
% ObjectiveValueDatas = Para.ObjectiveValueDatas;

% ExtreamPoint = Para.midterm_elitest_ExtreamPoint;
% ExtreamPoint_num = Para.midterm_elitest_ExtreamPoint_num;
% ObjectiveValueDatas = Para.midterm_elitest_ObjectiveValueDatas;

ExtreamPoint = flip(Para.midterm_elitest_ExtreamPoint,4);
ExtreamPoint_num = flip(Para.midterm_elitest_ExtreamPoint_num,1);
ObjectiveValueDatas = flip(Para.midterm_elitest_ObjectiveValueDatas,1);

constants = Para.constants;

g = constants.g;
kPB = constants.kPB;
cPB = constants.cPB;
mAll = constants.mAll;
mPB = constants.mPB;
rAll = constants.rAll;
mArm = constants.mArm;
mBody = constants.mBody;
mLeg = constants.mLeg;
rArm = constants.rArm;
rBody = constants.rBody;
rLeg = constants.rLeg;
thHand_MaxTorque = constants.thHand_MaxTorque;
thShoulder_MaxTorque = constants.thShoulder_MaxTorque;
thWaist_MaxTorque = constants.thWaist_MaxTorque;
InertiaModel = constants.InertiaModel;
rArmMCD = constants.rArmMCD;
rBodyMCD = constants.rBodyMCD;
rLegMCD = constants.rLegMCD;
InertiaArm = constants.InertiaArm;
InertiaBody = constants.InertiaBody;
InertiaLeg = constants.InertiaLeg;
InertiaG = constants.InertiaG;

t = Para.odeTime;
% t = 0:1e-4:10;

q0 = Para.q0;
odeEvent = Para.odeEvent;
absTol = Para.absTol;

dthHand_ExtreamPoint = ExtreamPoint(:,:,1,:);
dthShoulder_ExtreamPoint = ExtreamPoint(:,:,2,:);
dthWaist_ExtreamPoint = ExtreamPoint(:,:,3,:);

for index = 1:size(dthHand_ExtreamPoint,4)
    
    ddthHand_pp = fnder(GetdthTH_pp(dthHand_ExtreamPoint(1:ExtreamPoint_num(index,1),:,:,index)));
    ddthShoulder_pp = fnder(GetdthTH_pp(dthShoulder_ExtreamPoint(1:ExtreamPoint_num(index,2),:,:,index)));
    ddthWaist_pp = fnder(GetdthTH_pp(dthWaist_ExtreamPoint(1:ExtreamPoint_num(index,3),:,:,index)));
    
    ddpp_time_histories = [ddthHand_pp, ddthShoulder_pp, ddthWaist_pp]';
    ode = @(t, q) ddt_Realization(t, q, constants, ddpp_time_histories);
    eventFcn = @(t,q)odeEvent(t,q,ddpp_time_histories);
    
    odeOption = odeset('Events', eventFcn, 'AbsTol', absTol);
    
    tic
    [time_onbar, q, te, ye, ie] = ode45(ode, t, q0, odeOption);
    toc
    
    if ~isempty(ie)
        breakNum = ie(end);
    else
        breakNum = 0;
    end
    ObjectiveValueData = ObjectiveFcn(time_onbar, q, constants, breakNum);
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
    
    ddrPB = ppval(fnder(spline(time_onbar, drPB)), time_onbar);
    ddthHand = fnval(ddthHand_pp, time_onbar);
    ddthShoulder = fnval(ddthShoulder_pp, time_onbar);
    ddthWaist = fnval(ddthWaist_pp, time_onbar);
    
    % ddrPB = ppval(fnder(spline(time_onbar, drPB)), time_onbar);
    % ddthHand = ppval(fnder(spline(time_onbar, dthHand)), time_onbar);
    % ddthShoulder = ppval(fnder(spline(time_onbar, dthShoulder)), time_onbar);
    % ddthWaist = ppval(fnder(spline(time_onbar, dthWaist)), time_onbar);
    
    MrPB = find_MrPB(ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,kPB,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,rPB,thHand,thShoulder,thWaist);
    MthHand = find_MthHand(InertiaLeg,InertiaArm,InertiaBody,ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
    MthShoulder = find_MthShoulder(InertiaLeg,InertiaBody,ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,mBody,mLeg,rArm,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
    MthWaist = find_MthWaist(InertiaLeg,ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthShoulder,g,mLeg,rArm,rBody,rLegMCD,thHand,thShoulder,thWaist);
    
    KE = find_KE(InertiaLeg,InertiaArm,InertiaBody,dthHand,dthWaist,dthShoulder,dxHand,dyHand,g,kPB,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist,yHand);
    % dKE = find_dKE(InertiaLeg,InertiaArm,InertiaBody,ddthHand,ddthWaist,ddthShoulder,ddxHand,ddyHand,dthHand,dthWaist,dthShoulder,dxHand,dyHand,g,kPB,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist,yHand);
    dKE = ppval(fnder(spline(time_onbar, KE)), time_onbar);
    
    pHand = [zeros(size(rPB(:,1))), rPB];
    vHand = [zeros(size(rPB(:,1))), drPB];
    
    if breakNum == 1
        
        pG = find_pG(mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist,xHand,yHand);
        vG = find_vG(dthHand,dthWaist,dthShoulder,dxHand,dyHand,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
        momentumG = find_momentumG(dthHand,dthWaist,dthShoulder,dxHand,dyHand,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLeg,rLegMCD,thHand,thShoulder,thWaist,xHand,yHand);
        
        height = pG(end,2) + vG(end,2)^2/(2*g) + 1.8 - rLeg;
        time_until_landing = vG(end,2)/g + (2*height/g)^0.5; %vG(end,2)がマイナスだった場合でも大丈夫
        omegaG = momentumG(end)/InertiaG;
        spinNum = time_until_landing * omegaG /(2*pi)
        
        t_freefall = 0:time_onbar(2,1) - time_onbar(1,1):10;
        q0_freefall = [0, q(end,1), q(end,2), q(end,3), q(end,4), 0, q(end,5), q(end,6), q(end,7), q(end,8)]';
        
        eventFcn_freefall = @(t,q)Events_freefall(t, q, constants);
        odeOption_freefall = odeset('Events', eventFcn_freefall ,'AbsTol', Para.absTol);
        ode_freefall = @(t,q) ddt_freefall(t, q, constants);
        
        [time_freefall, q_freefall] = ode45(ode_freefall, t_freefall, q0_freefall, odeOption_freefall);
        
        time = [time_onbar(:,1); time_freefall(2:end,1) + time_onbar(end,1)];
        
        xHand = [xHand; q_freefall(2:end, 1)];
        yHand = [yHand; q_freefall(2:end, 2)];
        thHand = [thHand; q_freefall(2:end,3)];
        thShoulder = [thShoulder; q_freefall(2:end,4)];
        thWaist = [thWaist; q_freefall(2:end,5)];
        
        dxHand = [dxHand; q_freefall(2:end, 6)];
        dyHand = [dyHand; q_freefall(2:end, 7)];
        dthHand = [dthHand; q_freefall(2:end,8)];
        dthShoulder = [dthShoulder; q_freefall(2:end,9)];
        dthWaist = [dthWaist; q_freefall(2:end,10)];
        
        MrPB = [MrPB; zeros(size(time_freefall(2:end,1)))];
        MthHand = [MthHand; zeros(size(time_freefall(2:end,1)))];
        MthShoulder = [MthShoulder; zeros(size(time_freefall(2:end,1)))];
        MthWaist = [MthWaist; zeros(size(time_freefall(2:end,1)))];
        
        pHand = [xHand, yHand];
        %     pShoulder = pHand + rArm * [cos(thHand+1/2*pi), sin(thHand+1/2*pi)];
        %     pWaist = pShoulder + rBody * [cos(thHand+1/2*pi + thShoulder), sin(thHand+1/2*pi + thShoulder)];
        %     pToe = pWaist + rLeg * [cos(thHand+1/2*pi + thShoulder + thWaist), sin(thHand+1/2*pi + thShoulder + thWaist)];
        
        vHand = [dxHand, dyHand];
        %     vShoulder = vHand + rArm * [-sin(thHand+1/2*pi), cos(thHand+1/2*pi)] .* dthHand;
        %     vWaist = vShoulder + rBody * [-sin(thHand+1/2*pi + thShoulder), cos(thHand+1/2*pi + thShoulder)] .* (dthHand + dthShoulder);
        %     vToe = vWaist + rLeg * [-sin(thHand+1/2*pi + thShoulder + thWaist), cos(thHand+1/2*pi + thShoulder + thWaist)] .* (dthHand + dthShoulder + dthWaist);
        
        rPB = [rPB(:,1); zeros(size(time_freefall(2:end,1))) + rPB(end,1)];
        drPB = [drPB(:,1); zeros(size(time_freefall(2:end,1))) + drPB(end,1)];
        
        ddrPB = [ddrPB(:,1); zeros(size(time_freefall(2:end,1)))];
        ddthHand = [ddthHand(:,1); zeros(size(time_freefall(2:end,1)))];
        ddthShoulder = [ddthShoulder(:,1); zeros(size(time_freefall(2:end,1)))];
        ddthWaist = [ddthWaist(:,1); zeros(size(time_freefall(2:end,1)))];
        
    else
        warning("離手失敗")
        time = time_onbar;
    end
    pShoulder = pHand + rArm * [cos(thHand+1/2*pi), sin(thHand+1/2*pi)];
    pWaist = pShoulder + rBody * [cos(thHand+1/2*pi + thShoulder), sin(thHand+1/2*pi + thShoulder)];
    pToe = pWaist + rLeg * [cos(thHand+1/2*pi + thShoulder + thWaist), sin(thHand+1/2*pi + thShoulder + thWaist)];
    
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
    KE = [KE; zeros([size(momentumG,1)-size(KE,1),1])];
    dKE = [dKE; zeros([size(momentumG,1)-size(dKE,1),1])];
    
    Anime_main
    graphs_main.FirstPlay()
    
end







































