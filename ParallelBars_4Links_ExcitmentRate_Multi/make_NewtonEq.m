clear all

tic
syms rPBpre(t) thHandpre(t) thShoulderpre(t) thXippre(t) thWaistpre(t)
syms rArm rUBody rLBody rLeg real
syms mPB mArm mUBody mLBody mLeg real
syms FrPB TauHand TauShoulder TauXip TauWaist real
syms g real
syms rArmMCD rUBodyMCD rLBodyMCD rLegMCD real
syms InertiaArm InertiaUBody InertiaLBody InertiaLeg real

pHand = [0, rPBpre];
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

L = T - U;

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

parallel.defaultClusterProfile('local');
c = parcluster();

%ddrPB ddthHand ddthShoulder ddthWaist
%{/
variables = [ddrPB, ddthHand, ddthShoulder, ddthXip, ddthWaist];

[A, B] = equationsToMatrix(Equations, variables);

% detA = simplify(det(A))
toc

tic
% X = B\A;
X = inv(A)*B;
toc

ddrPBEq = X(1,1);
ddthHandEq = X(2,1);
ddthShoulderEq = X(3,1);
ddthXipEq = X(4,1);
ddthWaistEq = X(5,1);

tic

%{/
job_tmp = createJob(c);
createTask(job_tmp, @matlabFunction, 1,{ddrPBEq, 'file', 'find_ddrPB.m', 'outputs', {'ddrPB'}});
submit(job_tmp)
job_tmp.Tasks

job_tmp = createJob(c);
createTask(job_tmp, @matlabFunction, 1,{ddthHandEq, 'file', 'find_ddthHand.m', 'outputs', {'ddthHand'}});
submit(job_tmp)
job_tmp.Tasks

job_tmp = createJob(c);
createTask(job_tmp, @matlabFunction, 1,{ddthShoulderEq, 'file', 'find_ddthShoulder.m', 'outputs', {'ddthShoulder'}});
submit(job_tmp)
job_tmp.Tasks

job_tmp = createJob(c);
createTask(job_tmp, @matlabFunction, 1,{ddthXipEq, 'file', 'find_ddthXip.m', 'outputs', {'ddthXip'}});
submit(job_tmp)
job_tmp.Tasks

job_tmp = createJob(c);
createTask(job_tmp, @matlabFunction, 1,{ddthWaistEq, 'file', 'find_ddthWaist.m', 'outputs', {'ddthWaist'}});
submit(job_tmp)
job_tmp.Tasks

job_tmp = createJob(c);
createTask(job_tmp, @matlabFunction, 1,...
    {ddrPBEq, ddthHandEq, ddthShoulderEq, ddthXipEq, ddthWaistEq, 'file', 'find_ddrPB_ddthHand_ddthShoulder_ddthXip_ddthWaist.m',...
    'outputs', {'ddrPB', 'ddthHand', 'ddthShoulder', 'ddthXip', 'ddthWaist'}});
submit(job_tmp)
job_tmp.Tasks
%}
%}

%FrPB, TauHand, TauShoulder, TauWaist
%{/
variables = [FrPB, TauHand, TauShoulder, TauXip, TauWaist];

[A, B] = equationsToMatrix(Equations, variables);

% detA = simplify(det(A))

X = inv(A)*B;

FrPBEq = X(1,1);
TauHandEq = X(2,1);
TauShoulderEq = X(3,1);
TauXipEq = X(4,1);
TauWaistEq = X(5,1);

tic

%{/
job_tmp = createJob(c);
createTask(job_tmp, @matlabFunction, 1,{FrPBEq, 'file', 'find_FrPB.m', 'outputs', {'FrPB'}});
submit(job_tmp)
job_tmp.Tasks

job_tmp = createJob(c);
createTask(job_tmp, @matlabFunction, 1,{TauHandEq, 'file', 'find_TauHand.m', 'outputs', {'TauHand'}});
submit(job_tmp)
job_tmp.Tasks

job_tmp = createJob(c);
createTask(job_tmp, @matlabFunction, 1,{TauShoulderEq, 'file', 'find_TauShoulder.m', 'outputs', {'TauShoulder'}});
submit(job_tmp)
job_tmp.Tasks

job_tmp = createJob(c);
createTask(job_tmp, @matlabFunction, 1,{TauXipEq, 'file', 'find_TauXip.m', 'outputs', {'TauXip'}});
submit(job_tmp)
job_tmp.Tasks

job_tmp = createJob(c);
createTask(job_tmp, @matlabFunction, 1,{TauWaistEq, 'file', 'find_TauWaist.m', 'outputs', {'TauWaist'}});
submit(job_tmp)
job_tmp.Tasks
%}
%}

%ddrPB, TauHand, TauShoulder, TauWaist
%{/
variables = [ddrPB, TauHand, TauShoulder, TauXip, TauWaist];

[A, B] = equationsToMatrix(Equations, variables);

% detA = simplify(det(A))

X = inv(A)*B;

ddrPBEq = X(1,1);
TauHandEq = X(2,1);
TauShoulderEq = X(3,1);
TauXipEq = X(4,1);
TauWaistEq = X(5,1);

tic

%{/
job_tmp = createJob(c);
createTask(job_tmp, @matlabFunction, 1,{ddrPBEq, 'file', 'find_ddrPB_only.m', 'outputs', {'ddrPB'}});
submit(job_tmp)
job_tmp.Tasks
%}
%}
toc




































