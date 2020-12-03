function KE = find_KE(InertiaLeg,InertiaArm,InertiaBody,dthHand,dthWaist,dthShoulder,dxHand,dyHand,g,kPB,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist,yHand)
%FIND_KE
%    KE = FIND_KE(T,INERTIALEG,INERTIAARM,INERTIABODY,DTHHAND,DTHWAIST,DTHSHOULDER,DXHAND,DYHAND,G,KPB,MARM,MBODY,MLEG,MPB,RARM,RARMMCD,RBODY,RBODYMCD,RLEGMCD,THHAND,THSHOULDER,THWAIST,YHAND)

%    This function was generated by the Symbolic Math Toolbox version 8.5.
%    25-May-2020 19:55:46

t2 = cos(thHand);
t3 = sin(thHand);
t4 = dthHand+dthShoulder;
t5 = thHand+thShoulder;
t10 = -dxHand;
t11 = -dyHand;
t14 = pi./2.0;
t6 = dthWaist+t4;
t7 = cos(t5);
t8 = sin(t5);
t9 = t5+thWaist;
t12 = dthHand.*rArm.*t2;
t13 = dthHand.*rArm.*t3;
t15 = t14+thHand;
t17 = t5+t14;
t16 = sin(t15);
t18 = sin(t17);
t19 = rArm.*t16;
KE = (mLeg.*((t10+t12+rLegMCD.*t6.*cos(t9)+rBody.*t4.*t7).^2+(t11+t13+rLegMCD.*t6.*sin(t9)+rBody.*t4.*t8).^2))./2.0+(InertiaArm.*dthHand.^2)./2.0+(InertiaLeg.*t6.^2)./2.0+(InertiaBody.*t4.^2)./2.0+(kPB.*yHand.^2)./2.0+(mPB.*(dxHand.^2+dyHand.^2))./2.0+(mArm.*((dxHand-dthHand.*rArmMCD.*t2).^2+(dyHand-dthHand.*rArmMCD.*t3).^2))./2.0+(mBody.*((t10+t12+rBodyMCD.*t4.*t7).^2+(t11+t13+rBodyMCD.*t4.*t8).^2))./2.0+g.*mArm.*(yHand+rArmMCD.*t16)+g.*mLeg.*(t19+yHand+rBody.*t18+rLegMCD.*sin(t9+t14))+g.*mPB.*yHand+g.*mBody.*(t19+yHand+rBodyMCD.*t18);
