function dotq = ddt_ActivatingRate(t, q, constants, ActivatingRate_spline)
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
% InertiaModel = constants.InertiaModel;
rArmMCD = constants.rArmMCD;
rBodyMCD = constants.rBodyMCD;
rLegMCD = constants.rLegMCD;
InertiaArm = constants.InertiaArm;
InertiaBody = constants.InertiaBody;
InertiaLeg = constants.InertiaLeg;
% InertiaG = constants.InertiaG;
Hand_Para = constants.Hand_Para;
Shoulder_Para = constants.Shoulder_Para;
Waist_Para = constants.Waist_Para;

rPB = q(1);
thHand = q(2);
thShoulder = q(3);
thWaist = q(4);

drPB = q(5);
dthHand = q(6);
dthShoulder = q(7);
dthWaist = q(8);

MthHand_ActivatingRate = fnval(ActivatingRate_spline(1,1), t);
MthShoulder_ActivatingRate = fnval(ActivatingRate_spline(2,1), t);
MthWaist_ActivatingRate = fnval(ActivatingRate_spline(3,1), t);

if MthHand_ActivatingRate < -1
    MthHand_ActivatingRate = -1;
elseif MthHand_ActivatingRate > 1
    MthHand_ActivatingRate = 1;
end
if MthShoulder_ActivatingRate < -1
    MthShoulder_ActivatingRate = -1;
elseif MthShoulder_ActivatingRate > 1
    MthShoulder_ActivatingRate = 1;
end
if MthWaist_ActivatingRate < -1
    MthWaist_ActivatingRate = -1;
elseif MthWaist_ActivatingRate > 1
    MthWaist_ActivatingRate = 1;
end

thHand_degree = rad2deg(thHand);
thShoulder_degree = rad2deg(thShoulder);
thWaist_degree = rad2deg(thWaist);
dthHand_degree = rad2deg(dthHand);
dthShoulder_degree = rad2deg(dthShoulder);
dthWaist_degree = rad2deg(dthWaist);

thHand_degree_VT = thHand_degree;
thHand_degree_VT(thHand_degree < Hand_Para.theta_PE_1_Ext) = Hand_Para.theta_PE_1_Ext;
thHand_degree_VT(thHand_degree > Hand_Para.theta_PE_1_Flex) = Hand_Para.theta_PE_1_Flex;

% MrPB = 1 * (-kPB * rPB - cPB * drPB);
MrPB = 2 * (-kPB * rPB - cPB * drPB);
MthHand = VoluntaryTorque(Hand_Para, thHand_degree_VT, dthHand_degree, MthHand_ActivatingRate) * 2;
MthShoulder = VoluntaryTorque(Shoulder_Para, thShoulder_degree, dthShoulder_degree, MthShoulder_ActivatingRate) * 2;
MthWaist = VoluntaryTorque(Waist_Para, thWaist_degree, dthWaist_degree, MthWaist_ActivatingRate) * 2;

[ddrPB,ddthHand,ddthShoulder,ddthWaist] = find_ddrPB_ddthHand_ddthShoulder_ddthWaist(InertiaLeg,InertiaArm,InertiaBody,MrPB,MthHand,MthWaist,MthShoulder,dthHand,dthWaist,dthShoulder,g,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);

dotq = [drPB, dthHand, dthShoulder, dthWaist, ddrPB, ddthHand, ddthShoulder, ddthWaist]';
end
































