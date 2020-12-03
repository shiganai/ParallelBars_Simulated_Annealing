function ddrPB = find_ddrPB_only(FrPB,ddthXip,ddthHand,ddthWaist,ddthShoulder,dthXip,dthHand,dthWaist,dthShoulder,g,mArm,mLBody,mLeg,mPB,mUBody,rArm,rArmMCD,rLBody,rLBodyMCD,rLegMCD,rUBody,rUBodyMCD,thHand,thShoulder,thWaist,thXip)
%FIND_DDRPB_ONLY
%    DDRPB = FIND_DDRPB_ONLY(FRPB,DDTHXIP,DDTHHAND,DDTHWAIST,DDTHSHOULDER,DTHXIP,DTHHAND,DTHWAIST,DTHSHOULDER,G,MARM,MLBODY,MLEG,MPB,MUBODY,RARM,RARMMCD,RLBODY,RLBODYMCD,RLEGMCD,RUBODY,RUBODYMCD,THHAND,THSHOULDER,THWAIST,THXIP)

%    This function was generated by the Symbolic Math Toolbox version 8.5.
%    13-Nov-2020 17:13:19

t2 = dthXip.^2;
t3 = dthHand.^2;
t4 = dthShoulder.^2;
t5 = pi./2.0;
t6 = t5+thHand;
t7 = cos(t6);
t8 = sin(t6);
t9 = t6+thShoulder;
t10 = cos(t9);
t11 = sin(t9);
t12 = t9+thWaist;
t13 = t9+thXip;
t14 = cos(t12);
t15 = cos(t13);
t16 = sin(t12);
t17 = sin(t13);
ddrPB = (FrPB-g.*mArm-g.*mLBody-g.*mLeg-g.*mPB-g.*mUBody-ddthHand.*mArm.*rArmMCD.*t7-ddthHand.*mLBody.*rArm.*t7-ddthHand.*mLeg.*rArm.*t7-ddthHand.*mUBody.*rArm.*t7-ddthXip.*mLBody.*rLBodyMCD.*t15-ddthHand.*mLBody.*rLBodyMCD.*t15-ddthShoulder.*mLBody.*rLBodyMCD.*t15-ddthXip.*mLeg.*rLBody.*t15-ddthHand.*mLeg.*rLBody.*t15-ddthShoulder.*mLeg.*rLBody.*t15-ddthHand.*mLeg.*rLegMCD.*t14-ddthWaist.*mLeg.*rLegMCD.*t14-ddthShoulder.*mLeg.*rLegMCD.*t14-ddthHand.*mLBody.*rUBody.*t10-ddthShoulder.*mLBody.*rUBody.*t10-ddthHand.*mLeg.*rUBody.*t10-ddthShoulder.*mLeg.*rUBody.*t10-ddthHand.*mUBody.*rUBodyMCD.*t10-ddthShoulder.*mUBody.*rUBodyMCD.*t10+mArm.*rArmMCD.*t3.*t8+mLBody.*rArm.*t3.*t8+mLeg.*rArm.*t3.*t8+mUBody.*rArm.*t3.*t8+mLBody.*rLBodyMCD.*t2.*t17+mLBody.*rLBodyMCD.*t3.*t17+mLBody.*rLBodyMCD.*t4.*t17+mLeg.*rLBody.*t2.*t17+mLeg.*rLBody.*t3.*t17+mLeg.*rLBody.*t4.*t17+mLeg.*rLegMCD.*t3.*t16+mLeg.*rLegMCD.*t4.*t16+mLBody.*rUBody.*t3.*t11+mLBody.*rUBody.*t4.*t11+mLeg.*rUBody.*t3.*t11+mLeg.*rUBody.*t4.*t11+mUBody.*rUBodyMCD.*t3.*t11+mUBody.*rUBodyMCD.*t4.*t11+dthWaist.^2.*mLeg.*rLegMCD.*t16+dthXip.*dthHand.*mLBody.*rLBodyMCD.*t17.*2.0+dthXip.*dthShoulder.*mLBody.*rLBodyMCD.*t17.*2.0+dthHand.*dthShoulder.*mLBody.*rLBodyMCD.*t17.*2.0+dthXip.*dthHand.*mLeg.*rLBody.*t17.*2.0+dthXip.*dthShoulder.*mLeg.*rLBody.*t17.*2.0+dthHand.*dthShoulder.*mLeg.*rLBody.*t17.*2.0+dthHand.*dthWaist.*mLeg.*rLegMCD.*t16.*2.0+dthHand.*dthShoulder.*mLeg.*rLegMCD.*t16.*2.0+dthWaist.*dthShoulder.*mLeg.*rLegMCD.*t16.*2.0+dthHand.*dthShoulder.*mLBody.*rUBody.*t11.*2.0+dthHand.*dthShoulder.*mLeg.*rUBody.*t11.*2.0+dthHand.*dthShoulder.*mUBody.*rUBodyMCD.*t11.*2.0)./(mArm+mLBody+mLeg+mPB+mUBody);
