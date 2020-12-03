function dotq = ddt_Realization(t,q,constants, ddpp_TH)
%DDT この関数の概要をここに記述
%   詳細説明をここに記述

g = constants.g;
kPB = constants.kPB;
cPB = constants.cPB;
% mAll = constants.mAll;
mPB = constants.mPB;
% rAll = constants.rAll;
mArm = constants.mArm;
mBody = constants.mBody;
mLeg = constants.mLeg;
rArm = constants.rArm;
rBody = constants.rBody;
% rLeg = constants.rLeg;
% thHand_MaxTorque = constants.thHand_MaxTorque;
% thShoulder_MaxTorque = constants.thShoulder_MaxTorque;
% thWaist_MaxTorque = constants.thWaist_MaxTorque;
% InertiaModel = constants.InertiaModel;
rArmMCD = constants.rArmMCD;
rBodyMCD = constants.rBodyMCD;
rLegMCD = constants.rLegMCD;
% InertiaArm = constants.InertiaArm;
% InertiaBody = constants.InertiaBody;
% InertiaLeg = constants.InertiaLeg;
% InertiaG = constants.InertiaG;

rPB = q(1);
thHand = q(2);
thShoulder = q(3);
thWaist = q(4);

drPB = q(5);
dthHand = q(6);
dthShoulder = q(7);
dthWaist = q(8);

ddthHand_pp = ddpp_TH(1,1);
ddthShoulder_pp = ddpp_TH(2,1);
ddthWaist_pp = ddpp_TH(3,1);

ddthHand = fnval(ddthHand_pp, t);
ddthShoulder = fnval(ddthShoulder_pp, t);
ddthWaist = fnval(ddthWaist_pp, t);

MrPB = -cPB * drPB;

ddrPB = find_ddrPB_only(MrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,kPB,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,rPB,thHand,thShoulder,thWaist);
% ddrPB = find_ddrPB_only_mex(MrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,kPB,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,rPB,thHand,thShoulder,thWaist);

dotq = [drPB, dthHand, dthShoulder, dthWaist, ddrPB, ddthHand, ddthShoulder, ddthWaist]';
end















































