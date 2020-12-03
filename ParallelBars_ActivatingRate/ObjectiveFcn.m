function ObjectiveValueData = ObjectiveFcn(time, q, constants, Spin_num_Goal, breakNum)

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
    
    if dthSwitchNum <= 10
        dthSwitchValue = EvaluateValue(10, 7, dthSwitchNum);
    else
        dthSwitchValue = EvaluateValue(10, 30, dthSwitchNum);
    end
    
%     if dthSwitchNum <= 3
%         dthSwitchValue = 0;
%     else
%         dthSwitchValue = EvaluateValue(3, 27, dthSwitchNum) * 2 - 1;
%     end
    
    MthValue = 0;
    
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

































