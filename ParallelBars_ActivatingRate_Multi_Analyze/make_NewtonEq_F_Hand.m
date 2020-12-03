clear all
tic
syms rPBpre(t) thHandpre(t) thShoulderpre(t) thWaistpre(t)
syms rArm rBody rLeg real
syms mPB mArm mBody mLeg real
syms MrPB MthHand MthShoulder MthWaist real
syms g real
syms rArmMCD rBodyMCD rLegMCD real
syms InertiaArm InertiaBody InertiaLeg real
syms xHandpre(t) yHandpre(t)

pPB = [0, rPBpre];
pHand = [xHandpre, yHandpre];
pShoulder = pHand + rArm * [cos(thHandpre+1/2*pi), sin(thHandpre+1/2*pi)];
pWaist = pShoulder + rBody * [cos(thHandpre+1/2*pi + thShoulderpre), sin(thHandpre+1/2*pi + thShoulderpre)];
pToe = pWaist + rLeg * [cos(thHandpre+1/2*pi + thShoulderpre + thWaistpre), sin(thHandpre+1/2*pi + thShoulderpre + thWaistpre)];

pArmMCD = pHand + rArmMCD * [cos(thHandpre+1/2*pi), sin(thHandpre+1/2*pi)];
pBodyMCD = pShoulder + rBodyMCD * [cos(thHandpre+1/2*pi + thShoulderpre), sin(thHandpre+1/2*pi + thShoulderpre)];
pLegMCD = pWaist + rLegMCD * [cos(thHandpre+1/2*pi + thShoulderpre + thWaistpre), sin(thHandpre+1/2*pi + thShoulderpre + thWaistpre)];

vPB = diff(pPB, t);
vHand = diff(pHand, t);
vShoulder = diff(pShoulder, t);
vWaist = diff(pWaist, t);
vToe = diff(pToe, t);

vArmMCD = diff(pArmMCD, t);
vBodyMCD = diff(pBodyMCD, t);
vLegMCD = diff(pLegMCD, t);

pPBf = formula(pPB);
pHandf = formula(pHand);
pArmMCDf = formula(pArmMCD);
pBodyMCDf = formula(pBodyMCD);
pLegMCDf = formula(pLegMCD);

T = 1/2 * mPB * (vPB * vPB') ...
    + 1/2 * mArm * (vArmMCD * vArmMCD') ...
    + 1/2 * mBody * (vBodyMCD * vBodyMCD') ...
    + 1/2 * mLeg * (vLegMCD * vLegMCD') ...
    + 1/2 * InertiaArm * diff(thHandpre-1/2*pi, t)^2 ...
    + 1/2 * InertiaBody * diff(thHandpre-1/2*pi + thShoulderpre-pi, t)^2 ...
    + 1/2 * InertiaLeg * diff(thHandpre-1/2*pi + thShoulderpre-pi + thWaistpre-pi, t)^2;

U = mPB * g * pPBf(2) ...
    + mArm * g * pArmMCDf(2) ...
    + mBody * g * pBodyMCDf(2) ...
    + mLeg * g * pLegMCDf(2);

L = T - U;

Fx_Hand = -functionalDerivative(L, xHandpre);
Fy_Hand = -functionalDerivative(L, yHandpre);

L = subs(L, [xHandpre, yHandpre], [pPBf(1,1), pPBf(1,2)]);
Fx_Hand = subs(Fx_Hand, [xHandpre, yHandpre], [pPBf(1,1), pPBf(1,2)]);
Fy_Hand = subs(Fy_Hand, [xHandpre, yHandpre], [pPBf(1,1), pPBf(1,2)]);

rHBEq = -functionalDerivative(L, rPBpre) == MrPB;
thHandEq = -functionalDerivative(L, thHandpre) == MthHand;
thShoulderEq = -functionalDerivative(L, thShoulderpre) == MthShoulder;
thWaistEq = -functionalDerivative(L, thWaistpre) == MthWaist;

syms rPB drPB ddrPB real
syms thHand dthHand ddthHand real
syms thShoulder dthShoulder ddthShoulder real
syms thWaist dthWaist ddthWaist real

rPBreplaced = [rPBpre, diff(rPBpre, t), diff(rPBpre, t, t)];
rPBreplacing = [rPB, drPB, ddrPB];

thHandreplaced = [thHandpre, diff(thHandpre, t), diff(thHandpre, t, t)];
thHandreplacing = [thHand, dthHand, ddthHand];

thShoulderreplaced = [thShoulderpre, diff(thShoulderpre, t), diff(thShoulderpre, t, t)];
thShoulderreplacing = [thShoulder, dthShoulder, ddthShoulder];

thWaistreplaced = [thWaistpre, diff(thWaistpre, t), diff(thWaistpre, t, t)];
thWaistreplacing = [thWaist, dthWaist, ddthWaist];

SymReplaced = [rPBreplaced, thHandreplaced, thShoulderreplaced, thWaistreplaced];
SymReplacing = [rPBreplacing, thHandreplacing, thShoulderreplacing, thWaistreplacing];

Equations = [rHBEq; thHandEq; thShoulderEq; thWaistEq];
Equations = subs(Equations, SymReplaced, SymReplacing);

Fx_Hand = subs(Fx_Hand, SymReplaced, SymReplacing);
Fy_Hand = subs(Fy_Hand, SymReplaced, SymReplacing);

parallel.defaultClusterProfile('local');
c = parcluster();

%Fx_Hand, Fy_Hand
%{
%{
Fx_Hand = formula(Fx_Hand);
Fy_Hand = formula(Fy_Hand);

job11 = createJob(c);
createTask(job11, @matlabFunction, 1,{Fx_Hand, 'file', 'find_Fx_Hand.m', 'outputs', {'Fx_Hand'}});
submit(job11)
job11.Tasks

job12 = createJob(c);
createTask(job12, @matlabFunction, 1,{Fy_Hand, 'file', 'find_Fy_Hand.m', 'outputs', {'Fy_Hand'}});
submit(job12)
job12.Tasks
%}
%}
toc




































