function dotq = ddt_fromM(t, q, constants, MthHandDataF, MthShoulderDataF, MthWaistDataF)
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

inertiaG = constants.inertiaG;

rPB = q(1);
thHand = q(2);
thShoulder = q(3);
thWaist = q(4);

drPB = q(5);
dthHand = q(6);
dthShoulder = q(7);
dthWaist = q(8);

MrPB = -cPB*drPB;
MthHand = MthHandDataF(t);
MthShoulder = MthShoulderDataF(t);
MthWaist = MthWaistDataF(t);

if thShoulder>240/180*pi
    ddthShoulder = -10*dthShoulder;
    [ddrPB,ddthHand,ddthWaist] = find_ddrPB_ddthHand_ddthWaist(constants,MrPB,MthHand,MthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,rPB,thHand,thShoulder,thWaist);
else
    [ddrPB,ddthHand,ddthShoulder,ddthWaist] = find_ddrPB_ddthHand_ddthShoulder_ddthWaist(constants,MrPB,MthHand,MthWaist,MthShoulder,dthHand,dthWaist,dthShoulder,rPB,thHand,thShoulder,thWaist);
end
% ddthWaist = 0;
% [ddrPB,ddthHand,ddthShoulder] = find_ddrPB_ddthHand_ddthShoulder(MrPB,MthHand,MthShoulder,ddthWaist,dthHand,dthWaist,dthShoulder,g,kPB,mArm,mBody,mLeg,mPB,rArm,rBody,rLeg,rPB,thHand,thShoulder,thWaist);

dotq = [drPB, dthHand, dthShoulder, dthWaist, ddrPB, ddthHand, ddthShoulder, ddthWaist]';
end
































