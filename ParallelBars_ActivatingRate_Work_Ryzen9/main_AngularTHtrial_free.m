


constants = constants_HH;
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
InertiaModel = constants.InertiaModel;
rArmMCD = constants.rArmMCD;
rBodyMCD = constants.rBodyMCD;
rLegMCD = constants.rLegMCD;
InertiaArm = constants.InertiaArm;
InertiaBody = constants.InertiaBody;
InertiaLeg = constants.InertiaLeg;
inertiaG = constants.inertiaG;

time_ppval = 0:1e-3:3.5;

dthHand_ExtreamPoint = [0, 0;
    0.2, 0;
    0.6, -2;
    0.8, 5;
    1, 0;
    ];
dthHand_pp = GetdthTH_pp(dthHand_ExtreamPoint);
thHand_pp = fnint(GetdthTH_pp(dthHand_ExtreamPoint),0);
ddthHand_pp = fnder(dthHand_pp);

% figure(1)
% plot(time, dthHand, time_ppval, ppval(dthHand_pp, time_ppval))
% 
% figure(2)
% plot(time, thHand, time_ppval, fnval(thHand_pp, time_ppval))

dthShoulder_ExtreamPoint = [0, 0;
    1, 10;
    2, 10;
    ];
dthShoulder_pp = GetdthTH_pp(dthShoulder_ExtreamPoint);
thShoulder_pp = fnint(GetdthTH_pp(dthShoulder_ExtreamPoint),0);
ddthShoulder_pp = fnder(dthShoulder_pp);

% figure(1)
% plot(time, dthShoulder,time_ppval, ppval(dthShoulder_pp, time_ppval))
% 
% figure(2)
% plot(time, thShoulder,time_ppval, fnval(thShoulder_pp, time_ppval))

dthWaist_ExtreamPoint = [0, 0;
    1,0];
dthWaist_pp = GetdthTH_pp(dthWaist_ExtreamPoint);
thWaist_pp = fnint(GetdthTH_pp(dthWaist_ExtreamPoint), 0);
ddthWaist_pp = fnder(dthWaist_pp);

% figure(1)
% plot(time, dthWaist,time_ppval, ppval(dthWaist_pp, time_ppval))
% 
% figure(2)
% plot(time, thWaist,time_ppval, fnval(thWaist_pp, time_ppval))

q0 = [-(mAll + mPB)*g/kPB, fnval(thHand_pp, 0), fnval(thShoulder_pp, 0), fnval(thWaist_pp, 0),...
    0, fnval(dthHand_pp, 0), fnval(dthShoulder_pp, 0), fnval(dthWaist_pp, 0)];

t_ode = 0:1e-3:10;

eventFcn = @(t,q)Events_NoneJointLimit(t,q,constants);
% eventFcn = @(t,q)Events(t,q,constants, ddpp_time_histories);

ddpp_time_histories = [ddthHand_pp, ddthShoulder_pp, ddthWaist_pp]';

ode = @(t, q) ddt_Realization(t, q, constants, ddpp_time_histories);

% odeOption = odeset('AbsTol', 1e-5);
odeOption = odeset('Events', eventFcn, 'AbsTol', 1e-5);

[time_onbar, q, te, ye, ie] = ode45(ode, t_ode, q0, odeOption);

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

ddrPB = ppval(fnder(spline(time_onbar, drPB)), time_onbar);
ddthHand = ppval(fnder(spline(time_onbar, dthHand)), time_onbar);
ddthShoulder = ppval(fnder(spline(time_onbar, dthShoulder)), time_onbar);
ddthWaist = ppval(fnder(spline(time_onbar, dthWaist)), time_onbar);

MrPB = find_MrPB(constants,ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,rPB,thHand,thShoulder,thWaist);
MthHand = find_MthHand(constants,ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,thHand,thShoulder,thWaist);
MthShoulder = find_MthShoulder(constants,ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,thHand,thShoulder,thWaist);
MthWaist = find_MthWaist(constants,ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthShoulder,thHand,thShoulder,thWaist);

pHand = [zeros(size(rPB(:,1))), rPB];
vHand = [zeros(size(rPB(:,1))), drPB];

KE = find_KE(constants,drPB,dthHand,dthWaist,dthShoulder,rPB,thHand,thShoulder,thWaist);
dKE = ppval(fnder(spline(time_onbar, KE)), time_onbar);

if breakNum == 1
    
    
    pG = find_pG(constants, pHand, thHand, thShoulder, thWaist);
    vG = find_vG(constants, vHand, thHand, thShoulder, thWaist, dthHand, dthShoulder, dthWaist);
    momentumG = find_momentumG(constants, pHand, vHand, thHand, thShoulder, thWaist, dthHand, dthShoulder, dthWaist);
    
    height = pG(end,2) + vG(end,2)^2/(2*g) + 1.8 - rLeg;
    time_until_landing = vG(end,2)/g + (2*height/g)^0.5; %vG(end,2)がマイナスだった場合でも大丈夫
    omegaG = momentumG(end)/inertiaG;
    spinNum = time_until_landing * omegaG /(2*pi)
    
    t_freefall = 0:1e-3:10;
    q0_freefall = [0, q(end,1), q(end,2), q(end,3), q(end,4), 0, q(end,5), q(end,6), q(end,7), q(end,8)]';
    
    eventFcn_freefall = @(t,q)Events_freefall(t, q, constants);
    odeOption_freefall = odeset('Events', eventFcn_freefall ,'AbsTol', 1e-5);
    ode_freefall = @(t,q) ddt_freefall(t, q, constants);
    
    [time_freefall, q_freefall] = ode45(ode_freefall, t_freefall, q0_freefall, odeOption_freefall);
    
    time = [time_onbar(:,1); time_freefall(2:end,1) + time_onbar(end,1)];
    
    thHand = [thHand; q_freefall(2:end,3)];
    thShoulder = [thShoulder; q_freefall(2:end,4)];
    thWaist = [thWaist; q_freefall(2:end,5)];
    
    dthHand = [dthHand; q_freefall(2:end,8)];
    dthShoulder = [dthShoulder; q_freefall(2:end,9)];
    dthWaist = [dthWaist; q_freefall(2:end,10)];
    
    MrPB = [MrPB; zeros(size(time_freefall(2:end,1)))];
    MthHand = [MthHand; zeros(size(time_freefall(2:end,1)))];
    MthShoulder = [MthShoulder; zeros(size(time_freefall(2:end,1)))];
    MthWaist = [MthWaist; zeros(size(time_freefall(2:end,1)))];
    
    pHand = [zeros(size(rPB)), rPB; q_freefall(2:end,1), q_freefall(2:end,2)];
    pShoulder = pHand + rArm * [cos(thHand+1/2*pi), sin(thHand+1/2*pi)];
    pWaist = pShoulder + rBody * [cos(thHand+1/2*pi + thShoulder), sin(thHand+1/2*pi + thShoulder)];
    pToe = pWaist + rLeg * [cos(thHand+1/2*pi + thShoulder + thWaist), sin(thHand+1/2*pi + thShoulder + thWaist)];
    
    vHand = [zeros(size(drPB)), drPB; q_freefall(2:end,6), q_freefall(2:end,7)];
    vShoulder = vHand + rArm * [-sin(thHand+1/2*pi), cos(thHand+1/2*pi)] .* dthHand;
    vWaist = vShoulder + rBody * [-sin(thHand+1/2*pi + thShoulder), cos(thHand+1/2*pi + thShoulder)] .* (dthHand + dthShoulder);
    vToe = vWaist + rLeg * [-sin(thHand+1/2*pi + thShoulder + thWaist), cos(thHand+1/2*pi + thShoulder + thWaist)] .* (dthHand + dthShoulder + dthWaist);
    
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
PthShoulder = MthShoulder .* dthShoulder;
PthWaist = MthWaist .* dthWaist;

pG = find_pG(constants, pHand, thHand, thShoulder, thWaist);
vG = find_vG(constants, vHand, thHand, thShoulder, thWaist, dthHand, dthShoulder, dthWaist);
momentumG = find_momentumG(constants, pHand, vHand, thHand, thShoulder, thWaist, dthHand, dthShoulder, dthWaist);
KE = [KE; zeros([size(momentumG,1)-size(KE,1),1])];
dKE = [dKE; zeros([size(momentumG,1)-size(dKE,1),1])];

Anime_main















































