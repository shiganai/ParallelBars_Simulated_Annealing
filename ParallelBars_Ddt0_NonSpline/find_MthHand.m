function MthHand = find_MthHand(InertiaLeg,InertiaArm,InertiaBody,ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist)
%FIND_MTHHAND
%    MTHHAND = FIND_MTHHAND(INERTIALEG,INERTIAARM,INERTIABODY,DDRPB,DDTHHAND,DDTHWAIST,DDTHSHOULDER,DTHHAND,DTHWAIST,DTHSHOULDER,G,MARM,MBODY,MLEG,RARM,RARMMCD,RBODY,RBODYMCD,RLEGMCD,THHAND,THSHOULDER,THWAIST)

%    This function was generated by the Symbolic Math Toolbox version 8.5.
%    25-May-2020 19:54:03

t2 = cos(thHand);
t3 = sin(thHand);
t4 = thHand+thShoulder;
t5 = dthWaist.^2;
t6 = dthShoulder.^2;
t7 = rArm.^2;
t8 = rBody.^2;
t9 = rBodyMCD.^2;
t10 = rLegMCD.^2;
t18 = pi./2.0;
t11 = t2.^2;
t12 = t3.^2;
t13 = cos(t4);
t14 = sin(t4);
t15 = t4+thWaist;
t22 = t18+thHand;
t25 = t4+t18;
t16 = cos(t15);
t17 = sin(t15);
t19 = t13.^2;
t20 = t14.^2;
t24 = cos(t22);
t26 = cos(t25);
t21 = t16.^2;
t23 = t17.^2;
MthHand = InertiaLeg.*ddthHand+InertiaArm.*ddthHand+InertiaBody.*ddthHand+InertiaLeg.*ddthWaist+InertiaLeg.*ddthShoulder+InertiaBody.*ddthShoulder+ddthHand.*mArm.*rArmMCD.^2-ddrPB.*mArm.*rArmMCD.*t3-ddrPB.*mBody.*rArm.*t3-ddrPB.*mBody.*rBodyMCD.*t14-ddrPB.*mLeg.*rArm.*t3-ddrPB.*mLeg.*rBody.*t14-ddrPB.*mLeg.*rLegMCD.*t17+ddthHand.*mBody.*t7.*t11+ddthHand.*mBody.*t7.*t12+ddthHand.*mBody.*t9.*t19+ddthHand.*mBody.*t9.*t20+ddthShoulder.*mBody.*t9.*t19+ddthShoulder.*mBody.*t9.*t20+ddthHand.*mLeg.*t7.*t11+ddthHand.*mLeg.*t7.*t12+ddthHand.*mLeg.*t8.*t19+ddthHand.*mLeg.*t8.*t20+ddthHand.*mLeg.*t10.*t21+ddthHand.*mLeg.*t10.*t23+ddthWaist.*mLeg.*t10.*t21+ddthWaist.*mLeg.*t10.*t23+ddthShoulder.*mLeg.*t8.*t19+ddthShoulder.*mLeg.*t8.*t20+ddthShoulder.*mLeg.*t10.*t21+ddthShoulder.*mLeg.*t10.*t23+g.*mArm.*rArmMCD.*t24+g.*mBody.*rArm.*t24+g.*mBody.*rBodyMCD.*t26+g.*mLeg.*rArm.*t24+g.*mLeg.*rBody.*t26+g.*mLeg.*rLegMCD.*cos(t15+t18)-mBody.*rArm.*rBodyMCD.*t2.*t6.*t14+mBody.*rArm.*rBodyMCD.*t3.*t6.*t13-mLeg.*rArm.*rBody.*t2.*t6.*t14+mLeg.*rArm.*rBody.*t3.*t6.*t13-mLeg.*rArm.*rLegMCD.*t2.*t5.*t17+mLeg.*rArm.*rLegMCD.*t3.*t5.*t16-mLeg.*rArm.*rLegMCD.*t2.*t6.*t17+mLeg.*rArm.*rLegMCD.*t3.*t6.*t16-mLeg.*rBody.*rLegMCD.*t5.*t13.*t17+mLeg.*rBody.*rLegMCD.*t5.*t14.*t16+ddthHand.*mBody.*rArm.*rBodyMCD.*t2.*t13.*2.0+ddthHand.*mBody.*rArm.*rBodyMCD.*t3.*t14.*2.0+ddthShoulder.*mBody.*rArm.*rBodyMCD.*t2.*t13+ddthShoulder.*mBody.*rArm.*rBodyMCD.*t3.*t14+ddthHand.*mLeg.*rArm.*rBody.*t2.*t13.*2.0+ddthHand.*mLeg.*rArm.*rBody.*t3.*t14.*2.0+ddthShoulder.*mLeg.*rArm.*rBody.*t2.*t13+ddthShoulder.*mLeg.*rArm.*rBody.*t3.*t14+ddthHand.*mLeg.*rArm.*rLegMCD.*t2.*t16.*2.0+ddthHand.*mLeg.*rArm.*rLegMCD.*t3.*t17.*2.0+ddthWaist.*mLeg.*rArm.*rLegMCD.*t2.*t16+ddthWaist.*mLeg.*rArm.*rLegMCD.*t3.*t17+ddthShoulder.*mLeg.*rArm.*rLegMCD.*t2.*t16+ddthShoulder.*mLeg.*rArm.*rLegMCD.*t3.*t17+ddthHand.*mLeg.*rBody.*rLegMCD.*t13.*t16.*2.0+ddthHand.*mLeg.*rBody.*rLegMCD.*t14.*t17.*2.0+ddthWaist.*mLeg.*rBody.*rLegMCD.*t13.*t16+ddthWaist.*mLeg.*rBody.*rLegMCD.*t14.*t17+ddthShoulder.*mLeg.*rBody.*rLegMCD.*t13.*t16.*2.0+ddthShoulder.*mLeg.*rBody.*rLegMCD.*t14.*t17.*2.0-dthHand.*dthShoulder.*mBody.*rArm.*rBodyMCD.*t2.*t14.*2.0+dthHand.*dthShoulder.*mBody.*rArm.*rBodyMCD.*t3.*t13.*2.0-dthHand.*dthShoulder.*mLeg.*rArm.*rBody.*t2.*t14.*2.0+dthHand.*dthShoulder.*mLeg.*rArm.*rBody.*t3.*t13.*2.0-dthHand.*dthWaist.*mLeg.*rArm.*rLegMCD.*t2.*t17.*2.0+dthHand.*dthWaist.*mLeg.*rArm.*rLegMCD.*t3.*t16.*2.0-dthHand.*dthShoulder.*mLeg.*rArm.*rLegMCD.*t2.*t17.*2.0+dthHand.*dthShoulder.*mLeg.*rArm.*rLegMCD.*t3.*t16.*2.0-dthWaist.*dthShoulder.*mLeg.*rArm.*rLegMCD.*t2.*t17.*2.0+dthWaist.*dthShoulder.*mLeg.*rArm.*rLegMCD.*t3.*t16.*2.0-dthHand.*dthWaist.*mLeg.*rBody.*rLegMCD.*t13.*t17.*2.0+dthHand.*dthWaist.*mLeg.*rBody.*rLegMCD.*t14.*t16.*2.0-dthWaist.*dthShoulder.*mLeg.*rBody.*rLegMCD.*t13.*t17.*2.0+dthWaist.*dthShoulder.*mLeg.*rBody.*rLegMCD.*t14.*t16.*2.0;
