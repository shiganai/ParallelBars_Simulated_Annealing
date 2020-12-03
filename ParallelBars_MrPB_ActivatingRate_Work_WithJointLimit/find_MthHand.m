function MthHand = find_MthHand(InertiaLeg,InertiaArm,InertiaBody,ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist)
%FIND_MTHHAND
%    MTHHAND = FIND_MTHHAND(INERTIALEG,INERTIAARM,INERTIABODY,DDRPB,DDTHHAND,DDTHWAIST,DDTHSHOULDER,DTHHAND,DTHWAIST,DTHSHOULDER,G,MARM,MBODY,MLEG,RARM,RARMMCD,RBODY,RBODYMCD,RLEGMCD,THHAND,THSHOULDER,THWAIST)

%    This function was generated by the Symbolic Math Toolbox version 8.5.
%    19-Jul-2020 21:35:33

t2 = dthWaist.^2;
t3 = dthShoulder.^2;
t4 = rArm.^2;
t5 = rArmMCD.^2;
t6 = rBody.^2;
t7 = rBodyMCD.^2;
t8 = rLegMCD.^2;
t9 = pi./2.0;
t10 = t9+thHand;
t11 = cos(t10);
t12 = sin(t10);
t13 = t10+thShoulder;
t14 = cos(t13);
t15 = sin(t13);
t16 = t13+thWaist;
t17 = t11.^2;
t18 = t12.^2;
t19 = cos(t16);
t20 = sin(t16);
t21 = t14.^2;
t22 = t15.^2;
t23 = t19.^2;
t24 = t20.^2;
MthHand = InertiaLeg.*ddthHand+InertiaArm.*ddthHand+InertiaBody.*ddthHand+InertiaLeg.*ddthWaist+InertiaLeg.*ddthShoulder+InertiaBody.*ddthShoulder+ddrPB.*mArm.*rArmMCD.*t11+ddrPB.*mBody.*rArm.*t11+ddrPB.*mBody.*rBodyMCD.*t14+ddrPB.*mLeg.*rArm.*t11+ddrPB.*mLeg.*rBody.*t14+ddrPB.*mLeg.*rLegMCD.*t19+ddthHand.*mArm.*t5.*t17+ddthHand.*mArm.*t5.*t18+ddthHand.*mBody.*t4.*t17+ddthHand.*mBody.*t4.*t18+ddthHand.*mBody.*t7.*t21+ddthHand.*mBody.*t7.*t22+ddthShoulder.*mBody.*t7.*t21+ddthShoulder.*mBody.*t7.*t22+ddthHand.*mLeg.*t4.*t17+ddthHand.*mLeg.*t4.*t18+ddthHand.*mLeg.*t6.*t21+ddthHand.*mLeg.*t6.*t22+ddthHand.*mLeg.*t8.*t23+ddthHand.*mLeg.*t8.*t24+ddthWaist.*mLeg.*t8.*t23+ddthWaist.*mLeg.*t8.*t24+ddthShoulder.*mLeg.*t6.*t21+ddthShoulder.*mLeg.*t6.*t22+ddthShoulder.*mLeg.*t8.*t23+ddthShoulder.*mLeg.*t8.*t24+g.*mArm.*rArmMCD.*t11+g.*mBody.*rArm.*t11+g.*mBody.*rBodyMCD.*t14+g.*mLeg.*rArm.*t11+g.*mLeg.*rBody.*t14+g.*mLeg.*rLegMCD.*t19-mBody.*rArm.*rBodyMCD.*t3.*t11.*t15+mBody.*rArm.*rBodyMCD.*t3.*t12.*t14-mLeg.*rArm.*rBody.*t3.*t11.*t15+mLeg.*rArm.*rBody.*t3.*t12.*t14-mLeg.*rArm.*rLegMCD.*t2.*t11.*t20+mLeg.*rArm.*rLegMCD.*t2.*t12.*t19-mLeg.*rArm.*rLegMCD.*t3.*t11.*t20+mLeg.*rArm.*rLegMCD.*t3.*t12.*t19-mLeg.*rBody.*rLegMCD.*t2.*t14.*t20+mLeg.*rBody.*rLegMCD.*t2.*t15.*t19+ddthHand.*mBody.*rArm.*rBodyMCD.*t11.*t14.*2.0+ddthHand.*mBody.*rArm.*rBodyMCD.*t12.*t15.*2.0+ddthShoulder.*mBody.*rArm.*rBodyMCD.*t11.*t14+ddthShoulder.*mBody.*rArm.*rBodyMCD.*t12.*t15+ddthHand.*mLeg.*rArm.*rBody.*t11.*t14.*2.0+ddthHand.*mLeg.*rArm.*rBody.*t12.*t15.*2.0+ddthShoulder.*mLeg.*rArm.*rBody.*t11.*t14+ddthShoulder.*mLeg.*rArm.*rBody.*t12.*t15+ddthHand.*mLeg.*rArm.*rLegMCD.*t11.*t19.*2.0+ddthHand.*mLeg.*rArm.*rLegMCD.*t12.*t20.*2.0+ddthWaist.*mLeg.*rArm.*rLegMCD.*t11.*t19+ddthWaist.*mLeg.*rArm.*rLegMCD.*t12.*t20+ddthShoulder.*mLeg.*rArm.*rLegMCD.*t11.*t19+ddthShoulder.*mLeg.*rArm.*rLegMCD.*t12.*t20+ddthHand.*mLeg.*rBody.*rLegMCD.*t14.*t19.*2.0+ddthHand.*mLeg.*rBody.*rLegMCD.*t15.*t20.*2.0+ddthWaist.*mLeg.*rBody.*rLegMCD.*t14.*t19+ddthWaist.*mLeg.*rBody.*rLegMCD.*t15.*t20+ddthShoulder.*mLeg.*rBody.*rLegMCD.*t14.*t19.*2.0+ddthShoulder.*mLeg.*rBody.*rLegMCD.*t15.*t20.*2.0-dthHand.*dthShoulder.*mBody.*rArm.*rBodyMCD.*t11.*t15.*2.0+dthHand.*dthShoulder.*mBody.*rArm.*rBodyMCD.*t12.*t14.*2.0-dthHand.*dthShoulder.*mLeg.*rArm.*rBody.*t11.*t15.*2.0+dthHand.*dthShoulder.*mLeg.*rArm.*rBody.*t12.*t14.*2.0-dthHand.*dthWaist.*mLeg.*rArm.*rLegMCD.*t11.*t20.*2.0+dthHand.*dthWaist.*mLeg.*rArm.*rLegMCD.*t12.*t19.*2.0-dthHand.*dthShoulder.*mLeg.*rArm.*rLegMCD.*t11.*t20.*2.0+dthHand.*dthShoulder.*mLeg.*rArm.*rLegMCD.*t12.*t19.*2.0-dthWaist.*dthShoulder.*mLeg.*rArm.*rLegMCD.*t11.*t20.*2.0+dthWaist.*dthShoulder.*mLeg.*rArm.*rLegMCD.*t12.*t19.*2.0-dthHand.*dthWaist.*mLeg.*rBody.*rLegMCD.*t14.*t20.*2.0+dthHand.*dthWaist.*mLeg.*rBody.*rLegMCD.*t15.*t19.*2.0-dthWaist.*dthShoulder.*mLeg.*rBody.*rLegMCD.*t14.*t20.*2.0+dthWaist.*dthShoulder.*mLeg.*rBody.*rLegMCD.*t15.*t19.*2.0;
