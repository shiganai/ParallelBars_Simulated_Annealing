function [value,isterminal,direction] = Events_dthWaistLimited_AtHorizon(t,q,constants)
%EVENTS この関数の概要をここに記述
%   詳細説明をここに記述

g = constants.g;
kPB = constants.kPB;
cPB = constants.cPB;
mAll = constants.mAll;
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
% Hand_Para = constants.Hand_Para;
% Shoulder_Para = constants.Shoulder_Para;
% Waist_Para = constants.Waist_Para;

rPB = q(1);
thHand = q(2);
thShoulder = q(3);
thWaist = q(4);
drPB = q(5);
dthHand = q(6);
dthShoulder = q(7);
dthWaist = q(8);

%{/
thHand_degree = rad2deg(thHand);
thShoulder_degree = rad2deg(thShoulder);
thWaist_degree = rad2deg(thWaist);
dthHand_degree = rad2deg(dthHand);
dthShoulder_degree = rad2deg(dthShoulder);
dthWaist_degree = rad2deg(dthWaist);

thBody = thHand+1/2*pi + thShoulder;
thBody_degree = rad2deg(thBody);
%}

%% 離手条件
i = 1;
if thShoulder > pi
    value(i) = rPB;
    isterminal(i) = 1;
    direction(i) = 1;
else
    value(i) = -1;
    isterminal(i) = 1;
    direction(i) = 1;
end

%% thShoulderを評価する失敗
i = 2;
value(i) = thHand_degree + 45;
isterminal(i) = 1;
direction(i) = 0;

% if thHand_degree < Hand_Para.theta_PE_1_Ext
%     thHand_degree
%     Hand_Para.theta_PE_1_Ext
%     1
% end

i = 3;
value(i) = 45 - thHand_degree;
isterminal(i) = 1;
direction(i) = 0;

i = 4;
if thShoulder_degree <= 180
    value(i) = rPB;
%     value(i) = rPB - mAll*g/kPB;
    isterminal(i) = 1;
    direction(i) = 1;
else
    value(i) = -1;
    isterminal(i) = 1;
    direction(i) = 1;
end

%% 評価値をNaNに設定する失敗


i = 5;
if (thBody_degree >= 0 && thBody_degree <= 270)
    value(i) = dthWaist_degree;
    isterminal(i) = 1;
    direction(i) = 1;
else
    value(i) = -1;
    isterminal(i) = 1;
    direction(i) = 1;
end

% i = 5;
% value(i) = thShoulder_degree - Shoulder_Para.theta_PE_1_Ext;
% isterminal(i) = 1;
% direction(i) = 0;
% 
% i = 6;
% value(i) = Shoulder_Para.theta_PE_1_Flex - thShoulder_degree;
% isterminal(i) = 1;
% direction(i) = 0;
% 
% i = 7;
% value(i) = thWaist_degree - Waist_Para.theta_PE_1_Ext;
% isterminal(i) = 1;
% direction(i) = 0;
% 
% i = 8;
% value(i) = Waist_Para.theta_PE_1_Flex - thWaist;
% isterminal(i) = 1;
% direction(i) = 0;






















end

