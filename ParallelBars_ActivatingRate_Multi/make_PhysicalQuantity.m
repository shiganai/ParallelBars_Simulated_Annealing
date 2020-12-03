clear all
tic
syms xHandpre(t) yHandpre(t)
syms thHandpre(t) thShoulderpre(t) thWaistpre(t)
syms rArm rBody rLeg real
syms mPB mArm mBody mLeg real
syms MthHand MthShoulder MthWaist real
syms g real
syms rArmMCD rBodyMCD rLegMCD real
syms InertiaArm InertiaBody InertiaLeg real

pHand = [xHandpre, yHandpre];
pShoulder = pHand + rArm * [cos(thHandpre+1/2*pi), sin(thHandpre+1/2*pi)];
pWaist = pShoulder + rBody * [cos(thHandpre+1/2*pi + thShoulderpre), sin(thHandpre+1/2*pi + thShoulderpre)];
pToe = pWaist + rLeg * [cos(thHandpre+1/2*pi + thShoulderpre + thWaistpre), sin(thHandpre+1/2*pi + thShoulderpre + thWaistpre)];

pArmMCD = pHand + rArmMCD * [cos(thHandpre+1/2*pi), sin(thHandpre+1/2*pi)];
pBodyMCD = pShoulder + rBodyMCD * [cos(thHandpre+1/2*pi + thShoulderpre), sin(thHandpre+1/2*pi + thShoulderpre)];
pLegMCD = pWaist + rLegMCD * [cos(thHandpre+1/2*pi + thShoulderpre + thWaistpre), sin(thHandpre+1/2*pi + thShoulderpre + thWaistpre)];

pG = 1/(mArm + mBody + mLeg) * (mArm * pArmMCD + mBody * pBodyMCD + mLeg * pLegMCD);

vHand = diff(pHand, t);
vShoulder = diff(pShoulder, t);
vWaist = diff(pWaist, t);
vToe = diff(pToe, t);

vArmMCD = diff(pArmMCD, t);
vBodyMCD = diff(pBodyMCD, t);
vLegMCD = diff(pLegMCD, t);

vG = diff(pG, t);

P = (mArm + mBody + mLeg) * vG;
dP = diff(P, t);

centerMomentum = mArm * cross([pArmMCD - pG, 0], [vArmMCD - vG, 0])...
    + mBody * cross([pBodyMCD - pG, 0], [vBodyMCD - vG, 0])...
    + mLeg * cross([pLegMCD - pG, 0], [vLegMCD - vG, 0]);

centerMomentumf = formula(centerMomentum);

momentumG = centerMomentumf(3)...
    + InertiaArm * diff(thHandpre-1/2*pi, t)...
    + InertiaBody * diff(thHandpre-1/2*pi + thShoulderpre-pi, t)...
    + InertiaLeg * diff(thHandpre-1/2*pi + thShoulderpre-pi + thWaistpre-pi, t);

InertiaG = mArm * realSymDot(pArmMCD - pG, pArmMCD - pG)...
    + mBody * realSymDot(pBodyMCD - pG, pBodyMCD - pG)...
    + mLeg * realSymDot(pLegMCD - pG, pLegMCD - pG)...
    + InertiaArm ...
    + InertiaBody ...
    + InertiaLeg;

pHandf = formula(pHand);
pArmMCDf = formula(pArmMCD);
pBodyMCDf = formula(pBodyMCD);
pLegMCDf = formula(pLegMCD);

syms xHand dxHand ddxHand real
syms yHand dyHand ddyHand real
syms thHand dthHand ddthHand real
syms thShoulder dthShoulder ddthShoulder real
syms thWaist dthWaist ddthWaist real

xHandreplaced = [xHandpre, diff(xHandpre, t), diff(xHandpre, t, t)];
xHandreplacing = [xHand, dxHand, ddxHand];

yHandreplaced = [yHandpre, diff(yHandpre, t), diff(yHandpre, t, t)];
yHandreplacing = [yHand, dyHand, ddyHand];

thHandreplaced = [thHandpre, diff(thHandpre, t), diff(thHandpre, t, t)];
thHandreplacing = [thHand, dthHand, ddthHand];

thShoulderreplaced = [thShoulderpre, diff(thShoulderpre, t), diff(thShoulderpre, t, t)];
thShoulderreplacing = [thShoulder, dthShoulder, ddthShoulder];

thWaistreplaced = [thWaistpre, diff(thWaistpre, t), diff(thWaistpre, t, t)];
thWaistreplacing = [thWaist, dthWaist, ddthWaist];

SymReplaced = [xHandreplaced, yHandreplaced, thHandreplaced, thShoulderreplaced, thWaistreplaced];
SymReplacing = [xHandreplacing, yHandreplacing, thHandreplacing, thShoulderreplacing, thWaistreplacing];


parallel.defaultClusterProfile('local');
c = parcluster();

%inertiaG
%{
InertiaG = formula(subs(InertiaG, SymReplaced, SymReplacing));

job1 = createJob(c);
createTask(job1, @matlabFunction, 1,{InertiaG, 'file', 'find_InertiaG.m', 'outputs', {'InertiaG'}});
submit(job1)
job1.Tasks
%}

%momentumG
%{
momentumG = formula(subs(momentumG, SymReplaced, SymReplacing));

job2 = createJob(c);
createTask(job2, @matlabFunction, 1,{momentumG, 'file', 'find_momentumG.m', 'outputs', {'momentumG'}});
submit(job2)
job2.Tasks
%}

%dP
%{/
dP = formula(subs(dP, SymReplaced, SymReplacing));

job_tmp = createJob(c);
createTask(job_tmp, @matlabFunction, 1,{dP, 'file', 'find_dP.m', 'outputs', {'dP'}});
submit(job_tmp)
job_tmp.Tasks
%}

%pG
%{
pG = formula(subs(pG, SymReplaced, SymReplacing));

job3 = createJob(c);
createTask(job3, @matlabFunction, 1,{pG, 'file', 'find_pG.m', 'outputs', {'pG'}});
submit(job3)
job3.Tasks
%}

%vG
%{
vG = formula(subs(vG, SymReplaced, SymReplacing));

job4 = createJob(c);
createTask(job4, @matlabFunction, 1,{vG, 'file', 'find_vG.m', 'outputs', {'vG'}});
submit(job4)
job4.Tasks
%}

%KE dKE
%{

T = 1/2 * mPB * realSymDot(vHand, vHand) ...
    + 1/2 * mArm * realSymDot(vArmMCD, vArmMCD) ...
    + 1/2 * mBody * realSymDot(vBodyMCD, vBodyMCD) ...
    + 1/2 * mLeg * realSymDot(vLegMCD, vLegMCD) ...
    + 1/2 * InertiaArm * diff(thHandpre-1/2*pi, t)^2 ...
    + 1/2 * InertiaBody * diff(thHandpre-1/2*pi + thShoulderpre-pi, t)^2 ...
    + 1/2 * InertiaLeg * diff(thHandpre-1/2*pi + thShoulderpre-pi + thWaistpre-pi, t)^2;

U = 1/2 * kPB * yHandpre^2 + mPB * g * pHandf(2) ...
    + mArm * g * pArmMCDf(2) ...
    + mBody * g * pBodyMCDf(2) ...
    + mLeg * g * pLegMCDf(2);

KE = T + U;
dKE = diff(KE, t);

KE = formula(subs(KE, SymReplaced, SymReplacing));

job5 = createJob(c);
createTask(job5, @matlabFunction, 1,{KE, 'file', 'find_KE.m', 'outputs', {'KE'}});
submit(job5)
job5.Tasks

dKE = formula(subs(dKE, SymReplaced, SymReplacing));

job5 = createJob(c);
createTask(job5, @matlabFunction, 1,{dKE, 'file', 'find_dKE.m', 'outputs', {'dKE'}});
submit(job5)
job5.Tasks
%}


































