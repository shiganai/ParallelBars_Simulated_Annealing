function dotq = ddt(t,q,constants)
%DDT この関数の概要をここに記述
%   詳細説明をここに記述

g = constants.g;
kPB = constants.kPB;
cPB = constants.cPB;
mPB = constants.mPB;

mAll = constants.mAll;
mArm = constants.mArm;
mBody = constants.mBody;
mLeg = constants.mLeg;

rAll = constants.rAll;
rArm = constants.rArm;
rBody = constants.rBody;
rLeg = constants.rLeg;

rPB = q(1);
thHand = q(2);
thShoulder = q(3);
thWaist = q(4);

drPB = q(5);
dthHand = q(6);
dthShoulder = q(7);
dthWaist = q(8);

thBody = thHand+1/2*pi + thShoulder -1/2*pi;

MrPB = -cPB * drPB;
MthShoulder = 1;
ddthWaist = 0;

if (thBody >= 0 && thBody < 15/180*pi)
    MthHand = 1.5;
elseif (thBody >= 15/180*pi && thBody < 80/180*pi)
    MthHand = 220;
elseif (thBody >= 80/180*pi && thBody < 180/180*pi)
    MthHand = -220;
else
    MthHand = -00;
end

% if thHand < -10/180*pi
%     MthHand = 150;
% elseif thHand > 30/180*pi
%     MthHand = -10;
% elseif thHand < 0/180*pi
%     MthHand = 1.5;
% elseif thHand > 0/180*pi
%     MthHand = -1.5;
% else
%     MthHand = 0;
% end


[ddrPB,ddthHand,ddthShoulder] = find_ddrPB_ddthHand_ddthShoulder(constants,MrPB,MthHand,MthShoulder,ddthWaist,dthHand,dthWaist,dthShoulder,rPB,thHand,thShoulder,thWaist);

dotq = [drPB, dthHand, dthShoulder, dthWaist, ddrPB, ddthHand, ddthShoulder, ddthWaist]';
end

