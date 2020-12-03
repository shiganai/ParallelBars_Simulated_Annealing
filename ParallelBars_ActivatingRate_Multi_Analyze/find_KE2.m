function KE2 = find_KE2(InertiaLeg,InertiaArm,InertiaBody,dthHand,dthWaist,dthShoulder,dxHand,dyHand,g,kPB,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist,yHand)
%FIND_KE2
%    KE2 = FIND_KE2(INERTIALEG,INERTIAARM,INERTIABODY,DTHHAND,DTHWAIST,DTHSHOULDER,DXHAND,DYHAND,G,KPB,MARM,MBODY,MLEG,MPB,RARM,RARMMCD,RBODY,RBODYMCD,RLEGMCD,THHAND,THSHOULDER,THWAIST,YHAND)

%    This function was generated by the Symbolic Math Toolbox version 8.5.
%    23-Nov-2020 14:58:10

t2 = dthHand+dthShoulder;
t4 = -dxHand;
t5 = pi./2.0;
t3 = dthWaist+t2;
t6 = t5+thHand;
t7 = cos(t6);
t8 = sin(t6);
t9 = t6+thShoulder;
t10 = cos(t9);
t11 = sin(t9);
t12 = t9+thWaist;
t13 = rArm.*t8;
t15 = dthHand.*rArm.*t7;
t14 = sin(t12);
t16 = dthHand.*t13;
KE2 = (InertiaArm.*dthHand.^2)./2.0+(InertiaLeg.*t3.^2)./2.0+(InertiaBody.*t2.^2)./2.0+(kPB.*yHand.^2)./2.0+(mPB.*(dxHand.^2+dyHand.^2))./2.0+(mLeg.*((t4+t16+rBody.*t2.*t11+rLegMCD.*t3.*t14).^2+(dyHand+t15+rLegMCD.*t3.*cos(t12)+rBody.*t2.*t10).^2))./2.0+(mArm.*((dxHand-dthHand.*rArmMCD.*t8).^2+(dyHand+dthHand.*rArmMCD.*t7).^2))./2.0+(mBody.*((dyHand+t15+rBodyMCD.*t2.*t10).^2+(t4+t16+rBodyMCD.*t2.*t11).^2))./2.0+g.*mLeg.*(t13+yHand+rBody.*t11+rLegMCD.*t14)+g.*mArm.*(yHand+rArmMCD.*t8)+g.*mPB.*yHand+g.*mBody.*(t13+yHand+rBodyMCD.*t11);
