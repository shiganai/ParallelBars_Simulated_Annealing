function dotq = ddt_freefall(t, q, constants)
%DDT この関数の概要をここに記述
%   詳細説明をここに記述

g = constants.g;
kPB = constants.kPB;
cPB = constants.cPB;
mAll = constants.mAll;
mPB = constants.mPB;
rAll = constants.rAll;
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

xHand = q(1);
yHand = q(2);
thHand = q(3);
thShoulder = q(4);
thWaist = q(5);

dxHand = q(6);
dyHand = q(7);
dthHand = q(8);
dthShoulder = q(9);
dthWaist = q(10);

pHand = [xHand, yHand];
pShoulder = pHand + rArm * [cos(thHand+1/2*pi), sin(thHand+1/2*pi)];
pWaist = pShoulder + rBody * [cos(thHand+1/2*pi + thShoulder), sin(thHand+1/2*pi + thShoulder)];
pToe = pWaist + rLeg * [cos(thHand+1/2*pi + thShoulder + thWaist), sin(thHand+1/2*pi + thShoulder + thWaist)];

alpha = 0;

%屈身ver
%{/
bShoulder = mArm * 1e-0;
bWaist = mLeg * 4e-1;
ddthShoulder = - bShoulder^2 * (1-alpha^2) * (thShoulder-3/4*pi) - 2 * bShoulder * dthShoulder;
ddthWaist = - bWaist^2 * (1-alpha^2) * (thWaist-6.5/8*pi) - 2 * bWaist * dthWaist;
%}

%伸身ver
%{
bShoulder = mArm * 4e-1;
bWaist = mLeg * 10e-1;
ddthShoulder = - bShoulder^2 * (1-alpha^2) * (thShoulder-pi) - 2 * bShoulder * dthShoulder;
ddthWaist = - bWaist^2 * (1-alpha^2) * (thWaist) - 2 * bWaist * dthWaist;
%}

MthShoulder = find_MthShoulder_freefall(InertiaLeg,InertiaArm,InertiaBody,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
MthWaist = find_MthWaist_freefall(InertiaLeg,InertiaArm,InertiaBody,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);

[ddxHand,ddyHand,ddthHand,ddthShoulder,ddthWaist] = find_ddxHand_ddyHand_ddthHand_ddthShoulder_ddthWaist_freefall(InertiaLeg,InertiaArm,InertiaBody,MthWaist,MthShoulder,dthHand,dthWaist,dthShoulder,g,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);

dotq = [dxHand, dyHand, dthHand, dthShoulder, dthWaist, ddxHand, ddyHand, ddthHand, ddthShoulder, ddthWaist]';
end
































