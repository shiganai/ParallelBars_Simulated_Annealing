clear all
tic
syms xHandpre(t) yHandpre(t)
syms thHandpre(t) thShoulderpre(t) thXippre(t) thWaistpre(t)
syms rArm rUBody rLBody rLeg real
syms mPB mArm mUBody mLBody mLeg real
syms FrPB TauHand TauShoulder TauXip TauWaist real
syms g real
syms rArmMCD rUBodyMCD rLBodyMCD rLegMCD real
syms InertiaArm InertiaUBody InertiaLBody InertiaLeg real

pHand = [xHandpre, yHandpre];
pShoulder = pHand + rArm * [cos(thHandpre+1/2*pi), sin(thHandpre+1/2*pi)];
pXip = pShoulder + rUBody * [cos(thHandpre+1/2*pi + thShoulderpre), sin(thHandpre+1/2*pi + thShoulderpre)];
pWaist = pXip + rLBody * [cos(thHandpre+1/2*pi + thShoulderpre + thXippre), sin(thHandpre+1/2*pi + thShoulderpre + thXippre)];
pToe = pWaist + rLeg * [cos(thHandpre+1/2*pi + thShoulderpre + thXippre + thWaistpre), sin(thHandpre+1/2*pi + thShoulderpre + thXippre + thWaistpre)];

pArmMCD = pHand + rArmMCD * [cos(thHandpre+1/2*pi), sin(thHandpre+1/2*pi)];
pUBodyMCD = pShoulder + rUBodyMCD * [cos(thHandpre+1/2*pi + thShoulderpre), sin(thHandpre+1/2*pi + thShoulderpre)];
pLBodyMCD = pXip + rLBodyMCD * [cos(thHandpre+1/2*pi + thShoulderpre + thXippre), sin(thHandpre+1/2*pi + thShoulderpre + thXippre)];
pLegMCD = pWaist + rLegMCD * [cos(thHandpre+1/2*pi + thShoulderpre + thWaistpre), sin(thHandpre+1/2*pi + thShoulderpre + thWaistpre)];

pG = 1/(mArm + mUBody + mLBody + mLeg) * (mArm * pArmMCD + mUBody * pUBodyMCD + mLBody * pLBodyMCD + mLeg * pLegMCD);

vHand = diff(pHand, t);
vShoulder = diff(pShoulder, t);
vXip = diff(pXip, t);
vWaist = diff(pWaist, t);
vToe = diff(pToe, t);

vArmMCD = diff(pArmMCD, t);
vUBodyMCD = diff(pUBodyMCD, t);
vLBodyMCD = diff(pLBodyMCD, t);
vLegMCD = diff(pLegMCD, t);

vG = diff(pG, t);

centerMomentum = mArm * cross([pArmMCD - pG, 0], [vArmMCD - vG, 0])...
    + mUBody * cross([pUBodyMCD - pG, 0], [vUBodyMCD - vG, 0])...
    + mLBody * cross([pLBodyMCD - pG, 0], [vLBodyMCD - vG, 0])...
    + mLeg * cross([pLegMCD - pG, 0], [vLegMCD - vG, 0]);

centerMomentumf = formula(centerMomentum);

momentumG = centerMomentumf(3)...
    + InertiaArm * diff(thHandpre+1/2*pi, t)...
    + InertiaUBody * diff(thHandpre+1/2*pi + thShoulderpre, t)...
    + InertiaLBody * diff(thHandpre+1/2*pi + thShoulderpre + thXippre, t)...
    + InertiaLeg * diff(thHandpre+1/2*pi + thShoulderpre + thXippre + thWaistpre, t);

InertiaG = mArm * ((pArmMCD - pG) * (pArmMCD - pG)')...
    + mUBody * ((pUBodyMCD - pG) * (pUBodyMCD - pG)')...
    + mLBody * ((pLBodyMCD - pG) * (pLBodyMCD - pG)')...
    + mLeg * ((pLegMCD - pG) * (pLegMCD - pG)')...
    + InertiaArm ...
    + InertiaUBody ...
    + InertiaLBody ...
    + InertiaLeg;

dmomentumG = diff(momentumG, t);

pHandf = formula(pHand);
pArmMCDf = formula(pArmMCD);
pUBodyMCDf = formula(pUBodyMCD);
pLBodyMCDf = formula(pLBodyMCD);
pLegMCDf = formula(pLegMCD);

syms xHand dxHand ddxHand real
syms yHand dyHand ddyHand real
syms thHand dthHand ddthHand real
syms thShoulder dthShoulder ddthShoulder real
syms thXip dthXip ddthXip real
syms thWaist dthWaist ddthWaist real

xHandreplaced = [xHandpre, diff(xHandpre, t), diff(xHandpre, t, t)];
xHandreplacing = [xHand, dxHand, ddxHand];

yHandreplaced = [yHandpre, diff(yHandpre, t), diff(yHandpre, t, t)];
yHandreplacing = [yHand, dyHand, ddyHand];

thHandreplaced = [thHandpre, diff(thHandpre, t), diff(thHandpre, t, t)];
thHandreplacing = [thHand, dthHand, ddthHand];

thShoulderreplaced = [thShoulderpre, diff(thShoulderpre, t), diff(thShoulderpre, t, t)];
thShoulderreplacing = [thShoulder, dthShoulder, ddthShoulder];

thXipreplaced = [thXippre, diff(thXippre, t), diff(thXippre, t, t)];
thXipreplacing = [thXip, dthXip, ddthXip];

thWaistreplaced = [thWaistpre, diff(thWaistpre, t), diff(thWaistpre, t, t)];
thWaistreplacing = [thWaist, dthWaist, ddthWaist];

SymReplaced = [xHandreplaced, yHandreplaced, thHandreplaced, thShoulderreplaced, thXipreplaced, thWaistreplaced];
SymReplacing = [xHandreplacing, yHandreplacing, thHandreplacing, thShoulderreplacing, thXipreplacing, thWaistreplacing];


parallel.defaultClusterProfile('local');
c = parcluster();

%inertiaG
%{
InertiaG = subs(InertiaG, SymReplaced, SymReplacing);

job_tmp = createJob(c);
createTask(job_tmp, @matlabFunction, 1,{InertiaG, 'file', 'find_InertiaG.m', 'outputs', {'InertiaG'}});
submit(job_tmp)
job_tmp.Tasks
%}

%momentumG
%{
momentumG = subs(momentumG, SymReplaced, SymReplacing);

job_tmp = createJob(c);
createTask(job_tmp, @matlabFunction, 1,{momentumG, 'file', 'find_momentumG.m', 'outputs', {'momentumG'}});
submit(job_tmp)
job_tmp.Tasks
%}

%dmomentumG
%{/
dmomentumG = subs(dmomentumG, SymReplaced, SymReplacing);

job_tmp = createJob(c);
createTask(job_tmp, @matlabFunction, 1,{dmomentumG, 'file', 'find_dmomentumG.m', 'outputs', {'dmomentumG'}});
submit(job_tmp)
job_tmp.Tasks
%}

%pG
%{
pG = subs(pG, SymReplaced, SymReplacing);

job_tmp = createJob(c);
createTask(job_tmp, @matlabFunction, 1,{pG, 'file', 'find_pG.m', 'outputs', {'pG'}});
submit(job_tmp)
job_tmp.Tasks
%}

%vG
%{
vG = subs(vG, SymReplaced, SymReplacing);

job_tmp = createJob(c);
createTask(job_tmp, @matlabFunction, 1,{vG, 'file', 'find_vG.m', 'outputs', {'vG'}});
submit(job_tmp)
job_tmp.Tasks
%}

%KE dKE
%{

T = 1/2 * mPB * (vHand * vHand') ...
    + 1/2 * mArm * (vArmMCD * vArmMCD') ...
    + 1/2 * mUBody * (vUBodyMCD * vUBodyMCD') ...
    + 1/2 * mLBody * (vLBodyMCD * vLBodyMCD') ...
    + 1/2 * mLeg * (vLegMCD * vLegMCD') ...
    + 1/2 * InertiaArm * diff(thHandpre+1/2*pi, t)^2 ...
    + 1/2 * InertiaUBody * diff(thHandpre+1/2*pi + thShoulderpre, t)^2 ...
    + 1/2 * InertiaLBody * diff(thHandpre+1/2*pi + thShoulderpre + thXippre, t)^2 ...
    + 1/2 * InertiaLeg * diff(thHandpre+1/2*pi + thShoulderpre + thXippre + thWaistpre, t)^2;

U = mPB * g * pHandf(2) ...
    + mArm * g * pArmMCDf(2) ...
    + mUBody * g * pUBodyMCDf(2) ...
    + mLBody * g * pLBodyMCDf(2) ...
    + mLeg * g * pLegMCDf(2);

KE = T + U;
dKE = diff(KE, t);

KE = subs(KE, SymReplaced, SymReplacing);

job_tmp = createJob(c);
createTask(job_tmp, @matlabFunction, 1,{KE, 'file', 'find_KE.m', 'outputs', {'KE'}});
submit(job_tmp)
job_tmp.Tasks

dKE = subs(dKE, SymReplaced, SymReplacing);

job_tmp = createJob(c);
createTask(job_tmp, @matlabFunction, 1,{dKE, 'file', 'find_dKE.m', 'outputs', {'dKE'}});
submit(job_tmp)
job_tmp.Tasks
%}


































