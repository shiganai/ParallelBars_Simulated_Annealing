function [value,isterminal,direction] = Events_freefall(t,q,constants)
%EVENTS この関数の概要をここに記述
%   詳細説明をここに記述
g = constants.g;
kPB = constants.kPB;
mPB = constants.mPB;

mAll = constants.mAll;
mArm = constants.mArm;
mBody = constants.mBody;
mLeg = constants.mLeg;

rAll = constants.rAll;
rArm = constants.rArm;
rBody = constants.rBody;
rLeg = constants.rLeg;

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

vHand = [dxHand, dyHand];
vShoulder = vHand + rArm * [-sin(thHand+1/2*pi), cos(thHand+1/2*pi)] .* dthHand;
vWaist = vShoulder + rBody * [-sin(thHand+1/2*pi + thShoulder), cos(thHand+1/2*pi + thShoulder)] .* (dthHand + dthShoulder);
vToe = vWaist + rLeg * [-sin(thHand+1/2*pi + thShoulder + thWaist), cos(thHand+1/2*pi + thShoulder + thWaist)] .* (dthHand + dthShoulder + dthWaist);

pG = 1/(mArm + mBody + mLeg) * (mArm * (pHand + pShoulder)/2 + mBody * (pShoulder + pWaist)/2 + mLeg * (pWaist + pToe)/2);
vG = 1/(mArm + mBody + mLeg) * (mArm * (vHand + vShoulder)/2 + mBody * (vShoulder + vWaist)/2 + mLeg * (vWaist + vToe)/2);

i = 0;

i = i + 1;
value(i) = pG(1,2) - (-1.8);
% value(i) = pG(1,2) - (-1.8 + rLeg);
isterminal(i) = 1;
direction(i) = -1;

% i = i + 1;
% if thShoulder > 1*pi
%     value(i) = momentumG;
%     isterminal(i) = 1;
%     direction(i) = -1;
% else
%     value(i) = 1;
%     isterminal(i) = 0;
%     direction(i) = 0;
% end
























end

