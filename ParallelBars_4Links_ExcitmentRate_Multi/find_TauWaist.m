function TauWaist = find_TauWaist(InertiaLeg,ddrPB,ddthXip,ddthHand,ddthWaist,ddthShoulder,dthXip,dthHand,dthShoulder,g,mLeg,rArm,rLBody,rLegMCD,rUBody,thHand,thShoulder,thWaist,thXip)
%FIND_TAUWAIST
%    TAUWAIST = FIND_TAUWAIST(INERTIALEG,DDRPB,DDTHXIP,DDTHHAND,DDTHWAIST,DDTHSHOULDER,DTHXIP,DTHHAND,DTHSHOULDER,G,MLEG,RARM,RLBODY,RLEGMCD,RUBODY,THHAND,THSHOULDER,THWAIST,THXIP)

%    This function was generated by the Symbolic Math Toolbox version 8.5.
%    13-Nov-2020 17:13:19

t2 = dthXip.^2;
t3 = dthHand.^2;
t4 = dthShoulder.^2;
t5 = rLegMCD.^2;
t6 = pi./2.0;
t7 = t6+thHand;
t8 = cos(t7);
t9 = sin(t7);
t10 = t7+thShoulder;
t11 = cos(t10);
t12 = sin(t10);
t13 = t10+thWaist;
t14 = t10+thXip;
t15 = cos(t13);
t16 = cos(t14);
t17 = sin(t13);
t18 = sin(t14);
t19 = t15.^2;
t20 = t17.^2;
TauWaist = InertiaLeg.*ddthXip+InertiaLeg.*ddthHand+InertiaLeg.*ddthWaist+InertiaLeg.*ddthShoulder+ddrPB.*mLeg.*rLegMCD.*t15+ddthHand.*mLeg.*t5.*t19+ddthHand.*mLeg.*t5.*t20+ddthWaist.*mLeg.*t5.*t19+ddthWaist.*mLeg.*t5.*t20+ddthShoulder.*mLeg.*t5.*t19+ddthShoulder.*mLeg.*t5.*t20+g.*mLeg.*rLegMCD.*t15-mLeg.*rArm.*rLegMCD.*t3.*t9.*t15+mLeg.*rArm.*rLegMCD.*t3.*t8.*t17-mLeg.*rLBody.*rLegMCD.*t2.*t15.*t18+mLeg.*rLBody.*rLegMCD.*t2.*t16.*t17-mLeg.*rLBody.*rLegMCD.*t3.*t15.*t18+mLeg.*rLBody.*rLegMCD.*t3.*t16.*t17-mLeg.*rLBody.*rLegMCD.*t4.*t15.*t18+mLeg.*rLBody.*rLegMCD.*t4.*t16.*t17-mLeg.*rLegMCD.*rUBody.*t3.*t12.*t15+mLeg.*rLegMCD.*rUBody.*t3.*t11.*t17-mLeg.*rLegMCD.*rUBody.*t4.*t12.*t15+mLeg.*rLegMCD.*rUBody.*t4.*t11.*t17+ddthHand.*mLeg.*rArm.*rLegMCD.*t8.*t15+ddthHand.*mLeg.*rArm.*rLegMCD.*t9.*t17+ddthXip.*mLeg.*rLBody.*rLegMCD.*t15.*t16+ddthXip.*mLeg.*rLBody.*rLegMCD.*t17.*t18+ddthHand.*mLeg.*rLBody.*rLegMCD.*t15.*t16+ddthHand.*mLeg.*rLBody.*rLegMCD.*t17.*t18+ddthShoulder.*mLeg.*rLBody.*rLegMCD.*t15.*t16+ddthShoulder.*mLeg.*rLBody.*rLegMCD.*t17.*t18+ddthHand.*mLeg.*rLegMCD.*rUBody.*t11.*t15+ddthHand.*mLeg.*rLegMCD.*rUBody.*t12.*t17+ddthShoulder.*mLeg.*rLegMCD.*rUBody.*t11.*t15+ddthShoulder.*mLeg.*rLegMCD.*rUBody.*t12.*t17-dthXip.*dthHand.*mLeg.*rLBody.*rLegMCD.*t15.*t18.*2.0+dthXip.*dthHand.*mLeg.*rLBody.*rLegMCD.*t16.*t17.*2.0-dthXip.*dthShoulder.*mLeg.*rLBody.*rLegMCD.*t15.*t18.*2.0+dthXip.*dthShoulder.*mLeg.*rLBody.*rLegMCD.*t16.*t17.*2.0-dthHand.*dthShoulder.*mLeg.*rLBody.*rLegMCD.*t15.*t18.*2.0+dthHand.*dthShoulder.*mLeg.*rLBody.*rLegMCD.*t16.*t17.*2.0-dthHand.*dthShoulder.*mLeg.*rLegMCD.*rUBody.*t12.*t15.*2.0+dthHand.*dthShoulder.*mLeg.*rLegMCD.*rUBody.*t11.*t17.*2.0;