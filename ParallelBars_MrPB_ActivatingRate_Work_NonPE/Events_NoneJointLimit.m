function [value,isterminal,direction] = Events_NoneJointLimit(t,q,constants)
%EVENTS この関数の概要をここに記述
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

rPB = q(1);
thHand = q(2);
thShoulder = q(3);
thWaist = q(4);
drPB = q(5);
dthHand = q(6);
dthShoulder = q(7);
dthWaist = q(8);

yHand = rPB;
xHand = 0;
dyHand = drPB;
dxHand = 0;

pHand = [zeros(size(rPB(:,1))), rPB];
vHand = [zeros(size(rPB(:,1))), drPB];

pG = find_pG(mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist,xHand,yHand);
vG = find_vG(dthHand,dthWaist,dthShoulder,dxHand,dyHand,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
momentumG = find_momentumG(InertiaLeg,InertiaArm,InertiaBody,dthHand,dthWaist,dthShoulder,dxHand,dyHand,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist,xHand,yHand);

i = 0;

i = i + 1;
if thShoulder > pi
    value(i) = rPB;
    isterminal(i) = 1;
    direction(i) = 1;
else
    value(i) = -1;
    isterminal(i) = 1;
    direction(i) = 1;
end

i = i+1;
value(i) = abs(thHand) - 45 * pi/180;
isterminal(i) = 0;
direction(i) = 0;

i = i + 1;
if thShoulder <= pi
    value(i) = rPB - mAll/kPB;
    isterminal(i) = 0;
    direction(i) = 1;
else
    value(i) = -1;
    isterminal(i) = 0;
    direction(i) = 1;
end

i = i+1;
value(i) = thShoulder + 15 * pi/180;
isterminal(i) = 0;
direction(i) = 0;

i = i+1;
value(i) = thShoulder - 330 * pi/180;
isterminal(i) = 0;
direction(i) = 0;

i = i+1;
value(i) = thWaist + 60 * pi/180;
isterminal(i) = 0;
direction(i) = 0;

i = i+1;
value(i) = thWaist - 100 * pi/180;
isterminal(i) = 0;
direction(i) = 0;

i = i+1;
value(i) = abs(dthHand) - 100;
isterminal(i) = 1;
direction(i) = 0;

i = i+1;
value(i) = abs(dthShoulder) - 100;
isterminal(i) = 1;
direction(i) = 0;

i = i+1;
value(i) = abs(dthWaist) - 100;
isterminal(i) = 1;
direction(i) = 0;
























end

