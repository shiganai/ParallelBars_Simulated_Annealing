


constants = constants_Yeadon;

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

ActivatingRate_ii = [   -1.0000   -0.5000   -0.5000;
    0.5000    1.0000   -0.5000;
   -1.0000   -1.0000   -0.5000;
   -0.5000    0.5000         0;
    1.0000         0   -0.5000;
         0    0.5000   -1.0000;
         0   -1.0000   -0.5000;
   -0.5000   -0.5000         0;
   -0.5000   -1.0000   -0.5000;
    1.0000         0   -0.5000;
         0         0    0.5000;
   -1.0000         0    0.5000;
    0.5000    1.0000   -1.0000;
    1.0000   -0.5000    1.0000;
         0         0         0;
    ];

Data_Set_Time = (0:10e-2:1.4)';

rPB0 = -(mAll+mPB)*g/kPB;
thHand0 = 0;
thShoulder0 = 0;
thWaist0 = 0;

drPB0 = 0;
dthHand0 = 0;
dthShoulder0 = 0;
dthWaist0 = 0;

q0 = [rPB0, thHand0, thShoulder0, thWaist0, drPB0, dthHand0, dthShoulder0, dthWaist0]';

t = 0:1e-3:1.4;

% eventFcn = @(t,q)Events_NoneJointLimit(t,q,constants);
eventFcn = @(t,q)Events(t,q,Para.constants);

MthHand_ActivatingRate_ddt0_spline = GetActivatingRate_ddt0_pp(Data_Set_Time, ActivatingRate_ii(:,1));
MthShoulder_ActivatingRate_ddt0_spline = GetActivatingRate_ddt0_pp(Data_Set_Time, ActivatingRate_ii(:,2));
MthWaist_ActivatingRate_ddt0_spline = GetActivatingRate_ddt0_pp(Data_Set_Time, ActivatingRate_ii(:,3));

ActivatingRate_spline = [MthHand_ActivatingRate_ddt0_spline, MthShoulder_ActivatingRate_ddt0_spline, MthWaist_ActivatingRate_ddt0_spline]';

ode = @(t, q) ddt_Ddt0(t, q, constants, ActivatingRate_spline, ActivatingRate_ii, Data_Set_Time);

odeOption = odeset('Events', eventFcn, 'AbsTol', 1e-6);

[time_onbar, q, ~, ~, ie] = ode45(ode, t, q0, odeOption);

if ~isempty(ie)
    breakNum = ie(end);
else
    breakNum = 0;
end
ObjectiveValueData = ObjectiveFcn(time_onbar, q, constants, 1.2, breakNum);
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

pHand = [zeros(size(rPB(:,1))), rPB];
vHand = [zeros(size(rPB(:,1))), drPB];

if breakNum == 1
    
    pG = find_pG(mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist,xHand,yHand);
    vG = find_vG(dthHand,dthWaist,dthShoulder,dxHand,dyHand,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
    momentumG = find_momentumG(InertiaLeg,InertiaArm,InertiaBody,dthHand,dthWaist,dthShoulder,dxHand,dyHand,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist,xHand,yHand);
    
    height = pG(end,2) + vG(end,2)^2/(2*g) + 1.8 - rLeg;
    time_until_landing = vG(end,2)/g + (2*height/g)^0.5; %vG(end,2)���}�C�i�X�������ꍇ�ł����v
    omegaG = momentumG(end)/InertiaG;
    spinNum = time_until_landing * omegaG /(2*pi)
    
    t_freefall = 0:time_onbar(2,1) - time_onbar(1,1):10;
    q0_freefall = [0, q(end,1), q(end,2), q(end,3), q(end,4), 0, q(end,5), q(end,6), q(end,7), q(end,8)]';
    
    eventFcn_freefall = @(t,q)Events_freefall(t, q, constants);
    odeOption_freefall = odeset('Events', eventFcn_freefall ,'AbsTol', 1e-5);
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
    vHand = [dxHand, dyHand];
    
    rPB = [rPB(:,1); zeros(size(time_freefall(2:end,1))) + rPB(end,1)];
    drPB = [drPB(:,1); zeros(size(time_freefall(2:end,1))) + drPB(end,1)];
    
    ddrPB = [ddrPB(:,1); zeros(size(time_freefall(2:end,1)))];
    ddthHand = [ddthHand(:,1); zeros(size(time_freefall(2:end,1)))];
    ddthShoulder = [ddthShoulder(:,1); zeros(size(time_freefall(2:end,1)))];
    ddthWaist = [ddthWaist(:,1); zeros(size(time_freefall(2:end,1)))];
    
else
    warning("���莸�s")
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


pG = find_pG(mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist,xHand,yHand);
vG = find_vG(dthHand,dthWaist,dthShoulder,dxHand,dyHand,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
momentumG = find_momentumG(InertiaLeg,InertiaArm,InertiaBody,dthHand,dthWaist,dthShoulder,dxHand,dyHand,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist,xHand,yHand);
KE = [KE; zeros([size(momentumG,1)-size(KE,1),1])];
dKE = [dKE; zeros([size(momentumG,1)-size(dKE,1),1])];

%{/
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

figure(1)
plot(time, [MthHand_ActivatedRate, MthShoulder_ActivatedRate, MthWaist_ActivatedRate])
legend({'���̓�����', '���̓�����', '���̓�����'})

figure(2)
plot(time, [fnval(MthHand_ActivatingRate_ddt0_spline, time), fnval(MthShoulder_ActivatingRate_ddt0_spline, time), fnval(MthWaist_ActivatingRate_ddt0_spline, time)])
legend({'ddt0\_���̓�����', 'ddt0\_���̓�����', 'ddt0\_���̓�����'})

figure(3)
plot(time, [dthHand, dthShoulder, dthWaist])
legend({'���̊p���x', '���̊p���x', '���̊p���x'})

%}

Anime_main















































