function ObjectiveValueData = ObjectiveFcn(time, q, constants, Spin_num_Goal, breakNum, ActivatingRate_ii_spline)

if Spin_num_Goal <= 0
    error("回転数の目標値は正の値でなければならない")
end

rPB = q(:,1);
thHand = q(:,2);
thShoulder = q(:,3);
thWaist = q(:,4);
drPB = q(:,5);
dthHand = q(:,6);
dthShoulder = q(:,7);
dthWaist = q(:,8);

yHand = rPB(:,1);
xHand = zeros(size(yHand));
dyHand = drPB(:,1);
dxHand = zeros(size(dyHand));

if breakNum == 1
    g = constants.g;
%     kPB = constants.kPB;
%     cPB = constants.cPB;
%     mAll = constants.mAll;
%     mPB = constants.mPB;
%     rAll = constants.rAll;
    mArm = constants.mArm;
    mBody = constants.mBody;
    mLeg = constants.mLeg;
    rArm = constants.rArm;
    rBody = constants.rBody;
    rLeg = constants.rLeg;
%     InertiaModel = constants.InertiaModel;
    rArmMCD = constants.rArmMCD;
    rBodyMCD = constants.rBodyMCD;
    rLegMCD = constants.rLegMCD;
    InertiaArm = constants.InertiaArm;
    InertiaBody = constants.InertiaBody;
    InertiaLeg = constants.InertiaLeg;
    InertiaG = constants.InertiaG;
    Hand_Para = constants.Hand_Para;
    Shoulder_Para = constants.Shoulder_Para;
    Waist_Para = constants.Waist_Para;
    
    pG = find_pG(mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist,xHand,yHand);
    vG = find_vG(dthHand,dthWaist,dthShoulder,dxHand,dyHand,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
    momentumG = find_momentumG(InertiaLeg,InertiaArm,InertiaBody,dthHand,dthWaist,dthShoulder,dxHand,dyHand,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist,xHand,yHand);
    
    height = pG(end,2) + vG(end,2)^2/(2*g) + 1.8 - rLeg;
    time_until_landing = vG(end,2)/g + (2*height/g)^0.5; %vG(end,2)がマイナスだった場合でも大丈夫
    omegaG = momentumG(end)/InertiaG;
    spinNum = time_until_landing * omegaG /(2*pi);
    
    spinValue = -EvaluateValue(Spin_num_Goal / 2, Spin_num_Goal / 2, spinNum) + 1;
    
    dthHand_WithoutZero = dthHand(dthHand ~= 0);
    dthShoulder_WithoutZero = dthShoulder(dthShoulder ~= 0);
    dthWaist_WithoutZero = dthWaist(dthWaist ~= 0);
    
    dthSwitchNum = length(find(dthHand_WithoutZero(1:end-1).*dthHand_WithoutZero(2:end)<0))...
        + length(find(dthShoulder_WithoutZero(1:end-1).*dthShoulder_WithoutZero(2:end)<0))...
        + length(find(dthWaist_WithoutZero(1:end-1).*dthWaist_WithoutZero(2:end)<0));
    
    dthSwitchNum_Border = 7;
    if dthSwitchNum <= dthSwitchNum_Border
        dthSwitchValue = EvaluateValue(dthSwitchNum_Border, dthSwitchNum_Border - 3, dthSwitchNum);
    else
        dthSwitchValue = EvaluateValue(dthSwitchNum_Border, 40 - dthSwitchNum_Border, dthSwitchNum);
    end
    
    ddrPB = fnval(fnder(spline(time, drPB)), time);
    ddthHand = fnval(fnder(spline(time, dthHand)), time);
    ddthShoulder = fnval(fnder(spline(time, dthShoulder)), time);
    ddthWaist = fnval(fnder(spline(time, dthWaist)), time);
    
%     MrPB = find_MrPB(ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,kPB,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,rPB,thHand,thShoulder,thWaist);
    MthHand = find_MthHand(InertiaLeg,InertiaArm,InertiaBody,ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
    MthShoulder = find_MthShoulder(InertiaLeg,InertiaBody,ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,mBody,mLeg,rArm,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
    MthWaist = find_MthWaist(InertiaLeg,ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthShoulder,g,mLeg,rArm,rBody,rLegMCD,thHand,thShoulder,thWaist);
    
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
    MthHand_PassiveTorque = VoluntaryTorque(Hand_Para, thHand_degree_VT, dthHand_degree, 0) * 2;
    MthShoulder_MaxTorque = VoluntaryTorque(Shoulder_Para, thShoulder_degree, dthShoulder_degree, 1) * 2;
    MthShoulder_MinTorque = VoluntaryTorque(Shoulder_Para, thShoulder_degree, dthShoulder_degree, -1) * 2;
    MthShoulder_PassiveTorque = VoluntaryTorque(Shoulder_Para, thShoulder_degree, dthShoulder_degree, 0) * 2;
    MthWaist_MaxTorque = VoluntaryTorque(Waist_Para, thWaist_degree, dthWaist_degree, 1) * 2;
    MthWaist_MinTorque = VoluntaryTorque(Waist_Para, thWaist_degree, dthWaist_degree, -1) * 2;
    MthWaist_PassiveTorque = VoluntaryTorque(Waist_Para, thWaist_degree, dthWaist_degree, 0) * 2;
    
    MthHand_ActivatedRate_Ext = (MthHand - MthHand_PassiveTorque) ./ (MthHand_MaxTorque - MthHand_PassiveTorque);
    MthHand_ActivatedRate_Flex = (MthHand_PassiveTorque - MthHand) ./ (MthHand_PassiveTorque - MthHand_MinTorque);
    MthShoulder_ActivatedRate_Ext = (MthShoulder - MthShoulder_PassiveTorque) ./ (MthShoulder_MaxTorque - MthShoulder_PassiveTorque);
    MthShoulder_ActivatedRate_Flex = (MthShoulder_PassiveTorque - MthShoulder) ./ (MthShoulder_PassiveTorque - MthShoulder_MinTorque);
    MthWaist_ActivatedRate_Ext = (MthWaist - MthWaist_PassiveTorque) ./ (MthWaist_MaxTorque - MthWaist_PassiveTorque);
    MthWaist_ActivatedRate_Flex = (MthWaist_PassiveTorque - MthWaist) ./ (MthWaist_PassiveTorque - MthWaist_MinTorque);
    
    MthHand_ActivatedRate = MthHand_ActivatedRate_Ext;
    MthHand_ActivatedRate(MthHand_ActivatedRate < 0) = -MthHand_ActivatedRate_Flex(MthHand_ActivatedRate < 0);
    
    MthShoulder_ActivatedRate = MthShoulder_ActivatedRate_Ext;
    MthShoulder_ActivatedRate(MthShoulder_ActivatedRate < 0) = -MthShoulder_ActivatedRate_Flex(MthShoulder_ActivatedRate < 0);
    
    MthWaist_ActivatedRate = MthWaist_ActivatedRate_Ext;
    MthWaist_ActivatedRate(MthWaist_ActivatedRate < 0) = -MthWaist_ActivatedRate_Flex(MthWaist_ActivatedRate < 0);
    
    MthHand_ActivatingRate_ddt0_spline = ActivatingRate_ii_spline(1,1);
    MthShoulder_ActivatingRate_ddt0_spline = ActivatingRate_ii_spline(2,1);
    MthWaist_ActivatingRate_ddt0_spline = ActivatingRate_ii_spline(3,1);

    ddt0_MthHandActivatedRate = fnval(MthHand_ActivatingRate_ddt0_spline, time);
    ddt0_MthShoulderActivatedRate = fnval(MthShoulder_ActivatingRate_ddt0_spline, time);
    ddt0_MthWaistActivatedRate = fnval(MthWaist_ActivatingRate_ddt0_spline, time);
    
    MthHand_Gap = (abs(ddt0_MthHandActivatedRate) < 0.96) .* (abs(MthHand_ActivatedRate) > 0.96);
    MthShoulder_Gap = (abs(ddt0_MthShoulderActivatedRate) < 0.96) .* (abs(MthShoulder_ActivatedRate) > 0.96);
    MthWaist_Gap = (abs(ddt0_MthWaistActivatedRate) < 0.96) .* (abs(MthWaist_ActivatedRate) > 0.96);
    
    Step_Time = diff(time(1:2));
    
    MthValue = EvaluateValue(0.5, 0.5, (nnz(MthHand_Gap) + nnz(MthShoulder_Gap) + nnz(MthWaist_Gap)) * Step_Time);
    
    spinValue = spinValue * 1e2;
    dthSwitchValue = dthSwitchValue * 1e1;
    MthValue = MthValue * 1e0;
    
    ObjectiveValue = spinValue + dthSwitchValue + MthValue;
    
elseif ~isempty(find((2:4) == breakNum, 1))
    
    ObjectiveValue = (-EvaluateValue(pi, pi, thShoulder(end)) + 1) * 1e2 + 111;
    
    spinValue = NaN;
%     dthSwitchValue = NaN;
    MthValue = NaN;
    
    dthHand_WithoutZero = dthHand(dthHand ~= 0);
    dthShoulder_WithoutZero = dthShoulder(dthShoulder ~= 0);
    dthWaist_WithoutZero = dthWaist(dthWaist ~= 0);
    dthSwitchNum = length(find(dthHand_WithoutZero(1:end-1).*dthHand_WithoutZero(2:end)<0))...
        + length(find(dthShoulder_WithoutZero(1:end-1).*dthShoulder_WithoutZero(2:end)<0))...
        + length(find(dthWaist_WithoutZero(1:end-1).*dthWaist_WithoutZero(2:end)<0));
    dthSwitchValue = NaN;
%     if dthSwitchNum <= 3
%         dthSwitchValue = 0;
%     else
%         dthSwitchValue = EvaluateValue(3, 27, dthSwitchNum) * 2 - 1;
%     end
else
    ObjectiveValue = NaN;
    spinValue = NaN;
%     dthSwitchValue = NaN;
    MthValue = NaN;
    
    
    dthHand_WithoutZero = dthHand(dthHand ~= 0);
    dthShoulder_WithoutZero = dthShoulder(dthShoulder ~= 0);
    dthWaist_WithoutZero = dthWaist(dthWaist ~= 0);
    dthSwitchNum = length(find(dthHand_WithoutZero(1:end-1).*dthHand_WithoutZero(2:end)<0))...
        + length(find(dthShoulder_WithoutZero(1:end-1).*dthShoulder_WithoutZero(2:end)<0))...
        + length(find(dthWaist_WithoutZero(1:end-1).*dthWaist_WithoutZero(2:end)<0));
    
    if dthSwitchNum <= 3
        dthSwitchValue = 0;
    else
        dthSwitchValue = EvaluateValue(3, 27, dthSwitchNum) * 2 - 1;
    end
end

ObjectiveValueData = [ObjectiveValue, spinValue, dthSwitchValue, MthValue, dthSwitchNum];

end

































