function [ddrPB,ddthHand] = find_ddrPB_ddthHand_ddt0(InertiaLeg,InertiaArm,InertiaBody,MrPB,MthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,kPB,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,rPB,thHand,thShoulder,thWaist)
%FIND_DDRPB_DDTHHAND_DDT0
%    [DDRPB,DDTHHAND] = FIND_DDRPB_DDTHHAND_DDT0(INERTIALEG,INERTIAARM,INERTIABODY,MRPB,MTHHAND,DDTHWAIST,DDTHSHOULDER,DTHHAND,DTHWAIST,DTHSHOULDER,G,KPB,MARM,MBODY,MLEG,MPB,RARM,RARMMCD,RBODY,RBODYMCD,RLEGMCD,RPB,THHAND,THSHOULDER,THWAIST)

%    This function was generated by the Symbolic Math Toolbox version 8.5.
%    12-Jul-2020 23:39:48

t2 = InertiaLeg.*ddthWaist;
t3 = InertiaLeg.*ddthShoulder;
t4 = InertiaBody.*ddthShoulder;
t5 = InertiaLeg.*mArm;
t6 = InertiaArm.*mArm;
t7 = InertiaBody.*mArm;
t8 = InertiaLeg.*mBody;
t9 = InertiaArm.*mBody;
t10 = InertiaBody.*mBody;
t11 = InertiaLeg.*mLeg;
t12 = InertiaArm.*mLeg;
t13 = InertiaBody.*mLeg;
t14 = InertiaLeg.*mPB;
t15 = InertiaArm.*mPB;
t16 = InertiaBody.*mPB;
t17 = g.*mArm;
t18 = g.*mBody;
t19 = g.*mLeg;
t20 = g.*mPB;
t21 = kPB.*rPB;
t22 = dthHand.^2;
t23 = dthWaist.^2;
t24 = dthShoulder.^2;
t25 = mArm.^2;
t26 = mBody.^2;
t27 = mLeg.^2;
t28 = rArm.^2;
t29 = rArmMCD.^2;
t30 = rBody.^2;
t31 = rBodyMCD.^2;
t32 = rLegMCD.^2;
t33 = -MthHand;
t39 = pi./2.0;
t34 = -t17;
t35 = -t18;
t36 = -t19;
t37 = -t20;
t38 = -t21;
t40 = t39+thHand;
t41 = cos(t40);
t42 = sin(t40);
t43 = t40+thShoulder;
t44 = cos(t43);
t45 = sin(t43);
t46 = t43+thWaist;
t47 = t41.^2;
t48 = t42.^2;
t51 = mArm.*rArmMCD.*t41;
t52 = mBody.*rArm.*t41;
t53 = mLeg.*rArm.*t41;
t58 = rArmMCD.*t17.*t41;
t59 = rArm.*t18.*t41;
t60 = rArm.*t19.*t41;
t71 = mArm.*rArmMCD.*t22.*t42;
t72 = mBody.*rArm.*t22.*t42;
t73 = mLeg.*rArm.*t22.*t42;
t49 = cos(t46);
t50 = sin(t46);
t54 = t44.^2;
t55 = t45.^2;
t61 = mBody.*rBodyMCD.*t44;
t62 = mLeg.*rBody.*t44;
t63 = rBodyMCD.*t18.*t44;
t64 = rBody.*t19.*t44;
t74 = mBody.*rBodyMCD.*t22.*t45;
t75 = mBody.*rBodyMCD.*t24.*t45;
t76 = mLeg.*rBody.*t22.*t45;
t77 = mLeg.*rBody.*t24.*t45;
t78 = dthHand.*dthShoulder.*mBody.*rBodyMCD.*t45.*2.0;
t79 = dthHand.*dthShoulder.*mLeg.*rBody.*t45.*2.0;
t82 = mArm.*mBody.*t28.*t47;
t83 = mArm.*mBody.*t29.*t47;
t84 = mArm.*mLeg.*t28.*t47;
t85 = mArm.*mLeg.*t29.*t47;
t86 = mArm.*mPB.*t29.*t47;
t87 = mBody.*mPB.*t28.*t47;
t88 = mLeg.*mPB.*t28.*t47;
t89 = mArm.*mBody.*t28.*t48;
t90 = mArm.*mBody.*t29.*t48;
t91 = mArm.*mLeg.*t28.*t48;
t92 = mArm.*mLeg.*t29.*t48;
t93 = mArm.*mPB.*t29.*t48;
t94 = mBody.*mPB.*t28.*t48;
t95 = mLeg.*mPB.*t28.*t48;
t96 = mArm.*mBody.*rArm.*rArmMCD.*t47.*2.0;
t97 = mArm.*mLeg.*rArm.*rArmMCD.*t47.*2.0;
t106 = t25.*t29.*t48;
t107 = t26.*t28.*t48;
t108 = t27.*t28.*t48;
t109 = mBody.*mLeg.*t28.*t48.*2.0;
t143 = ddthShoulder.*rBodyMCD.*t44.*t52;
t144 = ddthShoulder.*rBody.*t44.*t53;
t145 = ddthShoulder.*mBody.*rArm.*rBodyMCD.*t42.*t45;
t146 = ddthShoulder.*mLeg.*rArm.*rBody.*t42.*t45;
t147 = mArm.*rBodyMCD.*t44.*t52.*2.0;
t149 = mArm.*rBody.*t44.*t53.*2.0;
t151 = mPB.*rBodyMCD.*t44.*t52.*2.0;
t152 = mPB.*rBody.*t44.*t53.*2.0;
t153 = mArm.*mBody.*rArm.*rBodyMCD.*t42.*t45.*2.0;
t154 = mArm.*mLeg.*rArm.*rBody.*t42.*t45.*2.0;
t155 = mBody.*mLeg.*rArm.*rBody.*t42.*t45.*2.0;
t156 = mBody.*mLeg.*rArm.*rBodyMCD.*t42.*t45.*2.0;
t157 = mBody.*mPB.*rArm.*rBodyMCD.*t42.*t45.*2.0;
t158 = mLeg.*mPB.*rArm.*rBody.*t42.*t45.*2.0;
t167 = rArm.*rBodyMCD.*t26.*t42.*t45.*2.0;
t168 = rArm.*rBody.*t27.*t42.*t45.*2.0;
t170 = rBodyMCD.*t24.*t45.*t52;
t172 = rBody.*t24.*t45.*t53;
t174 = dthHand.*dthShoulder.*rBodyMCD.*t45.*t52.*2.0;
t176 = dthHand.*dthShoulder.*rBody.*t45.*t53.*2.0;
t56 = t49.^2;
t57 = t50.^2;
t65 = mLeg.*rLegMCD.*t49;
t66 = ddthShoulder.*t61;
t67 = ddthShoulder.*t62;
t70 = rLegMCD.*t19.*t49;
t100 = mLeg.*rLegMCD.*t22.*t50;
t101 = mLeg.*rLegMCD.*t23.*t50;
t102 = mLeg.*rLegMCD.*t24.*t50;
t103 = dthHand.*dthWaist.*mLeg.*rLegMCD.*t50.*2.0;
t104 = dthHand.*dthShoulder.*mLeg.*rLegMCD.*t50.*2.0;
t105 = dthWaist.*dthShoulder.*mLeg.*rLegMCD.*t50.*2.0;
t110 = -t96;
t111 = -t97;
t112 = ddthShoulder.*mBody.*t31.*t54;
t113 = ddthShoulder.*mLeg.*t30.*t54;
t114 = mArm.*mBody.*t31.*t54;
t115 = mArm.*mLeg.*t30.*t54;
t116 = mBody.*mLeg.*t30.*t54;
t117 = mBody.*mLeg.*t31.*t54;
t118 = mBody.*mPB.*t31.*t54;
t119 = mLeg.*mPB.*t30.*t54;
t120 = ddthShoulder.*mBody.*t31.*t55;
t121 = ddthShoulder.*mLeg.*t30.*t55;
t122 = mArm.*mBody.*t31.*t55;
t123 = mArm.*mLeg.*t30.*t55;
t124 = mBody.*mLeg.*t30.*t55;
t125 = mBody.*mLeg.*t31.*t55;
t126 = mBody.*mPB.*t31.*t55;
t127 = mLeg.*mPB.*t30.*t55;
t128 = mBody.*mLeg.*rBody.*rBodyMCD.*t54.*2.0;
t139 = t26.*t31.*t55;
t140 = t27.*t30.*t55;
t148 = t51.*t61.*2.0;
t150 = t51.*t62.*2.0;
t159 = ddthWaist.*rLegMCD.*t49.*t53;
t160 = ddthShoulder.*rLegMCD.*t49.*t53;
t161 = ddthWaist.*mLeg.*rArm.*rLegMCD.*t42.*t50;
t162 = ddthShoulder.*mLeg.*rArm.*rLegMCD.*t42.*t50;
t163 = ddthWaist.*rLegMCD.*t49.*t62;
t164 = ddthWaist.*mLeg.*rBody.*rLegMCD.*t45.*t50;
t169 = rArm.*t24.*t42.*t61;
t171 = rArm.*t24.*t42.*t62;
t173 = dthHand.*dthShoulder.*rArm.*t42.*t61.*2.0;
t175 = dthHand.*dthShoulder.*rArm.*t42.*t62.*2.0;
t177 = mArm.*rLegMCD.*t49.*t53.*2.0;
t179 = mPB.*rLegMCD.*t49.*t53.*2.0;
t180 = mArm.*mLeg.*rArm.*rLegMCD.*t42.*t50.*2.0;
t181 = mBody.*mLeg.*rArm.*rLegMCD.*t42.*t50.*2.0;
t182 = mLeg.*mPB.*rArm.*rLegMCD.*t42.*t50.*2.0;
t184 = rLegMCD.*t23.*t50.*t53;
t186 = rLegMCD.*t24.*t50.*t53;
t189 = dthHand.*dthWaist.*rLegMCD.*t50.*t53.*2.0;
t191 = dthHand.*dthShoulder.*rLegMCD.*t50.*t53.*2.0;
t193 = dthWaist.*dthShoulder.*rLegMCD.*t50.*t53.*2.0;
t194 = mArm.*rLegMCD.*t49.*t62.*2.0;
t195 = mBody.*rLegMCD.*t49.*t62.*2.0;
t197 = mPB.*rLegMCD.*t49.*t62.*2.0;
t198 = ddthShoulder.*mLeg.*rBody.*rLegMCD.*t45.*t50.*2.0;
t199 = mArm.*mLeg.*rBody.*rLegMCD.*t45.*t50.*2.0;
t200 = mBody.*mLeg.*rBody.*rLegMCD.*t45.*t50.*2.0;
t201 = mLeg.*mPB.*rBody.*rLegMCD.*t45.*t50.*2.0;
t202 = -t174;
t203 = -t176;
t205 = rArm.*rLegMCD.*t27.*t42.*t50.*2.0;
t210 = rBody.*rLegMCD.*t27.*t45.*t50.*2.0;
t211 = rLegMCD.*t23.*t50.*t62;
t213 = dthHand.*dthWaist.*rLegMCD.*t50.*t62.*2.0;
t215 = dthWaist.*dthShoulder.*rLegMCD.*t50.*t62.*2.0;
t217 = -t170;
t218 = -t172;
t68 = ddthWaist.*t65;
t69 = ddthShoulder.*t65;
t80 = -t66;
t81 = -t67;
t129 = ddthWaist.*mLeg.*t32.*t56;
t130 = ddthShoulder.*mLeg.*t32.*t56;
t131 = mArm.*mLeg.*t32.*t56;
t132 = mBody.*mLeg.*t32.*t56;
t133 = mLeg.*mPB.*t32.*t56;
t134 = ddthWaist.*mLeg.*t32.*t57;
t135 = ddthShoulder.*mLeg.*t32.*t57;
t136 = mArm.*mLeg.*t32.*t57;
t137 = mBody.*mLeg.*t32.*t57;
t138 = mLeg.*mPB.*t32.*t57;
t141 = -t128;
t142 = t27.*t32.*t57;
t165 = -t148;
t166 = -t150;
t178 = t51.*t65.*2.0;
t183 = rArm.*t23.*t42.*t65;
t185 = rArm.*t24.*t42.*t65;
t187 = rLegMCD.*t49.*t67.*2.0;
t188 = dthHand.*dthWaist.*rArm.*t42.*t65.*2.0;
t190 = dthHand.*dthShoulder.*rArm.*t42.*t65.*2.0;
t192 = dthWaist.*dthShoulder.*rArm.*t42.*t65.*2.0;
t196 = t61.*t65.*2.0;
t206 = -t189;
t207 = -t191;
t208 = -t193;
t212 = rBody.*t23.*t45.*t65;
t214 = dthHand.*dthWaist.*rBody.*t45.*t65.*2.0;
t216 = dthWaist.*dthShoulder.*rBody.*t45.*t65.*2.0;
t219 = -t184;
t220 = -t186;
t221 = -t213;
t222 = -t215;
t223 = -t211;
t224 = t51+t52+t53+t61+t62+t65;
t98 = -t68;
t99 = -t69;
t204 = -t178;
t209 = -t196;
t226 = t2+t3+t4+t33+t58+t59+t60+t63+t64+t70+t112+t113+t120+t121+t129+t130+t134+t135+t143+t144+t145+t146+t159+t160+t161+t162+t163+t164+t169+t171+t173+t175+t183+t185+t187+t188+t190+t192+t198+t202+t203+t206+t207+t208+t212+t214+t216+t217+t218+t219+t220+t221+t222+t223;
t225 = MrPB+t34+t35+t36+t37+t38+t71+t72+t73+t74+t75+t76+t77+t78+t79+t80+t81+t98+t99+t100+t101+t102+t103+t104+t105;
t227 = t5+t6+t7+t8+t9+t10+t11+t12+t13+t14+t15+t16+t82+t83+t84+t85+t86+t87+t88+t89+t90+t91+t92+t93+t94+t95+t106+t107+t108+t109+t110+t111+t114+t115+t116+t117+t118+t119+t122+t123+t124+t125+t126+t127+t131+t132+t133+t136+t137+t138+t139+t140+t141+t142+t147+t149+t151+t152+t153+t154+t155+t156+t157+t158+t165+t166+t167+t168+t177+t179+t180+t181+t182+t194+t195+t197+t199+t200+t201+t204+t205+t209+t210;
t228 = 1.0./t227;
ddrPB = t225.*t228.*(InertiaLeg+InertiaArm+InertiaBody+mArm.*t29.*t47+mArm.*t29.*t48+mBody.*t28.*t47+mBody.*t28.*t48+mBody.*t31.*t54+mBody.*t31.*t55+mLeg.*t28.*t47+mLeg.*t28.*t48+mLeg.*t30.*t54+mLeg.*t30.*t55+mLeg.*t32.*t56+mLeg.*t32.*t57+rBody.*t44.*t53.*2.0+rBodyMCD.*t44.*t52.*2.0+rLegMCD.*t49.*t53.*2.0+rLegMCD.*t49.*t62.*2.0+mBody.*rArm.*rBodyMCD.*t42.*t45.*2.0+mLeg.*rArm.*rBody.*t42.*t45.*2.0+mLeg.*rArm.*rLegMCD.*t42.*t50.*2.0+mLeg.*rBody.*rLegMCD.*t45.*t50.*2.0)+t224.*t226.*t228;
if nargout > 1
    ddthHand = -t226.*t228.*(mArm+mBody+mLeg+mPB)-t224.*t225.*t228;
end
