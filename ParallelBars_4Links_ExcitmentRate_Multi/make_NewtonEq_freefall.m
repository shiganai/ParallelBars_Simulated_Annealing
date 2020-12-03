clear all

tic
syms xHandpre(t) yHandpre(t)
syms rPBpre(t) thHandpre(t) thShoulderpre(t) thXippre(t) thWaistpre(t)
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

vHand = diff(pHand, t);
vShoulder = diff(pShoulder, t);
vXip = diff(pXip, t);
vWaist = diff(pWaist, t);
vToe = diff(pToe, t);

vArmMCD = diff(pArmMCD, t);
vUBodyMCD = diff(pUBodyMCD, t);
vLBodyMCD = diff(pLBodyMCD, t);
vLegMCD = diff(pLegMCD, t);

pHandf = formula(pHand);
pArmMCDf = formula(pArmMCD);
pUBodyMCDf = formula(pUBodyMCD);
pLBodyMCDf = formula(pLBodyMCD);
pLegMCDf = formula(pLegMCD);

T = 1/2 * mArm * (vArmMCD * vArmMCD') ...
    + 1/2 * mUBody * (vUBodyMCD * vUBodyMCD') ...
    + 1/2 * mLBody * (vLBodyMCD * vLBodyMCD') ...
    + 1/2 * mLeg * (vLegMCD * vLegMCD') ...
    + 1/2 * InertiaArm * diff(thHandpre+1/2*pi, t)^2 ...
    + 1/2 * InertiaUBody * diff(thHandpre+1/2*pi + thShoulderpre, t)^2 ...
    + 1/2 * InertiaLBody * diff(thHandpre+1/2*pi + thShoulderpre + thXippre, t)^2 ...
    + 1/2 * InertiaLeg * diff(thHandpre+1/2*pi + thShoulderpre + thXippre + thWaistpre, t)^2;

U = mArm * g * pArmMCDf(2) ...
    + mUBody * g * pUBodyMCDf(2) ...
    + mLBody * g * pLBodyMCDf(2) ...
    + mLeg * g * pLegMCDf(2);

L = T - U;

xHandEq = -functionalDerivative(L, xHandpre) == 0;
yHandEq = -functionalDerivative(L, yHandpre) == 0;
thHandEq = -functionalDerivative(L, thHandpre) == 0;
thShoulderEq = -functionalDerivative(L, thShoulderpre) == TauShoulder;
thXipEq = -functionalDerivative(L, thXippre) == TauXip;
thWaistEq = -functionalDerivative(L, thWaistpre) == TauWaist;


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


Equations = [xHandEq; yHandEq; thHandEq; thShoulderEq; thXipEq; thWaistEq];
Equations = subs(Equations, SymReplaced, SymReplacing);

parallel.defaultClusterProfile('local');
c = parcluster();

%ddxHand, ddyHand, ddthHand, ddthShoulder, ddthWaist
%{/
variables = [ddxHand, ddyHand, ddthHand, ddthShoulder, ddthXip, ddthWaist];

[A, B] = equationsToMatrix(Equations, variables);

% detA = simplify(det(A))
toc

tic
X = inv(A)*B;
toc

ddxHandEq = X(1,1);
ddyHandEq = X(2,1);
ddthHandEq = X(3,1);
ddthShoulderEq = X(4,1);
ddthXipEq = X(5,1);
ddthWaistEq = X(6,1);

tic
%{/
job = createJob(c);
createTask(job, @matlabFunction, 1,{ddxHandEq, 'file', 'find_ddxHand_freefall.m', 'outputs', {'ddxHand'}});
submit(job)
job.Tasks

job = createJob(c);
createTask(job, @matlabFunction, 1,{ddyHandEq, 'file', 'find_ddyHand_freefall.m', 'outputs', {'ddyHand'}});
submit(job)
job.Tasks

job = createJob(c);
createTask(job, @matlabFunction, 1,{ddthHandEq, 'file', 'find_ddthHand_freefall.m', 'outputs', {'ddthHand'}});
submit(job)
job.Tasks

job = createJob(c);
createTask(job, @matlabFunction, 1,{ddthShoulderEq, 'file', 'find_ddthShoulder_freefall.m', 'outputs', {'ddthShoulder'}});
submit(job)
job.Tasks

job = createJob(c);
createTask(job, @matlabFunction, 1,{ddthXipEq, 'file', 'find_ddthXip_freefall.m', 'outputs', {'ddthXip'}});
submit(job)
job.Tasks

job = createJob(c);
createTask(job, @matlabFunction, 1,{ddthWaistEq, 'file', 'find_ddthWaist_freefall.m', 'outputs', {'ddthWaist'}});
submit(job)
job.Tasks

% job = createJob(c);
% createTask(job, @matlabFunction, 1,...
%     {ddxHandEq, ddyHandEq, ddthHandEq, ddthShoulderEq, ddthWaistEq, 'file', 'find_ddxHand_ddyHand_ddthHand_ddthShoulder_ddthWaist_freefall.m',...
%     'outputs', {'ddxHand', 'ddyHand', 'ddthHand', 'ddthShoulder', 'ddthWaist'}});
% submit(job)
% job.Tasks

%}
%}

%ddxHand, ddyHand, ddthHand, TauShoulder, TauWaist
%{/
variables = [ddxHand, ddyHand, ddthHand, TauShoulder, TauXip, TauWaist];

[A, B] = equationsToMatrix(Equations, variables);

% detA = simplify(det(A))

X = inv(A)*B;

TauShoulderEq = X(4,1);
TauXipEq = X(5,1);
TauWaistEq = X(6,1);

%{/
job = createJob(c);
createTask(job, @matlabFunction, 1,{TauShoulderEq, 'file', 'find_TauShoulder_freefall.m', 'outputs', {'TauShoulder'}});
submit(job)
job.Tasks

job = createJob(c);
createTask(job, @matlabFunction, 1,{TauXipEq, 'file', 'find_TauXip_freefall.m', 'outputs', {'TauXip'}});
submit(job)
job.Tasks

job = createJob(c);
createTask(job, @matlabFunction, 1,{TauWaistEq, 'file', 'find_TauWaist_freefall.m', 'outputs', {'TauWaist'}});
submit(job)
job.Tasks
%}
%}
toc






































