function dotq = ddt_Ddt0(t, q, constants, ActivatingRate_spline, ActivatingRate, Data_Set_Time)
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

Step_Time = diff(Data_Set_Time(1:2));
    
thHand_degree = rad2deg(thHand);
thShoulder_degree = rad2deg(thShoulder);
thWaist_degree = rad2deg(thWaist);
dthHand_degree = rad2deg(dthHand);
dthShoulder_degree = rad2deg(dthShoulder);
dthWaist_degree = rad2deg(dthWaist);

thHand_degree_VT = thHand_degree;
thHand_degree_VT(thHand_degree < Hand_Para.theta_PE_1_Ext) = Hand_Para.theta_PE_1_Ext;
thHand_degree_VT(thHand_degree > Hand_Para.theta_PE_1_Flex) = Hand_Para.theta_PE_1_Flex;

MthHand_MaxTorque = VoluntaryTorque(Hand_Para, thHand_degree_VT, dthHand_degree, 1) * 2;
MthHand_MinTorque = VoluntaryTorque(Hand_Para, thHand_degree_VT, dthHand_degree, -1) * 2;
MthShoulder_MaxTorque = VoluntaryTorque(Shoulder_Para, thShoulder_degree, dthShoulder_degree, 1) * 2;
MthShoulder_MinTorque = VoluntaryTorque(Shoulder_Para, thShoulder_degree, dthShoulder_degree, -1) * 2;
MthWaist_MaxTorque = VoluntaryTorque(Waist_Para, thWaist_degree, dthWaist_degree, 1) * 2;
MthWaist_MinTorque = VoluntaryTorque(Waist_Para, thWaist_degree, dthWaist_degree, -1) * 2;

Target_Index = find(Data_Set_Time > t, 1) - 1;
if t >= Data_Set_Time(end)
    Target_Index = size(Data_Set_Time, 1);
end

MrPB = -cPB*drPB;

if t - Data_Set_Time(Target_Index) <= 0.99 * Step_Time % 固定値
    MthHand_ActivatingRate = ActivatingRate(Target_Index, 1);
    MthShoulder_ActivatingRate = ActivatingRate(Target_Index, 2);
    MthWaist_ActivatingRate = ActivatingRate(Target_Index, 3);
    
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
    
    [MthHand_ddt0,MthShoulder_ddt0,MthWaist_ddt0] = find_MthHand_MthShoulder_MthWaist(InertiaLeg,InertiaArm,InertiaBody,MrPB,0,0,0,dthHand,dthWaist,dthShoulder,g,kPB,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,rPB,thHand,thShoulder,thWaist);
    
    if MthHand_ActivatingRate > 0
        MthHand = MthHand_ddt0 + MthHand_ActivatingRate * (MthHand_MaxTorque -  MthHand_ddt0);
    else
        MthHand = MthHand_ddt0 - abs(MthHand_ActivatingRate) * (MthHand_ddt0 - MthHand_MinTorque);
    end
    if MthShoulder_ActivatingRate > 0
        MthShoulder = MthShoulder_ddt0 + MthShoulder_ActivatingRate * (MthShoulder_MaxTorque -  MthShoulder_ddt0);
    else
        MthShoulder = MthShoulder_ddt0 - abs(MthShoulder_ActivatingRate) * (MthShoulder_ddt0 - MthShoulder_MinTorque);
    end
    if MthWaist_ActivatingRate > 0
        MthWaist = MthWaist_ddt0 + MthWaist_ActivatingRate * (MthWaist_MaxTorque -  MthWaist_ddt0);
    else
        MthWaist = MthWaist_ddt0 - abs(MthWaist_ActivatingRate) * (MthWaist_ddt0 - MthWaist_MinTorque);
    end
    
    if isequal([MthHand_ActivatingRate == 0, MthShoulder_ActivatingRate == 0, MthWaist_ActivatingRate == 0], [1, 1, 1])
        ddthHand = 0;
        ddthShoulder = 0;
        ddthWaist = 0;
        [ddrPB,MthHand,MthShoulder,MthWaist] = find_ddrPB_MthHand_MthShoulder_MthWaist_ddt0(InertiaLeg,InertiaArm,InertiaBody,MrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,kPB,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,rPB,thHand,thShoulder,thWaist);
        
    elseif isequal([MthHand_ActivatingRate == 0, MthShoulder_ActivatingRate == 0, MthWaist_ActivatingRate == 0], [1, 1, 0])
        ddthHand = 0;
        ddthShoulder = 0;
        [ddrPB,ddthWaist,MthHand,MthShoulder] = find_ddrPB_ddthWaist_MthHand_MthShoulder_ddt0(InertiaLeg,InertiaArm,InertiaBody,MrPB,MthWaist,ddthHand,ddthShoulder,dthHand,dthWaist,dthShoulder,g,kPB,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,rPB,thHand,thShoulder,thWaist);
        
    elseif isequal([MthHand_ActivatingRate == 0, MthShoulder_ActivatingRate == 0, MthWaist_ActivatingRate == 0], [1, 0, 1])
        ddthHand = 0;
        ddthWaist = 0;
        [ddrPB,ddthShoulder,MthHand,MthWaist] = find_ddrPB_ddthShoulder_MthHand_MthWaist_ddt0(InertiaLeg,InertiaArm,InertiaBody,MrPB,MthShoulder,ddthHand,ddthWaist,dthHand,dthWaist,dthShoulder,g,kPB,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,rPB,thHand,thShoulder,thWaist);
        
    elseif isequal([MthHand_ActivatingRate == 0, MthShoulder_ActivatingRate == 0, MthWaist_ActivatingRate == 0], [1, 0, 0])
        ddthHand = 0;
        [ddrPB,ddthShoulder,ddthWaist,MthHand] = find_ddrPB_ddthShoulder_ddthWaist_MthHand_ddt0(InertiaLeg,InertiaArm,InertiaBody,MrPB,MthWaist,MthShoulder,ddthHand,dthHand,dthWaist,dthShoulder,g,kPB,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,rPB,thHand,thShoulder,thWaist);
        
    elseif isequal([MthHand_ActivatingRate == 0, MthShoulder_ActivatingRate == 0, MthWaist_ActivatingRate == 0], [0, 1, 1])
        ddthShoulder = 0;
        ddthWaist = 0;
        [ddrPB,ddthHand,MthShoulder,MthWaist] = find_ddrPB_ddthHand_MthShoulder_MthWaist_ddt0(InertiaLeg,InertiaArm,InertiaBody,MrPB,MthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,kPB,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,rPB,thHand,thShoulder,thWaist);
        
    elseif isequal([MthHand_ActivatingRate == 0, MthShoulder_ActivatingRate == 0, MthWaist_ActivatingRate == 0], [0, 1, 0])
        ddthShoulder = 0;
        [ddrPB,ddthHand,ddthWaist,MthShoulder] = find_ddrPB_ddthHand_ddthWaist_MthShoulder_ddt0(InertiaLeg,InertiaArm,InertiaBody,MrPB,MthHand,MthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,kPB,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,rPB,thHand,thShoulder,thWaist);
        
    elseif isequal([MthHand_ActivatingRate == 0, MthShoulder_ActivatingRate == 0, MthWaist_ActivatingRate == 0], [0, 0, 1])
        ddthWaist = 0;
        [ddrPB,ddthHand,ddthShoulder,MthWaist] = find_ddrPB_ddthHand_ddthShoulder_MthWaist_ddt0(InertiaLeg,InertiaArm,InertiaBody,MrPB,MthHand,MthShoulder,ddthWaist,dthHand,dthWaist,dthShoulder,g,kPB,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,rPB,thHand,thShoulder,thWaist);
        
    else
        [ddrPB,ddthHand,ddthShoulder,ddthWaist] = find_ddrPB_ddthHand_ddthShoulder_ddthWaist(InertiaLeg,InertiaArm,InertiaBody,MrPB,MthHand,MthWaist,MthShoulder,dthHand,dthWaist,dthShoulder,g,kPB,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,rPB,thHand,thShoulder,thWaist);
        
    end
    
    If_Mth_Changed = false;
    
    if MthHand > MthHand_MaxTorque
        MthHand = MthHand_MaxTorque;
        If_Mth_Changed = true;
    elseif MthHand < MthHand_MinTorque
        MthHand = MthHand_MinTorque;
        If_Mth_Changed = true;
    end
    if MthShoulder > MthShoulder_MaxTorque
        MthShoulder = MthShoulder_MaxTorque;
        If_Mth_Changed = true;
    elseif MthShoulder < MthShoulder_MinTorque
        MthShoulder = MthShoulder_MinTorque;
        If_Mth_Changed = true;
    end
    if MthWaist > MthWaist_MaxTorque
        MthWaist = MthWaist_MaxTorque;
        If_Mth_Changed = true;
    elseif MthWaist < MthWaist_MinTorque
        MthWaist = MthWaist_MinTorque;
        If_Mth_Changed = true;
    end
    
    if If_Mth_Changed
        [ddrPB,ddthHand,ddthShoulder,ddthWaist] = find_ddrPB_ddthHand_ddthShoulder_ddthWaist(InertiaLeg,InertiaArm,InertiaBody,MrPB,MthHand,MthWaist,MthShoulder,dthHand,dthWaist,dthShoulder,g,kPB,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,rPB,thHand,thShoulder,thWaist);
    end
    
else %推移値
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
    
    [MthHand_ddt0,MthShoulder_ddt0,MthWaist_ddt0] = find_MthHand_MthShoulder_MthWaist(InertiaLeg,InertiaArm,InertiaBody,MrPB,0,0,0,dthHand,dthWaist,dthShoulder,g,kPB,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,rPB,thHand,thShoulder,thWaist);
    
    if MthHand_ddt0 > MthHand_MaxTorque
        MthHand_ddt0 = MthHand_MaxTorque;
    elseif MthHand_ddt0 < MthHand_MinTorque
        MthHand_ddt0 = MthHand_MinTorque;
    end
    if MthShoulder_ddt0 > MthShoulder_MaxTorque
        MthShoulder_ddt0 = MthShoulder_MaxTorque;
    elseif MthShoulder_ddt0 < MthShoulder_MinTorque
        MthShoulder_ddt0 = MthShoulder_MinTorque;
    end
    if MthWaist_ddt0 > MthWaist_MaxTorque
        MthWaist_ddt0 = MthWaist_MaxTorque;
    elseif MthWaist_ddt0 < MthWaist_MinTorque
        MthWaist_ddt0 = MthWaist_MinTorque;
    end
    
    if MthHand_ActivatingRate > 0
        MthHand = MthHand_ddt0 + MthHand_ActivatingRate * (MthHand_MaxTorque -  MthHand_ddt0);
    else
        MthHand = MthHand_ddt0 - abs(MthHand_ActivatingRate) * (MthHand_ddt0 - MthHand_MinTorque);
    end
    if MthShoulder_ActivatingRate > 0
        MthShoulder = MthShoulder_ddt0 + MthShoulder_ActivatingRate * (MthShoulder_MaxTorque -  MthShoulder_ddt0);
    else
        MthShoulder = MthShoulder_ddt0 - abs(MthShoulder_ActivatingRate) * (MthShoulder_ddt0 - MthShoulder_MinTorque);
    end
    if MthWaist_ActivatingRate > 0
        MthWaist = MthWaist_ddt0 + MthWaist_ActivatingRate * (MthWaist_MaxTorque -  MthWaist_ddt0);
    else
        MthWaist = MthWaist_ddt0 - abs(MthWaist_ActivatingRate) * (MthWaist_ddt0 - MthWaist_MinTorque);
    end
    
    [ddrPB,ddthHand,ddthShoulder,ddthWaist] = find_ddrPB_ddthHand_ddthShoulder_ddthWaist(InertiaLeg,InertiaArm,InertiaBody,MrPB,MthHand,MthWaist,MthShoulder,dthHand,dthWaist,dthShoulder,g,kPB,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,rPB,thHand,thShoulder,thWaist);
    
end

dotq = [drPB, dthHand, dthShoulder, dthWaist, ddrPB, ddthHand, ddthShoulder, ddthWaist]';

end
































