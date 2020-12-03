

clear all

tic
syms rPBpre(t) thHandpre(t) thShoulderpre(t) thXippre(t) thWaistpre(t)
syms rArm rUBody rLBody rLeg real
syms mPB mArm mUBody mLBody mLeg real
syms FrPB TauHand TauShoulder TauXip TauWaist real
syms g real
syms rArmMCD rUBodyMCD rLBodyMCD rLegMCD real
syms InertiaArm InertiaUBody InertiaLBody InertiaLeg real
syms xHandpre(t) yHandpre(t)

pPB = [0, rPBpre];
pHand = [xHandpre, yHandpre];
pShoulder = pHand + rArm * [cos(thHandpre+1/2*pi), sin(thHandpre+1/2*pi)];
pXip = pShoulder + rUBody * [cos(thHandpre+1/2*pi + thShoulderpre), sin(thHandpre+1/2*pi + thShoulderpre)];
pWaist = pXip + rLBody * [cos(thHandpre+1/2*pi + thShoulderpre + thXippre), sin(thHandpre+1/2*pi + thShoulderpre + thXippre)];
pToe = pWaist + rLeg * [cos(thHandpre+1/2*pi + thShoulderpre + thXippre + thWaistpre), sin(thHandpre+1/2*pi + thShoulderpre + thXippre + thWaistpre)];

pArmMCD = pHand + rArmMCD * [cos(thHandpre+1/2*pi), sin(thHandpre+1/2*pi)];
pUBodyMCD = pShoulder + rUBodyMCD * [cos(thHandpre+1/2*pi + thShoulderpre), sin(thHandpre+1/2*pi + thShoulderpre)];
pLBodyMCD = pXip + rLBodyMCD * [cos(thHandpre+1/2*pi + thShoulderpre + thXippre), sin(thHandpre+1/2*pi + thShoulderpre + thXippre)];
pLegMCD = pWaist + rLegMCD * [cos(thHandpre+1/2*pi + thShoulderpre + thWaistpre), sin(thHandpre+1/2*pi + thShoulderpre + thWaistpre)];

vPB = diff(pPB, t);
vHand = diff(pHand, t);
vShoulder = diff(pShoulder, t);
vXip = diff(pXip, t);
vWaist = diff(pWaist, t);
vToe = diff(pToe, t);

vArmMCD = diff(pArmMCD, t);
vUBodyMCD = diff(pUBodyMCD, t);
vLBodyMCD = diff(pLBodyMCD, t);
vLegMCD = diff(pLegMCD, t);

pPBf = formula(pPB);
pHandf = formula(pHand);
pArmMCDf = formula(pArmMCD);
pUBodyMCDf = formula(pUBodyMCD);
pLBodyMCDf = formula(pLBodyMCD);
pLegMCDf = formula(pLegMCD);

T = 1/2 * mPB * (vPB * vPB') ...
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

L = T - U;

Fx_Hand = -functionalDerivative(L, xHandpre);
Fy_Hand = -functionalDerivative(L, yHandpre);

L = subs(L, [xHandpre, yHandpre], [pPBf(1,1), pPBf(1,2)]);
Fx_Hand = subs(Fx_Hand, [xHandpre, yHandpre], [pPBf(1,1), pPBf(1,2)]);
Fy_Hand = subs(Fy_Hand, [xHandpre, yHandpre], [pPBf(1,1), pPBf(1,2)]);

rHBEq = -functionalDerivative(L, rPBpre) == FrPB;
thHandEq = -functionalDerivative(L, thHandpre) == TauHand;
thShoulderEq = -functionalDerivative(L, thShoulderpre) == TauShoulder;
thXipEq = -functionalDerivative(L, thXippre) == TauXip;
thWaistEq = -functionalDerivative(L, thWaistpre) == TauWaist;

syms rPB drPB ddrPB real
syms thHand dthHand ddthHand real
syms thShoulder dthShoulder ddthShoulder real
syms thXip dthXip ddthXip real
syms thWaist dthWaist ddthWaist real

rPBreplaced = [rPBpre, diff(rPBpre, t), diff(rPBpre, t, t)];
rPBreplacing = [rPB, drPB, ddrPB];

thHandreplaced = [thHandpre, diff(thHandpre, t), diff(thHandpre, t, t)];
thHandreplacing = [thHand, dthHand, ddthHand];

thShoulderreplaced = [thShoulderpre, diff(thShoulderpre, t), diff(thShoulderpre, t, t)];
thShoulderreplacing = [thShoulder, dthShoulder, ddthShoulder];

thXipreplaced = [thXippre, diff(thXippre, t), diff(thXippre, t, t)];
thXipreplacing = [thXip, dthXip, ddthXip];

thWaistreplaced = [thWaistpre, diff(thWaistpre, t), diff(thWaistpre, t, t)];
thWaistreplacing = [thWaist, dthWaist, ddthWaist];

SymReplaced = [rPBreplaced, thHandreplaced, thShoulderreplaced, thXipreplaced, thWaistreplaced];
SymReplacing = [rPBreplacing, thHandreplacing, thShoulderreplacing, thXipreplacing, thWaistreplacing];

Equations = [rHBEq; thHandEq; thShoulderEq; thXipEq; thWaistEq];
Equations = subs(Equations, SymReplaced, SymReplacing);

Fx_Hand = subs(Fx_Hand, SymReplaced, SymReplacing);
Fy_Hand = subs(Fy_Hand, SymReplaced, SymReplacing);

parallel.defaultClusterProfile('local');
c = parcluster();

%Fx_Hand, Fy_Hand
%{/
%{/
Fx_Hand = formula(Fx_Hand);
Fy_Hand = formula(Fy_Hand);

job = createJob(c);
createTask(job, @matlabFunction, 1,{Fx_Hand, 'file', 'find_Fx_Hand.m', 'outputs', {'Fx_Hand'}});
submit(job)
job.Tasks

job = createJob(c);
createTask(job, @matlabFunction, 1,{Fy_Hand, 'file', 'find_Fy_Hand.m', 'outputs', {'Fy_Hand'}});
submit(job)
job.Tasks
%}
%}
toc




































