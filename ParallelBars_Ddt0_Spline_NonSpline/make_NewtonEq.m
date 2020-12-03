clear all
tic
syms rPBpre(t) thHandpre(t) thShoulderpre(t) thWaistpre(t)
syms rArm rBody rLeg real
syms mPB mArm mBody mLeg real
syms MrPB MthHand MthShoulder MthWaist real
syms kPB g real
syms rArmMCD rBodyMCD rLegMCD real
syms InertiaArm InertiaBody InertiaLeg real

pHand = [0, rPBpre];
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

U = 1/2 * kPB * rPBpre^2 + mPB * g * pHandf(2) ...
    + mArm * g * pArmMCDf(2) ...
    + mBody * g * pBodyMCDf(2) ...
    + mLeg * g * pLegMCDf(2);

L = T - U;

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

symreplaced = [rPBreplaced, thHandreplaced, thShoulderreplaced, thWaistreplaced];
symreplacing = [rPBreplacing, thHandreplacing, thShoulderreplacing, thWaistreplacing];

Equations = [rHBEq; thHandEq; thShoulderEq; thWaistEq];
Equations = subs(Equations, symreplaced, symreplacing);

parallel.defaultClusterProfile('local');
c = parcluster();

%ddrPB ddthHand ddthShoulder ddthWaist
%{
variables = [ddrPB, ddthHand, ddthShoulder, ddthWaist];

[A, B] = equationsToMatrix(Equations, variables);

detA = simplify(det(A))
toc

tic
X = inv(A)*B
toc

ddrPBEq = X(1,1);
ddthHandEq = X(2,1);
ddthShoulderEq = X(3,1);
ddthWaistEq = X(4,1);

tic

%{
job1 = createJob(c);
createTask(job1, @matlabFunction, 1,{ddrPBEq, 'file', 'find_ddrPB.m', 'outputs', {'ddrPB'}});
submit(job1)
job1.Tasks

job2 = createJob(c);
createTask(job2, @matlabFunction, 1,{ddthHandEq, 'file', 'find_ddthHand.m', 'outputs', {'ddthHand'}});
submit(job2)
job2.Tasks

job3 = createJob(c);
createTask(job3, @matlabFunction, 1,{ddthShoulderEq, 'file', 'find_ddthShoulder.m', 'outputs', {'ddthShoulder'}});
submit(job3)
job3.Tasks

job4 = createJob(c);
createTask(job4, @matlabFunction, 1,{ddthWaistEq, 'file', 'find_ddthWaist.m', 'outputs', {'ddthWaist'}});
submit(job4)
job4.Tasks

job5 = createJob(c);
createTask(job5, @matlabFunction, 1,...
    {ddrPBEq, ddthHandEq, ddthShoulderEq, ddthWaistEq, 'file', 'find_ddrPB_ddthHand_ddthShoulder_ddthWaist.m',...
    'outputs', {'ddrPB', 'ddthHand', 'ddthShoulder', 'ddthWaist'}});
submit(job5)
job5.Tasks
%}
%}

%MrPB, MthHand, MthShoulder, MthWaist
%{
variables = [MrPB, MthHand, MthShoulder, MthWaist];

[A, B] = equationsToMatrix(Equations, variables);

detA = simplify(det(A))

X = inv(A)*B

MrPBEq = X(1,1);
MthHandEq = X(2,1);
MthShoulderEq = X(3,1);
MthWaistEq = X(4,1);

tic

%{
job6 = createJob(c);
createTask(job6, @matlabFunction, 1,{MrPBEq, 'file', 'find_MrPB.m', 'outputs', {'MrPB'}});
submit(job6)
job6.Tasks

job7 = createJob(c);
createTask(job7, @matlabFunction, 1,{MthHandEq, 'file', 'find_MthHand.m', 'outputs', {'MthHand'}});
submit(job7)
job7.Tasks

job8 = createJob(c);
createTask(job8, @matlabFunction, 1,{MthShoulderEq, 'file', 'find_MthShoulder.m', 'outputs', {'MthShoulder'}});
submit(job8)
job8.Tasks

job9 = createJob(c);
createTask(job9, @matlabFunction, 1,{MthWaistEq, 'file', 'find_MthWaist.m', 'outputs', {'MthWaist'}});
submit(job9)
job9.Tasks
%}
%}

%ddrPB, MthHand, MthShoulder, MthWaist
%{
variables = [ddrPB, MthHand, MthShoulder, MthWaist];

[A, B] = equationsToMatrix(Equations, variables);

detA = simplify(det(A))

X = inv(A)*B

ddrPBEq = X(1,1);
MthHandEq = X(2,1);
MthShoulderEq = X(3,1);
MthWaistEq = X(4,1);

%{
% job10 = createJob(c);
% createTask(job10, @matlabFunction, 1,{ddrPBEq, 'file', 'find_ddrPB_only.m', 'outputs', {'ddrPB'}});
% submit(job10)
% job10.Tasks

job10 = createJob(c);
createTask(job10, @matlabFunction, 1,{MthHandEq, MthShoulderEq, MthWaistEq, 'file', 'find_MthHand_MthShoulder_MthWaist.m', 'outputs', {'MthHand', 'MthShoulder','MthWaist'}});
submit(job10)
job10.Tasks
%}
%}

%----------------------------ddt0------------------------------------------

%ddrPB, MthHand, ddthShoulder, ddthWaist
%{
variables = [ddrPB, MthHand, ddthShoulder, ddthWaist];

[A, B] = equationsToMatrix(Equations, variables);

detA = simplify(det(A))

X = inv(A)*B

ddrPBEq = X(1,1);
MthHandEq = X(2,1);
ddthShoulderEq = X(3,1);
ddthWaistEq = X(4,1);

%{
job11 = createJob(c);
createTask(job11, @matlabFunction, 1,{ddrPBEq, ddthShoulderEq, ddthWaistEq, MthHandEq, 'file', 'find_ddrPB_ddthShoulder_ddthWaist_MthHand_ddt0.m', 'outputs', {'ddrPB', 'ddthShoulder', 'ddthWaist', 'MthHand'}});
submit(job11)
job11.Tasks
%}
%}

%ddrPB, ddthHand, MthShoulder, ddthWaist
%{
variables = [ddrPB, ddthHand, MthShoulder, ddthWaist];

[A, B] = equationsToMatrix(Equations, variables);

detA = simplify(det(A))

X = inv(A)*B

ddrPBEq = X(1,1);
ddthHandEq = X(2,1);
MthShoulderEq = X(3,1);
ddthWaistEq = X(4,1);

%{
job12 = createJob(c);
createTask(job12, @matlabFunction, 1,{ddrPBEq, ddthHandEq, ddthWaistEq, MthShoulderEq, 'file', 'find_ddrPB_ddthHand_ddthWaist_MthShoulder_ddt0.m', 'outputs', {'ddrPB', 'ddthHand', 'ddthWaist', 'MthShoulder'}});
submit(job12)
job12.Tasks
%}
%}

%ddrPB, ddthHand, ddthShoulder, MthWaist
%{
variables = [ddrPB, ddthHand, ddthShoulder, MthWaist];

[A, B] = equationsToMatrix(Equations, variables);

detA = simplify(det(A))

X = inv(A)*B

ddrPBEq = X(1,1);
ddthHandEq = X(2,1);
ddthShoulderEq = X(3,1);
MthWaistEq = X(4,1);

%{
job13 = createJob(c);
createTask(job13, @matlabFunction, 1,{ddrPBEq, ddthHandEq, ddthShoulderEq, MthWaistEq, 'file', 'find_ddrPB_ddthHand_ddthShoulder_MthWaist_ddt0.m', 'outputs', {'ddrPB', 'ddthHand', 'ddthShoulder', 'MthWaist'}});
submit(job13)
job13.Tasks
%}
%}

%ddrPB, MthHand, MthShoulder, ddthWaist
%{
variables = [ddrPB, MthHand, MthShoulder, ddthWaist];

[A, B] = equationsToMatrix(Equations, variables);

detA = simplify(det(A))

X = inv(A)*B

ddrPBEq = X(1,1);
MthHandEq = X(2,1);
MthShoulderEq = X(3,1);
ddthWaistEq = X(4,1);

%{
job14 = createJob(c);
createTask(job14, @matlabFunction, 1,{ddrPBEq, ddthWaistEq, MthHandEq, MthShoulderEq, 'file', 'find_ddrPB_ddthWaist_MthHand_MthShoulder_ddt0.m', 'outputs', {'ddrPB', 'ddthWaist', 'MthHand', 'MthShoulder'}});
submit(job14)
job14.Tasks
%}
%}

%ddrPB, MthHand, ddthShoulder, MthWaist
%{
variables = [ddrPB, MthHand, ddthShoulder, MthWaist];

[A, B] = equationsToMatrix(Equations, variables);

detA = simplify(det(A))

X = inv(A)*B

ddrPBEq = X(1,1);
MthHandEq = X(2,1);
ddthShoulderEq = X(3,1);
MthWaistEq = X(4,1);

%{
job15 = createJob(c);
createTask(job15, @matlabFunction, 1,{ddrPBEq, ddthShoulderEq, MthHandEq, MthWaistEq, 'file', 'find_ddrPB_ddthShoulder_MthHand_MthWaist_ddt0.m', 'outputs', {'ddrPB', 'ddthShoulder', 'MthHand', 'MthWaist'}});
submit(job15)
job15.Tasks
%}
%}

%ddrPB, ddthHand, MthShoulder, MthWaist
%{
variables = [ddrPB, ddthHand, MthShoulder, MthWaist];

[A, B] = equationsToMatrix(Equations, variables);

detA = simplify(det(A))

X = inv(A)*B

ddrPBEq = X(1,1);
ddthHandEq = X(2,1);
MthShoulderEq = X(3,1);
MthWaistEq = X(4,1);

%{
job16 = createJob(c);
createTask(job16, @matlabFunction, 1,{ddrPBEq, ddthHandEq, MthShoulderEq, MthWaistEq, 'file', 'find_ddrPB_ddthHand_MthShoulder_MthWaist_ddt0.m', 'outputs', {'ddrPB', 'ddthHand', 'MthShoulder', 'MthWaist'}});
submit(job16)
job16.Tasks
%}
%}

%ddrPB, MthHand, MthShoulder, MthWaist
%{
variables = [ddrPB, MthHand, MthShoulder, MthWaist];

[A, B] = equationsToMatrix(Equations, variables);

detA = simplify(det(A))

X = inv(A)*B

ddrPBEq = X(1,1);
MthHandEq = X(2,1);
MthShoulderEq = X(3,1);
MthWaistEq = X(4,1);

%{
job17 = createJob(c);
createTask(job17, @matlabFunction, 1,{ddrPBEq, MthHandEq, MthShoulderEq, MthWaistEq, 'file', 'find_ddrPB_MthHand_MthShoulder_MthWaist_ddt0.m', 'outputs', {'ddrPB', 'MthHand', 'MthShoulder', 'MthWaist'}});
submit(job17)
job17.Tasks
%}
%}

toc




































