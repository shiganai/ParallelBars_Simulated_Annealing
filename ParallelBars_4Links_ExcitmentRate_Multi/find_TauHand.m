function TauHand = find_TauHand(InertiaLeg,InertiaArm,InertiaLBody,InertiaUBody,ddrPB,ddthXip,ddthHand,ddthWaist,ddthShoulder,dthXip,dthHand,dthWaist,dthShoulder,g,mArm,mLBody,mLeg,mUBody,rArm,rArmMCD,rLBody,rLBodyMCD,rLegMCD,rUBody,rUBodyMCD,thHand,thShoulder,thWaist,thXip)
%FIND_TAUHAND
%    TAUHAND = FIND_TAUHAND(INERTIALEG,INERTIAARM,INERTIALBODY,INERTIAUBODY,DDRPB,DDTHXIP,DDTHHAND,DDTHWAIST,DDTHSHOULDER,DTHXIP,DTHHAND,DTHWAIST,DTHSHOULDER,G,MARM,MLBODY,MLEG,MUBODY,RARM,RARMMCD,RLBODY,RLBODYMCD,RLEGMCD,RUBODY,RUBODYMCD,THHAND,THSHOULDER,THWAIST,THXIP)

%    This function was generated by the Symbolic Math Toolbox version 8.5.
%    13-Nov-2020 17:13:19

t2 = dthXip.^2;
t3 = dthWaist.^2;
t4 = dthShoulder.^2;
t5 = rArm.^2;
t6 = rArmMCD.^2;
t7 = rLBody.^2;
t8 = rLBodyMCD.^2;
t9 = rLegMCD.^2;
t10 = rUBody.^2;
t11 = rUBodyMCD.^2;
t12 = pi./2.0;
t13 = t12+thHand;
t14 = cos(t13);
t15 = sin(t13);
t16 = t13+thShoulder;
t17 = cos(t16);
t18 = sin(t16);
t19 = t16+thWaist;
t20 = t16+thXip;
t21 = t14.^2;
t22 = t15.^2;
t23 = cos(t19);
t24 = cos(t20);
t25 = sin(t19);
t26 = sin(t20);
t27 = t17.^2;
t28 = t18.^2;
t29 = t23.^2;
t30 = t24.^2;
t31 = t25.^2;
t32 = t26.^2;
TauHand = InertiaLeg.*ddthXip+InertiaLeg.*ddthHand+InertiaArm.*ddthHand+InertiaLBody.*ddthXip+InertiaLeg.*ddthWaist+InertiaLBody.*ddthHand+InertiaUBody.*ddthHand+InertiaLeg.*ddthShoulder+InertiaLBody.*ddthShoulder+InertiaUBody.*ddthShoulder+ddrPB.*mArm.*rArmMCD.*t14+ddrPB.*mLBody.*rArm.*t14+ddrPB.*mLeg.*rArm.*t14+ddrPB.*mUBody.*rArm.*t14+ddrPB.*mLBody.*rLBodyMCD.*t24+ddrPB.*mLeg.*rLBody.*t24+ddrPB.*mLeg.*rLegMCD.*t23+ddrPB.*mLBody.*rUBody.*t17+ddrPB.*mLeg.*rUBody.*t17+ddrPB.*mUBody.*rUBodyMCD.*t17+ddthHand.*mArm.*t6.*t21+ddthHand.*mArm.*t6.*t22+ddthXip.*mLBody.*t8.*t30+ddthXip.*mLBody.*t8.*t32+ddthHand.*mLBody.*t5.*t21+ddthHand.*mLBody.*t5.*t22+ddthHand.*mLBody.*t10.*t27+ddthHand.*mLBody.*t8.*t30+ddthHand.*mLBody.*t10.*t28+ddthHand.*mLBody.*t8.*t32+ddthShoulder.*mLBody.*t10.*t27+ddthShoulder.*mLBody.*t8.*t30+ddthShoulder.*mLBody.*t10.*t28+ddthShoulder.*mLBody.*t8.*t32+ddthXip.*mLeg.*t7.*t30+ddthXip.*mLeg.*t7.*t32+ddthHand.*mLeg.*t5.*t21+ddthHand.*mLeg.*t5.*t22+ddthHand.*mLeg.*t7.*t30+ddthHand.*mLeg.*t10.*t27+ddthHand.*mLeg.*t9.*t29+ddthHand.*mLeg.*t10.*t28+ddthHand.*mLeg.*t7.*t32+ddthHand.*mLeg.*t9.*t31+ddthWaist.*mLeg.*t9.*t29+ddthWaist.*mLeg.*t9.*t31+ddthShoulder.*mLeg.*t7.*t30+ddthShoulder.*mLeg.*t10.*t27+ddthShoulder.*mLeg.*t9.*t29+ddthShoulder.*mLeg.*t10.*t28+ddthShoulder.*mLeg.*t7.*t32+ddthShoulder.*mLeg.*t9.*t31+ddthHand.*mUBody.*t5.*t21+ddthHand.*mUBody.*t5.*t22+ddthHand.*mUBody.*t11.*t27+ddthHand.*mUBody.*t11.*t28+ddthShoulder.*mUBody.*t11.*t27+ddthShoulder.*mUBody.*t11.*t28+g.*mArm.*rArmMCD.*t14+g.*mLBody.*rArm.*t14+g.*mLeg.*rArm.*t14+g.*mUBody.*rArm.*t14+g.*mLBody.*rLBodyMCD.*t24+g.*mLeg.*rLBody.*t24+g.*mLeg.*rLegMCD.*t23+g.*mLBody.*rUBody.*t17+g.*mLeg.*rUBody.*t17+g.*mUBody.*rUBodyMCD.*t17+mLBody.*rArm.*rLBodyMCD.*t2.*t15.*t24-mLBody.*rArm.*rLBodyMCD.*t2.*t14.*t26+mLBody.*rArm.*rLBodyMCD.*t4.*t15.*t24-mLBody.*rArm.*rLBodyMCD.*t4.*t14.*t26+mLeg.*rArm.*rLBody.*t2.*t15.*t24-mLeg.*rArm.*rLBody.*t2.*t14.*t26+mLeg.*rArm.*rLBody.*t4.*t15.*t24-mLeg.*rArm.*rLBody.*t4.*t14.*t26+mLeg.*rArm.*rLegMCD.*t3.*t15.*t23-mLeg.*rArm.*rLegMCD.*t3.*t14.*t25+mLeg.*rArm.*rLegMCD.*t4.*t15.*t23-mLeg.*rArm.*rLegMCD.*t4.*t14.*t25-mLBody.*rArm.*rUBody.*t4.*t14.*t18+mLBody.*rArm.*rUBody.*t4.*t15.*t17-mLeg.*rArm.*rUBody.*t4.*t14.*t18+mLeg.*rArm.*rUBody.*t4.*t15.*t17-mLeg.*rLBody.*rLegMCD.*t2.*t23.*t26+mLeg.*rLBody.*rLegMCD.*t2.*t24.*t25+mLeg.*rLBody.*rLegMCD.*t3.*t23.*t26-mLeg.*rLBody.*rLegMCD.*t3.*t24.*t25-mUBody.*rArm.*rUBodyMCD.*t4.*t14.*t18+mUBody.*rArm.*rUBodyMCD.*t4.*t15.*t17+mLBody.*rLBodyMCD.*rUBody.*t2.*t18.*t24-mLBody.*rLBodyMCD.*rUBody.*t2.*t17.*t26+mLeg.*rLBody.*rUBody.*t2.*t18.*t24-mLeg.*rLBody.*rUBody.*t2.*t17.*t26+mLeg.*rLegMCD.*rUBody.*t3.*t18.*t23-mLeg.*rLegMCD.*rUBody.*t3.*t17.*t25+ddthXip.*mLBody.*rArm.*rLBodyMCD.*t14.*t24+ddthXip.*mLBody.*rArm.*rLBodyMCD.*t15.*t26+ddthHand.*mLBody.*rArm.*rLBodyMCD.*t14.*t24.*2.0+ddthHand.*mLBody.*rArm.*rLBodyMCD.*t15.*t26.*2.0+ddthShoulder.*mLBody.*rArm.*rLBodyMCD.*t14.*t24+ddthShoulder.*mLBody.*rArm.*rLBodyMCD.*t15.*t26+ddthXip.*mLeg.*rArm.*rLBody.*t14.*t24+ddthXip.*mLeg.*rArm.*rLBody.*t15.*t26+ddthHand.*mLeg.*rArm.*rLBody.*t14.*t24.*2.0+ddthHand.*mLeg.*rArm.*rLBody.*t15.*t26.*2.0+ddthShoulder.*mLeg.*rArm.*rLBody.*t14.*t24+ddthShoulder.*mLeg.*rArm.*rLBody.*t15.*t26+ddthHand.*mLeg.*rArm.*rLegMCD.*t14.*t23.*2.0+ddthHand.*mLeg.*rArm.*rLegMCD.*t15.*t25.*2.0+ddthWaist.*mLeg.*rArm.*rLegMCD.*t14.*t23+ddthWaist.*mLeg.*rArm.*rLegMCD.*t15.*t25+ddthShoulder.*mLeg.*rArm.*rLegMCD.*t14.*t23+ddthShoulder.*mLeg.*rArm.*rLegMCD.*t15.*t25+ddthHand.*mLBody.*rArm.*rUBody.*t14.*t17.*2.0+ddthHand.*mLBody.*rArm.*rUBody.*t15.*t18.*2.0+ddthShoulder.*mLBody.*rArm.*rUBody.*t14.*t17+ddthShoulder.*mLBody.*rArm.*rUBody.*t15.*t18+ddthHand.*mLeg.*rArm.*rUBody.*t14.*t17.*2.0+ddthHand.*mLeg.*rArm.*rUBody.*t15.*t18.*2.0+ddthShoulder.*mLeg.*rArm.*rUBody.*t14.*t17+ddthShoulder.*mLeg.*rArm.*rUBody.*t15.*t18+ddthXip.*mLeg.*rLBody.*rLegMCD.*t23.*t24+ddthXip.*mLeg.*rLBody.*rLegMCD.*t25.*t26+ddthHand.*mLeg.*rLBody.*rLegMCD.*t23.*t24.*2.0+ddthHand.*mLeg.*rLBody.*rLegMCD.*t25.*t26.*2.0+ddthWaist.*mLeg.*rLBody.*rLegMCD.*t23.*t24+ddthWaist.*mLeg.*rLBody.*rLegMCD.*t25.*t26+ddthShoulder.*mLeg.*rLBody.*rLegMCD.*t23.*t24.*2.0+ddthShoulder.*mLeg.*rLBody.*rLegMCD.*t25.*t26.*2.0+ddthHand.*mUBody.*rArm.*rUBodyMCD.*t14.*t17.*2.0+ddthHand.*mUBody.*rArm.*rUBodyMCD.*t15.*t18.*2.0+ddthShoulder.*mUBody.*rArm.*rUBodyMCD.*t14.*t17+ddthShoulder.*mUBody.*rArm.*rUBodyMCD.*t15.*t18+ddthXip.*mLBody.*rLBodyMCD.*rUBody.*t17.*t24+ddthXip.*mLBody.*rLBodyMCD.*rUBody.*t18.*t26+ddthHand.*mLBody.*rLBodyMCD.*rUBody.*t17.*t24.*2.0+ddthHand.*mLBody.*rLBodyMCD.*rUBody.*t18.*t26.*2.0+ddthShoulder.*mLBody.*rLBodyMCD.*rUBody.*t17.*t24.*2.0+ddthShoulder.*mLBody.*rLBodyMCD.*rUBody.*t18.*t26.*2.0+ddthXip.*mLeg.*rLBody.*rUBody.*t17.*t24+ddthXip.*mLeg.*rLBody.*rUBody.*t18.*t26+ddthHand.*mLeg.*rLBody.*rUBody.*t17.*t24.*2.0+ddthHand.*mLeg.*rLBody.*rUBody.*t18.*t26.*2.0+ddthShoulder.*mLeg.*rLBody.*rUBody.*t17.*t24.*2.0+ddthShoulder.*mLeg.*rLBody.*rUBody.*t18.*t26.*2.0+ddthHand.*mLeg.*rLegMCD.*rUBody.*t17.*t23.*2.0+ddthHand.*mLeg.*rLegMCD.*rUBody.*t18.*t25.*2.0+ddthWaist.*mLeg.*rLegMCD.*rUBody.*t17.*t23+ddthWaist.*mLeg.*rLegMCD.*rUBody.*t18.*t25+ddthShoulder.*mLeg.*rLegMCD.*rUBody.*t17.*t23.*2.0+ddthShoulder.*mLeg.*rLegMCD.*rUBody.*t18.*t25.*2.0+dthXip.*dthHand.*mLBody.*rArm.*rLBodyMCD.*t15.*t24.*2.0-dthXip.*dthHand.*mLBody.*rArm.*rLBodyMCD.*t14.*t26.*2.0+dthXip.*dthShoulder.*mLBody.*rArm.*rLBodyMCD.*t15.*t24.*2.0-dthXip.*dthShoulder.*mLBody.*rArm.*rLBodyMCD.*t14.*t26.*2.0+dthHand.*dthShoulder.*mLBody.*rArm.*rLBodyMCD.*t15.*t24.*2.0-dthHand.*dthShoulder.*mLBody.*rArm.*rLBodyMCD.*t14.*t26.*2.0+dthXip.*dthHand.*mLeg.*rArm.*rLBody.*t15.*t24.*2.0-dthXip.*dthHand.*mLeg.*rArm.*rLBody.*t14.*t26.*2.0+dthXip.*dthShoulder.*mLeg.*rArm.*rLBody.*t15.*t24.*2.0-dthXip.*dthShoulder.*mLeg.*rArm.*rLBody.*t14.*t26.*2.0+dthHand.*dthShoulder.*mLeg.*rArm.*rLBody.*t15.*t24.*2.0-dthHand.*dthShoulder.*mLeg.*rArm.*rLBody.*t14.*t26.*2.0+dthHand.*dthWaist.*mLeg.*rArm.*rLegMCD.*t15.*t23.*2.0-dthHand.*dthWaist.*mLeg.*rArm.*rLegMCD.*t14.*t25.*2.0+dthHand.*dthShoulder.*mLeg.*rArm.*rLegMCD.*t15.*t23.*2.0-dthHand.*dthShoulder.*mLeg.*rArm.*rLegMCD.*t14.*t25.*2.0+dthWaist.*dthShoulder.*mLeg.*rArm.*rLegMCD.*t15.*t23.*2.0-dthWaist.*dthShoulder.*mLeg.*rArm.*rLegMCD.*t14.*t25.*2.0-dthHand.*dthShoulder.*mLBody.*rArm.*rUBody.*t14.*t18.*2.0+dthHand.*dthShoulder.*mLBody.*rArm.*rUBody.*t15.*t17.*2.0-dthHand.*dthShoulder.*mLeg.*rArm.*rUBody.*t14.*t18.*2.0+dthHand.*dthShoulder.*mLeg.*rArm.*rUBody.*t15.*t17.*2.0-dthXip.*dthHand.*mLeg.*rLBody.*rLegMCD.*t23.*t26.*2.0+dthXip.*dthHand.*mLeg.*rLBody.*rLegMCD.*t24.*t25.*2.0+dthHand.*dthWaist.*mLeg.*rLBody.*rLegMCD.*t23.*t26.*2.0-dthHand.*dthWaist.*mLeg.*rLBody.*rLegMCD.*t24.*t25.*2.0-dthXip.*dthShoulder.*mLeg.*rLBody.*rLegMCD.*t23.*t26.*2.0+dthXip.*dthShoulder.*mLeg.*rLBody.*rLegMCD.*t24.*t25.*2.0+dthWaist.*dthShoulder.*mLeg.*rLBody.*rLegMCD.*t23.*t26.*2.0-dthWaist.*dthShoulder.*mLeg.*rLBody.*rLegMCD.*t24.*t25.*2.0-dthHand.*dthShoulder.*mUBody.*rArm.*rUBodyMCD.*t14.*t18.*2.0+dthHand.*dthShoulder.*mUBody.*rArm.*rUBodyMCD.*t15.*t17.*2.0+dthXip.*dthHand.*mLBody.*rLBodyMCD.*rUBody.*t18.*t24.*2.0-dthXip.*dthHand.*mLBody.*rLBodyMCD.*rUBody.*t17.*t26.*2.0+dthXip.*dthShoulder.*mLBody.*rLBodyMCD.*rUBody.*t18.*t24.*2.0-dthXip.*dthShoulder.*mLBody.*rLBodyMCD.*rUBody.*t17.*t26.*2.0+dthXip.*dthHand.*mLeg.*rLBody.*rUBody.*t18.*t24.*2.0-dthXip.*dthHand.*mLeg.*rLBody.*rUBody.*t17.*t26.*2.0+dthXip.*dthShoulder.*mLeg.*rLBody.*rUBody.*t18.*t24.*2.0-dthXip.*dthShoulder.*mLeg.*rLBody.*rUBody.*t17.*t26.*2.0+dthHand.*dthWaist.*mLeg.*rLegMCD.*rUBody.*t18.*t23.*2.0-dthHand.*dthWaist.*mLeg.*rLegMCD.*rUBody.*t17.*t25.*2.0+dthWaist.*dthShoulder.*mLeg.*rLegMCD.*rUBody.*t18.*t23.*2.0-dthWaist.*dthShoulder.*mLeg.*rLegMCD.*rUBody.*t17.*t25.*2.0;
