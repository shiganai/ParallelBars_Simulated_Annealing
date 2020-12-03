clear all
tic
syms xHandpre(t) yHandpre(t)
syms thHandpre(t) thShoulderpre(t) thWaistpre(t)
syms rArm rBody rLeg real
syms mArm mBody mLeg real
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

U = mArm * g * pArmMCDf(2) ...
    + mBody * g * pBodyMCDf(2) ...
    + mLeg * g * pLegMCDf(2);

% T = 1/2 * mArm * realSymDot(1/2*(vHand+vShoulder), 1/2*(vHand+vShoulder)) ...
%     + 1/2 * mBody * realSymDot(1/2*(vShoulder+vWaist), 1/2*(vShoulder+vWaist)) ...
%     + 1/2 * mLeg * realSymDot(1/2*(vWaist+vToe), 1/2*(vWaist+vToe)) ...
%     + 1/2 * 1/12 * mArm * rArm^2 * diff(thHandpre-1/2*pi, t)^2 ...
%     + 1/2 * 1/12 * mBody * rBody^2 * diff(thHandpre-1/2*pi + thShoulderpre-pi, t)^2 ...
%     + 1/2 * 1/12 * mLeg * rLeg^2 * diff(thHandpre-1/2*pi + thShoulderpre-pi + thWaistpre-pi, t)^2;
% 
% U =mArm * g * (pHandf(2) + pShoulderf(2))/2 ...
%     + mBody * g * (pShoulderf(2) + pWaistf(2))/2 ...
%     + mLeg * g * (pWaistf(2) + pToef(2))/2;

L = T - U;

xHandEq = -functionalDerivative(L, xHandpre) == 0;
yHandEq = -functionalDerivative(L, yHandpre) == 0;
thHandEq = -functionalDerivative(L, thHandpre) == 0;
thShoulderEq = -functionalDerivative(L, thShoulderpre) == MthShoulder;
thWaistEq = -functionalDerivative(L, thWaistpre) == MthWaist;


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


Equations = [xHandEq; yHandEq; thHandEq; thShoulderEq; thWaistEq];
Equations = subs(Equations, SymReplaced, SymReplacing);

parallel.defaultClusterProfile('local');
c = parcluster();

%ddxHand, ddyHand, ddthHand, ddthShoulder, ddthWaist
%{/
variables = [ddxHand, ddyHand, ddthHand, ddthShoulder, ddthWaist];

[A, B] = equationsToMatrix(Equations, variables);

detA = simplify(det(A))
toc

tic
X = inv(A)*B
toc

ddxHandEq = X(1,1);
ddyHandEq = X(2,1);
ddthHandEq = X(3,1);
ddthShoulderEq = X(4,1);
ddthWaistEq = X(5,1);

tic
%{/
% job1 = createJob(c);
% createTask(job1, @matlabFunction, 1,{ddxHandEq, 'file', 'find_ddxHand_freefall.m', 'outputs', {'ddxHand'}});
% submit(job1)
% job1.Tasks
% 
% job2 = createJob(c);
% createTask(job2, @matlabFunction, 1,{ddyHandEq, 'file', 'find_ddyHand_freefall.m', 'outputs', {'ddyHand'}});
% submit(job2)
% job2.Tasks
% 
% job3 = createJob(c);
% createTask(job3, @matlabFunction, 1,{ddthHandEq, 'file', 'find_ddthHand_freefall.m', 'outputs', {'ddthHand'}});
% submit(job3)
% job3.Tasks
% 
% job4 = createJob(c);
% createTask(job4, @matlabFunction, 1,{ddthShoulderEq, 'file', 'find_ddthShoulder_freefall.m', 'outputs', {'ddthShoulder'}});
% submit(job4)
% job4.Tasks
% 
% job5 = createJob(c);
% createTask(job5, @matlabFunction, 1,{ddthWaistEq, 'file', 'find_ddthWaist_freefall.m', 'outputs', {'ddthWaist'}});
% submit(job5)
% job5.Tasks

job6 = createJob(c);
createTask(job6, @matlabFunction, 1,...
    {ddxHandEq, ddyHandEq, ddthHandEq, ddthShoulderEq, ddthWaistEq, 'file', 'find_ddxHand_ddyHand_ddthHand_ddthShoulder_ddthWaist_freefall.m',...
    'outputs', {'ddxHand', 'ddyHand', 'ddthHand', 'ddthShoulder', 'ddthWaist'}});
submit(job6)
job6.Tasks

%}
%}

%ddxHand, ddyHand, ddthHand, MthShoulder, MthWaist
%{/
variables = [ddxHand, ddyHand, ddthHand, MthShoulder, MthWaist];

[A, B] = equationsToMatrix(Equations, variables);

detA = simplify(det(A))

X = inv(A)*B

MthShoulderEq = X(4,1);
MthWaistEq = X(5,1);

%{/
job7 = createJob(c);
createTask(job7, @matlabFunction, 1,{MthShoulderEq, 'file', 'find_MthShoulder_freefall.m', 'outputs', {'MthShoulder'}});
submit(job7)
job7.Tasks

job8 = createJob(c);
createTask(job8, @matlabFunction, 1,{MthWaistEq, 'file', 'find_MthWaist_freefall.m', 'outputs', {'MthWaist'}});
submit(job8)
job8.Tasks
%}
%}
toc






































