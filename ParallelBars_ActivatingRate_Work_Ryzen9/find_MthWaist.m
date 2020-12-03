function MthWaist = find_MthWaist(InertiaLeg,ddrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthShoulder,g,mLeg,rArm,rBody,rLegMCD,thHand,thShoulder,thWaist)
%FIND_MTHWAIST
%    MTHWAIST = FIND_MTHWAIST(INERTIALEG,DDRPB,DDTHHAND,DDTHWAIST,DDTHSHOULDER,DTHHAND,DTHSHOULDER,G,MLEG,RARM,RBODY,RLEGMCD,THHAND,THSHOULDER,THWAIST)

%    This function was generated by the Symbolic Math Toolbox version 8.5.
%    25-May-2020 19:54:04

t2 = cos(thHand);
t3 = sin(thHand);
t4 = thHand+thShoulder;
t5 = dthHand.^2;
t6 = dthShoulder.^2;
t7 = rLegMCD.^2;
t8 = cos(t4);
t9 = sin(t4);
t10 = t4+thWaist;
t11 = cos(t10);
t12 = sin(t10);
t13 = t11.^2;
t14 = t12.^2;
MthWaist = InertiaLeg.*ddthHand+InertiaLeg.*ddthWaist+InertiaLeg.*ddthShoulder-ddrPB.*mLeg.*rLegMCD.*t12+ddthHand.*mLeg.*t7.*t13+ddthHand.*mLeg.*t7.*t14+ddthWaist.*mLeg.*t7.*t13+ddthWaist.*mLeg.*t7.*t14+ddthShoulder.*mLeg.*t7.*t13+ddthShoulder.*mLeg.*t7.*t14+g.*mLeg.*rLegMCD.*cos(t10+pi./2.0)+mLeg.*rArm.*rLegMCD.*t2.*t5.*t12-mLeg.*rArm.*rLegMCD.*t3.*t5.*t11+mLeg.*rBody.*rLegMCD.*t5.*t8.*t12-mLeg.*rBody.*rLegMCD.*t5.*t9.*t11+mLeg.*rBody.*rLegMCD.*t6.*t8.*t12-mLeg.*rBody.*rLegMCD.*t6.*t9.*t11+ddthHand.*mLeg.*rArm.*rLegMCD.*t2.*t11+ddthHand.*mLeg.*rArm.*rLegMCD.*t3.*t12+ddthHand.*mLeg.*rBody.*rLegMCD.*t8.*t11+ddthHand.*mLeg.*rBody.*rLegMCD.*t9.*t12+ddthShoulder.*mLeg.*rBody.*rLegMCD.*t8.*t11+ddthShoulder.*mLeg.*rBody.*rLegMCD.*t9.*t12+dthHand.*dthShoulder.*mLeg.*rBody.*rLegMCD.*t8.*t12.*2.0-dthHand.*dthShoulder.*mLeg.*rBody.*rLegMCD.*t9.*t11.*2.0;