function dP = find_dP(ddthHand,ddthWaist,ddthShoulder,ddxHand,ddyHand,dthHand,dthWaist,dthShoulder,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist)
%FIND_DP
%    DP = FIND_DP(DDTHHAND,DDTHWAIST,DDTHSHOULDER,DDXHAND,DDYHAND,DTHHAND,DTHWAIST,DTHSHOULDER,MARM,MBODY,MLEG,RARM,RARMMCD,RBODY,RBODYMCD,RLEGMCD,THHAND,THSHOULDER,THWAIST)

%    This function was generated by the Symbolic Math Toolbox version 8.5.
%    18-Sep-2020 18:13:03

t2 = ddthHand+ddthShoulder;
t3 = dthHand+dthShoulder;
t4 = dthHand.^2;
t7 = -ddxHand;
t9 = pi./2.0;
t5 = ddthWaist+t2;
t6 = dthWaist+t3;
t8 = t3.^2;
t11 = t9+thHand;
t10 = t6.^2;
t12 = cos(t11);
t13 = sin(t11);
t14 = t11+thShoulder;
t15 = cos(t14);
t16 = sin(t14);
t17 = t14+thWaist;
t20 = ddthHand.*rArm.*t12;
t21 = ddthHand.*rArm.*t13;
t22 = rArm.*t4.*t12;
t23 = rArm.*t4.*t13;
t18 = cos(t17);
t19 = sin(t17);
t24 = -t23;
dP = [-mArm.*(t7+ddthHand.*rArmMCD.*t13+rArmMCD.*t4.*t12)-mLeg.*(t7+t21+t22+rBody.*t2.*t16+rBody.*t8.*t15+rLegMCD.*t5.*t19+rLegMCD.*t10.*t18)-mBody.*(t7+t21+t22+rBodyMCD.*t2.*t16+rBodyMCD.*t8.*t15),mLeg.*(ddyHand+t20+t24+rBody.*t2.*t15-rBody.*t8.*t16+rLegMCD.*t5.*t18-rLegMCD.*t10.*t19)+mBody.*(ddyHand+t20+t24+rBodyMCD.*t2.*t15-rBodyMCD.*t8.*t16)+mArm.*(ddyHand+ddthHand.*rArmMCD.*t12-rArmMCD.*t4.*t13)];
