
constants = constants_HH;

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

frame_step = 4;
frame_start = 1;

A = readmatrix("video_reader_output_06090700.txt");
% A = readmatrix("video_reader_output_04292106.txt"); %屈身ダブル時
% A = readmatrix("video_reader_output_04291004.txt"); %伸身シングル時
data_read_index = frame_start:frame_step:size(A,1);
A = A(data_read_index,:);

time_fromData = A(:,1);
time = time_fromData(1,1):1e-3:time_fromData(end,1);
time = time';

[xHand, vxHand] = GetSmoothingDerivates(time_fromData, A(:,2), time);
[yHand, vyHand] = GetSmoothingDerivates(time_fromData, -A(:,3), time);
pHand = [xHand, yHand];
vHand = [vxHand, vyHand];

[xShoulder, vxShoulder] = GetSmoothingDerivates(time_fromData, A(:,4), time);
[yShoulder, vyShoulder] = GetSmoothingDerivates(time_fromData, -A(:,5), time);
pShoulder = [xShoulder, yShoulder];
vShoulder = [vxShoulder, vyShoulder];


[xWaist, vxWaist] = GetSmoothingDerivates(time_fromData, A(:,6), time);
[yWaist, vyWaist] = GetSmoothingDerivates(time_fromData, -A(:,7), time);
pWaist = [xWaist, yWaist];
vWaist = [vxWaist, vyWaist];

[xToe, vxToe] = GetSmoothingDerivates(time_fromData, A(:,8), time);
[yToe, vyToe] = GetSmoothingDerivates(time_fromData, -A(:,9), time);
pToe = [xToe, yToe];
vToe = [vxToe, vyToe];

ratio = rBody / ((xWaist(1,1) - xShoulder(1,1))^2 + (yWaist(1,1) - yShoulder(1,1))^2)^0.5;

pHand = pHand * ratio;
pShoulder = pShoulder * ratio;
pWaist = pWaist * ratio;
pToe = pToe * ratio;

vHand = vHand * ratio;
vShoulder = vShoulder * ratio;
vWaist = vWaist * ratio;
vToe = vToe * ratio;

pO = pHand(1,:) + [0, (mAll+mPB)*g/kPB];

pHand = pHand - pO;
pShoulder = pShoulder - pO;
pWaist = pWaist - pO;
pToe = pToe - pO;

rPB = pHand(:,2);
thHand = GetThetaFromXY(pHand, pShoulder) - 1/2*pi;
thShoulder = GetThetaFromXY(pShoulder, pWaist) - thHand - 1/2*pi;
thWaist = GetThetaFromXY(pWaist, pToe) - thHand - 1/2*pi - thShoulder;

[rPB_pp, drPB_pp, ddrPB_pp] = GetSmoothingDerivates_pp(time, rPB);
[thHand_pp, dthHand_pp, ddthHand_pp] = GetSmoothingDerivates_pp(time, thHand);
[thShoulder_pp, dthShoulder_pp, ddthShoulder_pp] = GetSmoothingDerivates_pp(time, thShoulder);
[thWaist_pp, dthWaist_pp, ddthWaist_pp] = GetSmoothingDerivates_pp(time, thWaist);

rPB = fnval(rPB_pp, time);
drPB = fnval(drPB_pp, time);
ddrPB = fnval(ddrPB_pp, time);

thHand = fnval(thHand_pp, time);
dthHand = fnval(dthHand_pp, time);
ddthHand = fnval(ddthHand_pp, time);

thShoulder = fnval(thShoulder_pp, time);
dthShoulder = fnval(dthShoulder_pp, time);
ddthShoulder = fnval(ddthShoulder_pp, time);

thWaist = fnval(thWaist_pp, time);
dthWaist = fnval(dthWaist_pp, time);
ddthWaist = fnval(ddthWaist_pp, time);

% % thHand = zeros(size(time));
% thHand = atan2(pShoulder(:,2)-pHand(:,2), pShoulder(:,1)-pHand(:,1));
% thHand = [thHand(1:184,1); thHand(185:213,1)+2*pi; thHand(214:end,1)+4*pi] - 1/2*pi;

% % thShoulder = zeros(size(time));
% thShoulder = atan2(pWaist(:,2)-pShoulder(:,2), pWaist(:,1)-pShoulder(:,1));
% thShoulder = [thShoulder(1:151,1); thShoulder(152:202,1)+2*pi; thShoulder(203:248,1)+4*pi; thShoulder(249:254,1)+6*pi;...
%     thShoulder(255:257,1) + 4*pi; thShoulder(258,1) + 6*pi; thShoulder(259:263,1) + 4*pi; thShoulder(264:end,1) + 6*pi] - 1/2*pi;

% thWaist = atan2(pToe(:,2)-pWaist(:,2), pToe(:,1)-pWaist(:,1));
% thWaist = [thWaist(1:157,1); thWaist(158:191,1)+2*pi; thWaist(192:222,1)+4*pi; thWaist(223:end,1)+6*pi] - 1/2*pi;

% drPB = ppval(fnder(spline(time, rPB)), time);
% dthHand = ppval(fnder(spline(time, thHand)), time);
% dthShoulder = ppval(fnder(spline(time, thShoulder)), time);
% dthWaist = ppval(fnder(spline(time, thWaist)), time);
% 
% ddrPB = ppval(fnder(spline(time, drPB)), time);
% ddthHand = ppval(fnder(spline(time, dthHand)), time);
% ddthShoulder = ppval(fnder(spline(time, dthShoulder)), time);
% ddthWaist = ppval(fnder(spline(time, dthWaist)), time);

% pHand = [zeros(size(rPB)), rPB];
% pShoulder = pHand + rArm * [cos(thHand+1/2*pi), sin(thHand+1/2*pi)];
% pWaist = pShoulder + rBody * [cos(thHand+1/2*pi + thShoulder), sin(thHand+1/2*pi + thShoulder)];
% pToe = pWaist + rLeg * [cos(thHand+1/2*pi + thShoulder + thWaist), sin(thHand+1/2*pi + thShoulder + thWaist)];

% pHand = [zeros(size(rPB)), rPB];
% pShoulder = pHand + rArm * [cos(thHand+1/2*pi), sin(thHand+1/2*pi)];
% pWaist = pShoulder + rBody * [cos(thHand+1/2*pi + thShoulder), sin(thHand+1/2*pi + thShoulder)];
% pToe = pWaist + rLeg * [cos(thHand+1/2*pi + thShoulder + thWaist), sin(thHand+1/2*pi + thShoulder + thWaist)];

%単純にプロットする
%{
MrPB = find_MrPB(ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,kPB,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,rPB,thHand,thShoulder,thWaist);
MthHand = find_MthHand(InertiaLeg,InertiaArm,InertiaBody,ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
MthShoulder = find_MthShoulder(InertiaLeg,InertiaBody,ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,mBody,mLeg,rArm,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
MthWaist = find_MthWaist(InertiaLeg,ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthShoulder,g,mLeg,rArm,rBody,rLegMCD,thHand,thShoulder,thWaist);

MrPB = MrPB .* (abs(MthHand) < 5e2);
MthHand = MthHand .* (abs(MthHand) < 5e2);
MthShoulder = MthShoulder .* (abs(MthShoulder) < 5e2);
MthWaist = MthWaist .* (abs(MthWaist) < 5e2);

PrPB = zeros(size(MrPB));
PthHand = zeros(size(MrPB));
PthShoulder = zeros(size(MrPB));
PthWaist = zeros(size(MrPB));

pG = 1/(mArm + mBody + mLeg) * (mArm * (pHand + pShoulder)/2 + mBody * (pShoulder + pWaist)/2 + mLeg * (pWaist + pToe)/2);
vG = 1/(mArm + mBody + mLeg) * (mArm * (vHand + vShoulder)/2 + mBody * (vShoulder + vWaist)/2 + mLeg * (vWaist + vToe)/2);

centerMomentum = mArm * cross([1/2 * (pHand + pShoulder) - pG, zeros(size(pG(:,1)))], [1/2 * (vHand + vShoulder) - vG, zeros(size(pG(:,1)))],2)...
    + mBody * cross([1/2 * (pShoulder + pWaist) - pG, zeros(size(pG(:,1)))], [1/2 * (vShoulder + vWaist) - vG, zeros(size(pG(:,1)))],2)...
    + mLeg * cross([1/2 * (pWaist + pToe) - pG, zeros(size(pG(:,1)))], [1/2 * (vWaist + vToe) - vG, zeros(size(pG(:,1)))],2);

sumJointsMomentum = 1/12 * mArm * rArm^2 * dthHand...
    + 1/12 * mBody * rBody^2 * (dthHand + dthShoulder)...
    + 1/12 * mLeg * rLeg^2 * (dthHand + dthShoulder + dthWaist);

momentumG = centerMomentum(:,3) + sumJointsMomentum;


KE = zeros(size(momentumG));
dKE = zeros(size(momentumG));


Anime_main

figure(1)
plot(time, [sum((pShoulder - pHand).^2, 2), sum((pShoulder - pWaist).^2, 2)])
legend({'腕の長さ', '胴体の長さ'})
%}

%Mdataから計算する
%{/

t = 0:1e-3:10;
t_ppval = t(1):(t(2)-t(1))/10:t(end);
q0 = [-(mAll + mPB)*g/kPB, thHand(1,1), thShoulder(1,1), thWaist(1,1), 0, dthHand(1,1), dthShoulder(1,1), dthWaist(1,1)]';
% q0 = [rPB(1,1), thHand(1,1), thShoulder(1,1), thWaist(1,1), drPB(1,1), dthHand(1,1), dthShoulder(1,1), dthWaist(1,1)]';
% q0 = [rPB(1,1), thHand(1,1), thShoulder(1,1), thWaist(1,1), drPB(1,1), dthHand(1,1), dthShoulder(1,1), dthWaist(1,1)]';

% figure(1)
% plot(t, ppval(rPB_pp, t))


ddpp_time_histories = [ddthHand_pp, ddthShoulder_pp, ddthWaist_pp]';

ode = @(t, q) ddt_Realization(t, q, constants, ddpp_time_histories);
% eventFcn = @(t,q)Events(t,q,constants, ddpp_time_histories);
eventFcn = @(t,q)Events_NoneJointLimit(t,q,constants);

% odeOption = odeset('AbsTol', 1e-5);
odeOption = odeset('Events', eventFcn, 'AbsTol', 1e-5);

[time_onbar, q, te, ye, ie] = ode45(ode, t, q0, odeOption);

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
    time_until_landing = vG(end,2)/g + (2*height/g)^0.5; %vG(end,2)がマイナスだった場合でも大丈夫
    omegaG = momentumG(end)/InertiaG;
    spinNum = time_until_landing * omegaG /(2*pi)
    
    t_freefall = 0:1e-3:10;
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
momentumG = find_momentumG(InertiaLeg,InertiaArm,InertiaBody,dthHand,dthWaist,dthShoulder,dxHand,dyHand,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist,xHand,yHand);
KE = [KE; zeros([size(momentumG,1)-size(KE,1),1])];
dKE = [dKE; zeros([size(momentumG,1)-size(dKE,1),1])];

hold on
plot(time, rPB)
hold off
title("離手時までの平行棒の自然長からの変位")
xlabel("time [s]")
ylabel("自然長からの変位 [m]")
legend("生データ","シミュレーション")
xlim([0 time_onbar(end)])

Anime_main
breakNum


%}














































