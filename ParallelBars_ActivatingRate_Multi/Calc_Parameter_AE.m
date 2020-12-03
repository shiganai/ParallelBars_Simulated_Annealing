function [mArm, mBody, mLeg, rArm, rBody, rLeg, rArmMCD, rBodyMCD, rLegMCD, InertiaArm, InertiaBody, InertiaLeg]...
    = Calc_Parameter_AE(mAll, r_Ankle_Toe, r_Knee_Ankle, r_Waist_Knee, r_Shoulder_Waist, r_Elbow_Shoulder, r_Wrist_Elbow, r_Finger_Wrist, r_Ear_Shoulder, r_Top_Ear)
%CALC_PARAMETER_AE この関数の概要をここに記述
%   詳細説明をここに記述

h_Toe = 0;
h_Ankle = h_Toe + r_Ankle_Toe;
h_Knee = h_Ankle + r_Knee_Ankle;
h_Waist = h_Knee + r_Waist_Knee;
h_Shoulder = h_Waist + r_Shoulder_Waist;
h_Elbow = h_Shoulder + r_Elbow_Shoulder;
h_Wrist = h_Elbow + r_Wrist_Elbow;
h_Finger = h_Wrist;
h_Ear = h_Shoulder + r_Ear_Shoulder;
h_Top = h_Ear + r_Top_Ear;

% ScatVec = [h_Toe, h_Ankle, h_Knee, h_Waist, h_Shoulder, h_Elbow, h_Wrist, h_Finger];
% scatter(zeros(size(ScatVec)), ScatVec)


m_Ankle_Toe = mAll *  2 * 1.1/100;
m_Knee_Ankle = mAll *  2 * 5.1/100;
m_Waist_Knee = mAll *  2 * 11/100;
m_Shoulder_Waist = mAll *  48.9/100;
m_Elbow_Shoulder = mAll *  2 * 2.7/100;
m_Wrist_Elbow = mAll *  2 * 1.6/100;
m_Finger_Wrist = mAll * 2 * 0.6/100;
m_Top_Shoulder = mAll *  6.9/100;

hG_Ankle_Toe = h_Toe + (h_Ankle - h_Toe) * 59.5/100;
hG_Knee_Ankle = h_Knee + (h_Ankle - h_Knee) * 40.6/100;
hG_Waist_Knee = h_Waist + (h_Knee - h_Waist) * 47.5/100;
hG_Shoulder_Waist = h_Shoulder + (h_Waist - h_Shoulder) * 49.3/100;
hG_Elbow_Shoulder = h_Shoulder + (h_Elbow - h_Shoulder) * 52.9/100;
hG_Wrist_Elbow = h_Elbow + (h_Wrist - h_Elbow) * 41.5/100;
hG_Finger_Wrist = h_Wrist + (h_Finger - h_Wrist) * 41.5/100;
hG_Top_Shoulder = h_Top + (h_Ear - h_Top) * 82.1/100;

% hold on
% ScatVec = [hG_Ankle_Toe, hG_Knee_Ankle, hG_Waist_Knee, hG_Shoulder_Waist, hG_Elbow_Shoulder, hG_Wrist_Elbow, hG_Finger_Wrist];
% scatter(zeros(size(ScatVec)), ScatVec)
% hold off

Inertia_Ankle_Toe = m_Ankle_Toe * (r_Ankle_Toe * 20.4/100)^2;
Inertia_Knee_Ankle = m_Knee_Ankle * (r_Knee_Ankle * 27.4/100)^2;
Inertia_Waist_Knee = m_Waist_Knee * (r_Waist_Knee * 27.8/100)^2;
Inertia_Shoulder_Waist = m_Shoulder_Waist * (r_Shoulder_Waist * 34.6/100)^2;
Inertia_Elbow_Shoulder = m_Elbow_Shoulder * (r_Elbow_Shoulder * 26.2/100)^2;
Inertia_Wrist_Elbow = m_Wrist_Elbow * (r_Wrist_Elbow * 27.9/100)^2;
Inertia_Finger_Wrist = m_Finger_Wrist * (r_Finger_Wrist * 51.9/100)^2;
Inertia_Top_Shoulder = m_Top_Shoulder * (r_Top_Ear * 47.9/100)^2;


mArm = m_Elbow_Shoulder + m_Wrist_Elbow + m_Finger_Wrist;
mBody = m_Shoulder_Waist + m_Top_Shoulder;
mLeg = m_Ankle_Toe + m_Knee_Ankle + m_Waist_Knee;

rArm = h_Finger - h_Shoulder;
rBody = h_Shoulder - h_Waist;
rLeg = h_Waist - h_Toe;

hG_Arm = (m_Elbow_Shoulder * hG_Elbow_Shoulder + m_Wrist_Elbow * hG_Wrist_Elbow + m_Finger_Wrist * hG_Finger_Wrist) / mArm;
hG_Body = (m_Shoulder_Waist * hG_Shoulder_Waist + m_Top_Shoulder * hG_Top_Shoulder) / mBody;
hG_Leg = (m_Ankle_Toe * hG_Ankle_Toe + m_Knee_Ankle * hG_Knee_Ankle + m_Waist_Knee * hG_Waist_Knee) / mLeg;

rArmMCD = hG_Arm - h_Shoulder;
rBodyMCD = h_Shoulder - hG_Body;
rLegMCD = h_Waist - hG_Leg;

if rArmMCD <= 0
    error('rArmMCD は正であるはずです')
end
if rBodyMCD <= 0
    error('rBodyMCD は正であるはずです')
end
if rLegMCD <= 0
    error('rLegMCD は正であるはずです')
end

InertiaArm = Inertia_Elbow_Shoulder + Inertia_Wrist_Elbow + Inertia_Finger_Wrist...
    + m_Elbow_Shoulder * (hG_Elbow_Shoulder - hG_Arm)^2 ...
    + m_Wrist_Elbow * (hG_Wrist_Elbow - hG_Arm)^2 ...
    + m_Finger_Wrist * (hG_Finger_Wrist - hG_Arm)^2 ...
    ;
InertiaBody = Inertia_Shoulder_Waist + Inertia_Top_Shoulder...
    + m_Shoulder_Waist * (hG_Shoulder_Waist - hG_Body)^2 ...
    + m_Top_Shoulder * (hG_Top_Shoulder - hG_Body)^2 ...
    ;
InertiaLeg = Inertia_Ankle_Toe + Inertia_Knee_Ankle + Inertia_Waist_Knee...
    + m_Ankle_Toe * (hG_Ankle_Toe - hG_Leg)^2 ...
    + m_Knee_Ankle * (hG_Knee_Ankle - hG_Leg)^2 ...
    + m_Waist_Knee * (hG_Waist_Knee - hG_Leg)^2 ...
    ;



end

