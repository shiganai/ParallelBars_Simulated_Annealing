function q0 = generate_q0(constants)
%GENERATE_Q0 この関数の概要をここに記述
%   詳細説明をここに記述

g = constants.g;
kPB = constants.kPB;
cPB = constants.cPB;
mAll = constants.mAll;
mPB = constants.mPB;
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

t = 0:1e-2:3;

rPB0 = -(mAll+mPB)*g/(kPB*2);
thHand0 = 0;
thShoulder0 = 0;
thWaist0 = 0;

drPB0 = 0;
dthHand0 = 0;
dthShoulder0 = 0;
dthWaist0 = 0;

q0 = [rPB0, thHand0, thShoulder0, thWaist0, drPB0, dthHand0, dthShoulder0, dthWaist0]';
end

