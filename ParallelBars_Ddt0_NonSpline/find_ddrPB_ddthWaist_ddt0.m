function [ddrPB,ddthWaist] = find_ddrPB_ddthWaist_ddt0(InertiaLeg,MrPB,MthWaist,ddthHand,ddthShoulder,dthHand,dthWaist,dthShoulder,g,kPB,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,rPB,thHand,thShoulder,thWaist)
%FIND_DDRPB_DDTHWAIST_DDT0
%    [DDRPB,DDTHWAIST] = FIND_DDRPB_DDTHWAIST_DDT0(INERTIALEG,MRPB,MTHWAIST,DDTHHAND,DDTHSHOULDER,DTHHAND,DTHWAIST,DTHSHOULDER,G,KPB,MARM,MBODY,MLEG,MPB,RARM,RARMMCD,RBODY,RBODYMCD,RLEGMCD,RPB,THHAND,THSHOULDER,THWAIST)

%    This function was generated by the Symbolic Math Toolbox version 8.5.
%    12-Jul-2020 23:39:28

t2 = InertiaLeg.*ddthHand;
t3 = InertiaLeg.*ddthShoulder;
t4 = InertiaLeg.*mArm;
t5 = InertiaLeg.*mBody;
t6 = InertiaLeg.*mLeg;
t7 = InertiaLeg.*mPB;
t8 = g.*mArm;
t9 = g.*mBody;
t10 = g.*mLeg;
t11 = g.*mPB;
t12 = kPB.*rPB;
t13 = dthHand.^2;
t14 = dthWaist.^2;
t15 = dthShoulder.^2;
t16 = mLeg.^2;
t17 = rLegMCD.^2;
t18 = -MthWaist;
t24 = pi./2.0;
t19 = -t8;
t20 = -t9;
t21 = -t10;
t22 = -t11;
t23 = -t12;
t25 = t24+thHand;
t26 = cos(t25);
t27 = sin(t25);
t28 = t25+thShoulder;
t29 = cos(t28);
t30 = sin(t28);
t31 = t28+thWaist;
t36 = ddthHand.*mArm.*rArmMCD.*t26;
t37 = ddthHand.*mBody.*rArm.*t26;
t38 = ddthHand.*mLeg.*rArm.*t26;
t49 = mArm.*rArmMCD.*t13.*t27;
t50 = mBody.*rArm.*t13.*t27;
t51 = mLeg.*rArm.*t13.*t27;
t32 = cos(t31);
t33 = sin(t31);
t39 = ddthHand.*mBody.*rBodyMCD.*t29;
t40 = ddthShoulder.*mBody.*rBodyMCD.*t29;
t41 = ddthHand.*mLeg.*rBody.*t29;
t42 = ddthShoulder.*mLeg.*rBody.*t29;
t46 = -t36;
t47 = -t37;
t48 = -t38;
t52 = mBody.*rBodyMCD.*t13.*t30;
t53 = mBody.*rBodyMCD.*t15.*t30;
t54 = mLeg.*rBody.*t13.*t30;
t55 = mLeg.*rBody.*t15.*t30;
t56 = dthHand.*dthShoulder.*mBody.*rBodyMCD.*t30.*2.0;
t57 = dthHand.*dthShoulder.*mLeg.*rBody.*t30.*2.0;
t34 = t32.^2;
t35 = t33.^2;
t43 = ddthHand.*mLeg.*rLegMCD.*t32;
t44 = ddthShoulder.*mLeg.*rLegMCD.*t32;
t45 = rLegMCD.*t10.*t32;
t58 = -t39;
t59 = -t40;
t60 = -t41;
t61 = -t42;
t64 = mLeg.*rLegMCD.*t13.*t33;
t65 = mLeg.*rLegMCD.*t14.*t33;
t66 = mLeg.*rLegMCD.*t15.*t33;
t67 = dthHand.*dthWaist.*mLeg.*rLegMCD.*t33.*2.0;
t68 = dthHand.*dthShoulder.*mLeg.*rLegMCD.*t33.*2.0;
t69 = dthWaist.*dthShoulder.*mLeg.*rLegMCD.*t33.*2.0;
t81 = rLegMCD.*t32.*t38;
t82 = ddthHand.*mLeg.*rArm.*rLegMCD.*t27.*t33;
t83 = rLegMCD.*t32.*t41;
t84 = rLegMCD.*t32.*t42;
t85 = ddthHand.*mLeg.*rBody.*rLegMCD.*t30.*t33;
t86 = ddthShoulder.*mLeg.*rBody.*rLegMCD.*t30.*t33;
t87 = rLegMCD.*t32.*t51;
t90 = rLegMCD.*t32.*t54;
t92 = rLegMCD.*t32.*t55;
t94 = rLegMCD.*t32.*t57;
t96 = dthHand.*dthShoulder.*mLeg.*rBody.*rLegMCD.*t30.*t32.*-2.0;
t62 = -t43;
t63 = -t44;
t70 = ddthHand.*mLeg.*t17.*t34;
t71 = ddthShoulder.*mLeg.*t17.*t34;
t72 = mArm.*mLeg.*t17.*t34;
t73 = mBody.*mLeg.*t17.*t34;
t74 = mLeg.*mPB.*t17.*t34;
t75 = ddthHand.*mLeg.*t17.*t35;
t76 = ddthShoulder.*mLeg.*t17.*t35;
t77 = mArm.*mLeg.*t17.*t35;
t78 = mBody.*mLeg.*t17.*t35;
t79 = mLeg.*mPB.*t17.*t35;
t80 = t16.*t17.*t35;
t88 = rArm.*t26.*t64;
t89 = rBody.*t29.*t64;
t91 = rBody.*t29.*t66;
t93 = rBody.*t29.*t68;
t95 = -t87;
t97 = -t90;
t98 = -t92;
t99 = t4+t5+t6+t7+t72+t73+t74+t77+t78+t79+t80;
t101 = MrPB+t19+t20+t21+t22+t23+t46+t47+t48+t49+t50+t51+t52+t53+t54+t55+t56+t57+t58+t59+t60+t61+t62+t63+t64+t65+t66+t67+t68+t69;
t102 = t2+t3+t18+t45+t70+t71+t75+t76+t81+t82+t83+t84+t85+t86+t88+t89+t91+t93+t95+t96+t97+t98;
t100 = 1.0./t99;
ddrPB = t100.*t101.*(InertiaLeg+mLeg.*t17.*t34+mLeg.*t17.*t35)+mLeg.*rLegMCD.*t32.*t100.*t102;
if nargout > 1
    ddthWaist = -t100.*t102.*(mArm+mBody+mLeg+mPB)-mLeg.*rLegMCD.*t32.*t100.*t101;
end