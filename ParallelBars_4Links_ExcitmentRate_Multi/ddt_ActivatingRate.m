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
mUBody = constants.mUBody;
mLBody = constants.mLBody;
mLeg = constants.mLeg;
rArm = constants.rArm;
rUBody = constants.rUBody;
rLBody = constants.rLBody;
% rLeg = constants.rLeg;
% InertiaModel = constants.InertiaModel;
rArmMCD = constants.rArmMCD;
rUBodyMCD = constants.rUBodyMCD;
rLBodyMCD = constants.rLBodyMCD;
rLegMCD = constants.rLegMCD;
InertiaArm = constants.InertiaArm;
InertiaUBody = constants.InertiaUBody;
InertiaLBody = constants.InertiaLBody;
InertiaLeg = constants.InertiaLeg;
% InertiaG = constants.InertiaG;
Hand_Para = constants.Hand_Para;
Shoulder_Para = constants.Shoulder_Para;
Xip_Para = constants.Xip_Para;
Waist_Para = constants.Waist_Para;

rPB = q(1);
thHand = q(2);
thShoulder = q(3);
thWaist = q(4);

drPB = q(5);
dthHand = q(6);
dthShoulder = q(7);
dthWaist = q(8);

TauHand_ActivatingRate = fnval(ActivatingRate_spline(1,1), t);
TauShoulder_ActivatingRate = fnval(ActivatingRate_spline(2,1), t);
TauXip_ActivatingRate = fnval(ActivatingRate_spline(3,1), t);
TauWaist_ActivatingRate = fnval(ActivatingRate_spline(4,1), t);

if TauHand_ActivatingRate < -1
    TauHand_ActivatingRate = -1;
elseif TauHand_ActivatingRate > 1
    TauHand_ActivatingRate = 1;
end

if TauShoulder_ActivatingRate < -1
    TauShoulder_ActivatingRate = -1;
elseif TauShoulder_ActivatingRate > 1
    TauShoulder_ActivatingRate = 1;
end

if TauXip_ActivatingRate < -1
    TauXip_ActivatingRate = -1;
elseif TauXip_ActivatingRate > 1
    TauXip_ActivatingRate = 1;
end

if TauWaist_ActivatingRate < -1
    TauWaist_ActivatingRate = -1;
elseif TauWaist_ActivatingRate > 1
    TauWaist_ActivatingRate = 1;
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

FrPB = 2 * (-kPB * rPB - cPB * drPB);
TauHand = VoluntaryTorque(Hand_Para, thHand_degree_VT, dthHand_degree, TauHand_ActivatingRate) * 2;
TauShoulder = VoluntaryTorque(Shoulder_Para, thShoulder_degree, dthShoulder_degree, TauShoulder_ActivatingRate) * 2;
TauWaist = VoluntaryTorque(Waist_Para, thWaist_degree, dthWaist_degree, TauWaist_ActivatingRate) * 2;

% [ddrPB,ddthHand,ddthShoulder,ddthWaist] = find_ddrPB_ddthHand_ddthShoulder_ddthWaist(InertiaLeg,InertiaArm,InertiaBody,MrPB,TauHand,TauWaist,TauShoulder,dthHand,dthWaist,dthShoulder,g,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);

ddrPB = find_ddrPB(FrPB,InertiaLeg,InertiaArm,InertiaLBody,InertiaUBody,TauXip,TauHand,TauWaist,TauShoulder,dthXip,dthHand,dthWaist,dthShoulder,g,mArm,mLBody,mLeg,mPB,mUBody,rArm,rArmMCD,rLBody,rLegMCD,rUBody,rUBodyMCD,thHand,thShoulder,thWaist,thXip);
ddthHand = find_ddthHand(FrPB,InertiaLeg,InertiaArm,InertiaLBody,InertiaUBody,TauXip,TauHand,TauWaist,TauShoulder,dthXip,dthHand,dthWaist,dthShoulder,g,mArm,mLBody,mLeg,mPB,mUBody,rArm,rArmMCD,rLBody,rLegMCD,rUBody,rUBodyMCD,thHand,thShoulder,thWaist,thXip);
ddthShoulder = find_ddthShoulder(FrPB,InertiaLeg,InertiaArm,InertiaLBody,InertiaUBody,TauXip,TauHand,TauWaist,TauShoulder,dthXip,dthHand,dthWaist,dthShoulder,g,mArm,mLBody,mLeg,mPB,mUBody,rArm,rArmMCD,rLBody,rLegMCD,rUBody,rUBodyMCD,thHand,thShoulder,thWaist,thXip);
ddthXip = find_ddthXip(FrPB,InertiaLeg,InertiaArm,InertiaLBody,InertiaUBody,TauXip,TauHand,TauWaist,TauShoulder,dthXip,dthHand,dthWaist,dthShoulder,g,mArm,mLBody,mLeg,mPB,mUBody,rArm,rArmMCD,rLBody,rLegMCD,rUBody,rUBodyMCD,thHand,thShoulder,thWaist,thXip);
ddthWaist = find_ddthWaist(FrPB,InertiaLeg,InertiaArm,InertiaLBody,InertiaUBody,TauXip,TauHand,TauWaist,TauShoulder,dthXip,dthHand,dthWaist,dthShoulder,g,mArm,mLBody,mLeg,mPB,mUBody,rArm,rArmMCD,rLBody,rLegMCD,rUBody,rUBodyMCD,thHand,thShoulder,thWaist,thXip);

dotq = [drPB, dthHand, dthShoulder, dthWaist, ddrPB, ddthHand, ddthShoulder, ddthWaist]';
end
































