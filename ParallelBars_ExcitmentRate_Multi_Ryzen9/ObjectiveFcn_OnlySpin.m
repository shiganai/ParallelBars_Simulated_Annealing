function ObjectiveValueData = ObjectiveFcn_OnlySpin(time, q, constants, Spin_num_Goal, breakNum, ActivatingRate_index, Data_Set_Time)

%{
if size(thWaist_AtBodyUpStraight_Range, 2) ~= 2
    error('thWaist_AtBodyUpStraight_Range は １ 行 2 列出なければならない')
elseif size(thWaist_AtBodyUpStraight_Range, 1) ~= 1
    error('thWaist_AtBodyUpStraight_Range は １ 行 2 列出なければならない')
elseif thWaist_AtBodyUpStraight_Range(1,1) > thWaist_AtBodyUpStraight_Range(1,2)
    error('thWaist_AtBodyUpStraight_Range は単調増加なくてはならない')
end
%}

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
    
    ddrPB = fnval(fnder(spline(time, drPB)), time);
    ddthHand = fnval(fnder(spline(time, dthHand)), time);
    ddthShoulder = fnval(fnder(spline(time, dthShoulder)), time);
    ddthWaist = fnval(fnder(spline(time, dthWaist)), time);
    
%     MrPB = find_MrPB(ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,kPB,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,rPB,thHand,thShoulder,thWaist);
    MthHand = find_MthHand(InertiaLeg,InertiaArm,InertiaBody,ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
    MthShoulder = find_MthShoulder(InertiaLeg,InertiaBody,ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,mBody,mLeg,rArm,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
    MthWaist = find_MthWaist(InertiaLeg,ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthShoulder,g,mLeg,rArm,rBody,rLegMCD,thHand,thShoulder,thWaist);
    
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
    
    Step_Data_Set_Time = diff(Data_Set_Time(1:2));
    
    ActivatingRateSwitchValue = EvaluateValue(2, 2, sum(diff(ActivatingRate_index).^2, 'all') * Step_Data_Set_Time);
    
    Step_Time = diff(time(1:2));
    
    Power_thHand = MthHand .* dthHand;
    Power_thHand_Positive = Power_thHand(Power_thHand >= 0);
    Power_thHand_Negative = Power_thHand(Power_thHand < 0);
    Work_thHand = (sum(Power_thHand_Positive) + 0.5 * sum(abs(Power_thHand_Negative)) + sum(abs(MthHand))) * Step_Time;
    
    Power_thShoulder = MthShoulder .* dthShoulder;
    Power_thShoulder_Positive = Power_thShoulder(Power_thShoulder >= 0);
    Power_thShoulder_Negative = Power_thShoulder(Power_thShoulder < 0);
    Work_thShoulder = (sum(Power_thShoulder_Positive) + 0.5 * sum(abs(Power_thShoulder_Negative)) + sum(abs(MthShoulder))) * Step_Time;
    
    Power_thWaist = MthWaist .* dthWaist;
    Power_thWaist_Positive = Power_thWaist(Power_thWaist >= 0);
    Power_thWaist_Negative = Power_thWaist(Power_thWaist < 0);
    Work_thWaist = (sum(Power_thWaist_Positive) + 0.5 * sum(abs(Power_thWaist_Negative)) + sum(abs(MthWaist))) * Step_Time;
    
    Work_thValue = EvaluateValue(600, 600, Work_thHand + Work_thShoulder + Work_thWaist);
    
    spinValue = spinValue * 1e2;
    ActivatingRateSwitchValue = ActivatingRateSwitchValue * 0e0;
    Work_thValue = Work_thValue * 0e1;
    
    ObjectiveValue = spinValue + ActivatingRateSwitchValue + Work_thValue;
    thWaist_AtBodyUpStraight_Value = NaN;
    
    %{
    time_AtBodyUpStraight = interp1(thHand+1/2*pi + thShoulder, time, 3/2*pi);
    thWaist_AtBodyUpStraight = interp1(time, thWaist, time_AtBodyUpStraight);
    
    if ~isnan(thWaist_AtBodyUpStraight)
        if thWaist_AtBodyUpStraight <= thWaist_AtBodyUpStraight_Range(1,1)
            thWaist_AtBodyUpStraight_Value = -EvaluateValue(thWaist_AtBodyUpStraight_Range(1,1),...
                abs(-60/180*pi - thWaist_AtBodyUpStraight_Range(1,1)),...
                thWaist_AtBodyUpStraight) * 2 + 1;
        elseif thWaist_AtBodyUpStraight >= thWaist_AtBodyUpStraight_Range(1,2)
            thWaist_AtBodyUpStraight_Value = EvaluateValue(thWaist_AtBodyUpStraight_Range(1,2),...
                abs(100/180*pi - thWaist_AtBodyUpStraight_Range(1,2)),...
                thWaist_AtBodyUpStraight) * 2 - 1;
        else
            thWaist_AtBodyUpStraight_Value = 0;
        end
    else
        thWaist_AtBodyUpStraight_Value = 1;
    end
    
    if isempty(thWaist_AtBodyUpStraight_Value)
        thWaist_AtBodyUpStraight_Value = 1;
    end
    
    thWaist_AtBodyUpStraight_Value = thWaist_AtBodyUpStraight_Value * 100;
    
    ObjectiveValue = ObjectiveValue + thWaist_AtBodyUpStraight_Value;
    %}
    
elseif ~isempty(find((2:4) == breakNum, 1))
    
    ObjectiveValue = (-EvaluateValue(pi, pi, thShoulder(end)) + 1) * 1e2 + 100;
    
    spinValue = NaN;
%     dthSwitchValue = NaN;
    Work_thValue = NaN;
    thWaist_AtBodyUpStraight_Value = NaN;
    
    dthHand_WithoutZero = dthHand(dthHand ~= 0);
    dthShoulder_WithoutZero = dthShoulder(dthShoulder ~= 0);
    dthWaist_WithoutZero = dthWaist(dthWaist ~= 0);
    dthSwitchNum = length(find(dthHand_WithoutZero(1:end-1).*dthHand_WithoutZero(2:end)<0))...
        + length(find(dthShoulder_WithoutZero(1:end-1).*dthShoulder_WithoutZero(2:end)<0))...
        + length(find(dthWaist_WithoutZero(1:end-1).*dthWaist_WithoutZero(2:end)<0));
    ActivatingRateSwitchValue = NaN;
%     if dthSwitchNum <= 3
%         dthSwitchValue = 0;
%     else
%         dthSwitchValue = EvaluateValue(3, 27, dthSwitchNum) * 2 - 1;
%     end
else
    ObjectiveValue = NaN;
    spinValue = NaN;
%     dthSwitchValue = NaN;
    Work_thValue = NaN;
    thWaist_AtBodyUpStraight_Value = NaN;
    
    
    dthHand_WithoutZero = dthHand(dthHand ~= 0);
    dthShoulder_WithoutZero = dthShoulder(dthShoulder ~= 0);
    dthWaist_WithoutZero = dthWaist(dthWaist ~= 0);
    dthSwitchNum = length(find(dthHand_WithoutZero(1:end-1).*dthHand_WithoutZero(2:end)<0))...
        + length(find(dthShoulder_WithoutZero(1:end-1).*dthShoulder_WithoutZero(2:end)<0))...
        + length(find(dthWaist_WithoutZero(1:end-1).*dthWaist_WithoutZero(2:end)<0));
    
    if dthSwitchNum <= 3
        ActivatingRateSwitchValue = 0;
    else
        ActivatingRateSwitchValue = EvaluateValue(3, 27, dthSwitchNum) * 2 - 1;
    end
end

ObjectiveValueData = [ObjectiveValue, spinValue, ActivatingRateSwitchValue, Work_thValue, dthSwitchNum, thWaist_AtBodyUpStraight_Value];

end

































