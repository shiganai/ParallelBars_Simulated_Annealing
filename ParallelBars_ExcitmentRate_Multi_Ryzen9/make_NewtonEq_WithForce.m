clear all
tic
syms rPBpre(t) thHandpre(t) thShoulderpre(t) thWaistpre(t)
syms xPBpre(t) yPBpre(t)
syms rArm rBody rLeg real
syms mPB mArm mBody mLeg real
syms MrPB MthHand MthShoulder MthWaist real
syms g real
syms rArmMCD rBodyMCD rLegMCD real
syms InertiaArm InertiaBody InertiaLeg real

pHand = [xPBpre, yPBpre];
pShoulder = pHand + rArm * [cos(thHandpre+1/2*pi), sin(thHandpre+1/2*pi)];
pWaist = pShoulder + rBody * [cos(thHandpre+1/2*pi + thShoulderpre), sin(thHandpre+1/2*pi + thShoulderpre)];
pToe = pWaist + rLeg * [cos(thHandpre+1/2*pi + thShoulderpre + thWaistpre), sin(thHandpre+1/2*pi + thShoulderpre + thWaistpre)];

pArmMCD = pHand + rArmMCD * [cos(thHandpre+1/2*pi), sin(thHandpre+1/2*pi)];
pBodyMCD = pShoulder + rBodyMCD * [cos(thHandpre+1/2*pi + thShoulderpre), sin(thHandpre+1/2*pi + thShoulderpre)];
pLegMCD = pWaist + rLegMCD * [cos(thHandpre+1/2*pi + thShoulderpre + thWaistpre), sin(thHandpre+1/2*pi + thShoulderpre + thWaistpre)];

vHand = diff(pHand, t);
vShoulder = diff(pShoulder, t);
vWaist = diff(pWaist, t);
vToe = diff(pToe, t);

vArmMCD = diff(pArmMCD, t);
vBodyMCD = diff(pBodyMCD, t);
vLegMCD = diff(pLegMCD, t);

pHandf = formula(pHand);
pArmMCDf = formula(pArmMCD);
pBodyMCDf = formula(pBodyMCD);
pLegMCDf = formula(pLegMCD);

T = 1/2 * mPB * (vHand * vHand') ...
    + 1/2 * mArm * (vArmMCD * vArmMCD') ...
    + 1/2 * mBody * (vBodyMCD * vBodyMCD') ...
    + 1/2 * mLeg * (vLegMCD * vLegMCD') ...
    + 1/2 * InertiaArm * diff(thHandpre-1/2*pi, t)^2 ...
    + 1/2 * InertiaBody * diff(thHandpre-1/2*pi + thShoulderpre-pi, t)^2 ...
    + 1/2 * InertiaLeg * diff(thHandpre-1/2*pi + thShoulderpre-pi + thWaistpre-pi, t)^2;

U = mPB * g * pHandf(2) ...
    + mArm * g * pArmMCDf(2) ...
    + mBody * g * pBodyMCDf(2) ...
    + mLeg * g * pLegMCDf(2);

L = T - U;

rPBEq = -functionalDerivative(L, rPBpre) == MrPB;
thHandEq = -functionalDerivative(L, thHandpre) == MthHand;
thShoulderEq = -functionalDerivative(L, thShoulderpre) == MthShoulder;
thWaistEq = -functionalDerivative(L, thWaistpre) == MthWaist;

FxPB = -functionalDerivative(L, xPBpre);
FyPB = -functionalDerivative(L, yPBpre);

% Equations = [rPBEq; thHandEq; thShoulderEq; thWaistEq];
% Equations = subs(Equations, yPBpre, sym(0));

FxPB = subs(FxPB, [xPBpre, yPBpre], [sym(0), rPBpre]);
FyPB = subs(FyPB, [xPBpre, yPBpre], [sym(0), rPBpre]);

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

symreplaced = [rPBreplaced, thHandreplaced, thShoulderreplaced, thWaistreplaced];
symreplacing = [rPBreplacing, thHandreplacing, thShoulderreplacing, thWaistreplacing];

% Equations = subs(Equations, symreplaced, symreplacing);
FxPB = subs(FxPB, symreplaced, symreplacing);
FyPB = subs(FyPB, symreplaced, symreplacing);

parallel.defaultClusterProfile('local');
c = parcluster();

%FxPB, FyPB
%{
FxPB = formula(FxPB);
FyPB = formula(FyPB);

job11 = createJob(c);
createTask(job11, @matlabFunction, 1,{FxPB, 'file', 'find_FxPB2.m', 'outputs', {'FxPB'}});
submit(job11)
job11.Tasks

job12 = createJob(c);
createTask(job12, @matlabFunction, 1,{FyPB, 'file', 'find_FyPB2.m', 'outputs', {'FyPB'}});
submit(job12)
job12.Tasks
%}
toc




































