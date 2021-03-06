function MthShoulder = find_MthShoulder_freefall(InertiaLeg,InertiaArm,InertiaBody,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist)
%FIND_MTHSHOULDER_FREEFALL
%    MTHSHOULDER = FIND_MTHSHOULDER_FREEFALL(INERTIALEG,INERTIAARM,INERTIABODY,DDTHWAIST,DDTHSHOULDER,DTHHAND,DTHWAIST,DTHSHOULDER,G,MARM,MBODY,MLEG,RARM,RARMMCD,RBODY,RBODYMCD,RLEGMCD,THHAND,THSHOULDER,THWAIST)

%    This function was generated by the Symbolic Math Toolbox version 8.5.
%    25-May-2020 20:00:01

t2 = cos(thHand);
t3 = sin(thHand);
t4 = InertiaLeg.*ddthWaist;
t5 = InertiaLeg.*ddthShoulder;
t6 = InertiaBody.*ddthShoulder;
t7 = InertiaLeg.*mArm;
t8 = InertiaBody.*mArm;
t9 = InertiaLeg.*mBody;
t10 = InertiaBody.*mBody;
t11 = InertiaLeg.*mLeg;
t12 = InertiaBody.*mLeg;
t13 = thHand+thShoulder;
t14 = dthHand.^2;
t15 = dthWaist.^2;
t16 = dthShoulder.^2;
t17 = mArm.^2;
t18 = mBody.^2;
t19 = mLeg.^2;
t20 = rArm.^2;
t21 = rArmMCD.^2;
t22 = rBody.^2;
t23 = rBodyMCD.^2;
t24 = rLegMCD.^2;
t42 = InertiaArm.*mArm.*mBody.*2.0;
t45 = InertiaArm.*mArm.*mLeg.*2.0;
t48 = InertiaArm.*mBody.*mLeg.*2.0;
t50 = pi./2.0;
t25 = t2.^2;
t26 = t3.^2;
t27 = cos(t13);
t28 = sin(t13);
t29 = t13+thWaist;
t32 = mArm.*t7;
t33 = InertiaArm.*t17;
t34 = mArm.*t8;
t35 = mBody.*t9;
t36 = InertiaArm.*t18;
t37 = mBody.*t10;
t38 = mLeg.*t11;
t39 = InertiaArm.*t19;
t40 = mLeg.*t12;
t41 = mBody.*t7.*2.0;
t43 = mBody.*t8.*2.0;
t44 = mLeg.*t7.*2.0;
t46 = mLeg.*t8.*2.0;
t47 = mLeg.*t9.*2.0;
t49 = mLeg.*t10.*2.0;
t54 = t50+thHand;
t57 = t13+t50;
t30 = cos(t29);
t31 = sin(t29);
t51 = t27.^2;
t52 = t28.^2;
t56 = cos(t54);
t58 = cos(t57);
t59 = t29+t50;
t61 = mArm.*mBody.*mLeg.*rArm.*rArmMCD.*t25.*4.0;
t62 = mArm.*mBody.*mLeg.*rArm.*rArmMCD.*t26.*4.0;
t77 = mArm.*t18.*t20.*t25;
t78 = mBody.*t17.*t20.*t25;
t79 = mArm.*t18.*t21.*t25;
t80 = mBody.*t17.*t21.*t25;
t81 = mArm.*t19.*t20.*t25;
t82 = mLeg.*t17.*t20.*t25;
t83 = mArm.*t19.*t21.*t25;
t84 = mLeg.*t17.*t21.*t25;
t85 = mArm.*mBody.*mLeg.*t20.*t25.*2.0;
t86 = mArm.*mBody.*mLeg.*t21.*t25.*2.0;
t87 = mArm.*t18.*t20.*t26;
t88 = mBody.*t17.*t20.*t26;
t89 = mArm.*t18.*t21.*t26;
t90 = mBody.*t17.*t21.*t26;
t91 = mArm.*t19.*t20.*t26;
t92 = mLeg.*t17.*t20.*t26;
t93 = mArm.*t19.*t21.*t26;
t94 = mLeg.*t17.*t21.*t26;
t95 = mArm.*rArm.*rArmMCD.*t18.*t25.*2.0;
t96 = mBody.*rArm.*rArmMCD.*t17.*t25.*2.0;
t97 = mArm.*rArm.*rArmMCD.*t19.*t25.*2.0;
t98 = mLeg.*rArm.*rArmMCD.*t17.*t25.*2.0;
t99 = mArm.*mBody.*mLeg.*t20.*t26.*2.0;
t100 = mArm.*mBody.*mLeg.*t21.*t26.*2.0;
t102 = mArm.*rArm.*rArmMCD.*t18.*t26.*2.0;
t103 = mBody.*rArm.*rArmMCD.*t17.*t26.*2.0;
t104 = mArm.*rArm.*rArmMCD.*t19.*t26.*2.0;
t105 = mLeg.*rArm.*rArmMCD.*t17.*t26.*2.0;
t109 = mArm.*mBody.*mLeg.*rArm.*rBody.*t2.*t27.*2.0;
t110 = mArm.*mBody.*mLeg.*rArm.*rBodyMCD.*t2.*t27.*2.0;
t111 = mArm.*mBody.*mLeg.*rArmMCD.*rBody.*t2.*t27.*2.0;
t112 = mArm.*mBody.*mLeg.*rArmMCD.*rBodyMCD.*t2.*t27.*2.0;
t114 = mArm.*mBody.*mLeg.*rArm.*rBody.*t3.*t28.*2.0;
t115 = mArm.*mBody.*mLeg.*rArm.*rBodyMCD.*t3.*t28.*2.0;
t116 = mArm.*mBody.*mLeg.*rArmMCD.*rBody.*t3.*t28.*2.0;
t117 = mArm.*mBody.*mLeg.*rArmMCD.*rBodyMCD.*t3.*t28.*2.0;
t138 = mArm.*rArm.*rBodyMCD.*t2.*t18.*t27.*2.0;
t139 = mBody.*rArm.*rBodyMCD.*t2.*t17.*t27.*2.0;
t140 = mArm.*rArmMCD.*rBodyMCD.*t2.*t18.*t27.*2.0;
t141 = mBody.*rArmMCD.*rBodyMCD.*t2.*t17.*t27.*2.0;
t142 = mArm.*rArm.*rBody.*t2.*t19.*t27.*2.0;
t143 = mLeg.*rArm.*rBody.*t2.*t17.*t27.*2.0;
t144 = mArm.*rArmMCD.*rBody.*t2.*t19.*t27.*2.0;
t145 = mLeg.*rArmMCD.*rBody.*t2.*t17.*t27.*2.0;
t148 = mArm.*rArm.*rBodyMCD.*t3.*t18.*t28.*2.0;
t149 = mBody.*rArm.*rBodyMCD.*t3.*t17.*t28.*2.0;
t150 = mArm.*rArmMCD.*rBodyMCD.*t3.*t18.*t28.*2.0;
t151 = mBody.*rArmMCD.*rBodyMCD.*t3.*t17.*t28.*2.0;
t152 = mArm.*rArm.*rBody.*t3.*t19.*t28.*2.0;
t153 = mLeg.*rArm.*rBody.*t3.*t17.*t28.*2.0;
t154 = mArm.*rArmMCD.*rBody.*t3.*t19.*t28.*2.0;
t155 = mLeg.*rArmMCD.*rBody.*t3.*t17.*t28.*2.0;
t53 = t30.^2;
t55 = t31.^2;
t60 = cos(t59);
t63 = ddthShoulder.*mBody.*t23.*t51;
t64 = ddthShoulder.*mLeg.*t22.*t51;
t65 = mArm.*mBody.*t23.*t51;
t66 = mArm.*mLeg.*t22.*t51;
t67 = mBody.*mLeg.*t22.*t51;
t68 = mBody.*mLeg.*t23.*t51;
t69 = ddthShoulder.*mBody.*t23.*t52;
t70 = ddthShoulder.*mLeg.*t22.*t52;
t71 = mArm.*mBody.*t23.*t52;
t72 = mArm.*mLeg.*t22.*t52;
t73 = mBody.*mLeg.*t22.*t52;
t74 = mBody.*mLeg.*t23.*t52;
t75 = mBody.*mLeg.*rBody.*rBodyMCD.*t51.*2.0;
t76 = mBody.*mLeg.*rBody.*rBodyMCD.*t52.*2.0;
t101 = -t61;
t106 = -t62;
t107 = g.*mBody.*rBodyMCD.*t58;
t108 = g.*mLeg.*rBody.*t58;
t129 = -t95;
t130 = -t96;
t131 = -t97;
t132 = -t98;
t133 = -t102;
t134 = -t103;
t135 = -t104;
t136 = -t105;
t137 = ddthWaist.*mLeg.*rBody.*rLegMCD.*t28.*t31;
t146 = -t111;
t147 = -t112;
t156 = -t116;
t157 = -t117;
t159 = mArm.*t18.*t23.*t51;
t160 = mBody.*t17.*t23.*t51;
t161 = mArm.*t19.*t22.*t51;
t162 = mLeg.*t17.*t22.*t51;
t163 = mBody.*t19.*t22.*t51;
t164 = mLeg.*t18.*t22.*t51;
t165 = mBody.*t19.*t23.*t51;
t166 = mLeg.*t18.*t23.*t51;
t167 = mArm.*mBody.*mLeg.*rArm.*rLegMCD.*t2.*t30.*2.0;
t168 = mArm.*mBody.*mLeg.*rArmMCD.*rLegMCD.*t2.*t30.*2.0;
t171 = mArm.*t18.*t23.*t52;
t172 = mBody.*t17.*t23.*t52;
t173 = mArm.*t19.*t22.*t52;
t174 = mLeg.*t17.*t22.*t52;
t175 = mBody.*t19.*t22.*t52;
t176 = mLeg.*t18.*t22.*t52;
t177 = mBody.*t19.*t23.*t52;
t178 = mLeg.*t18.*t23.*t52;
t179 = mBody.*rBody.*rBodyMCD.*t19.*t51.*2.0;
t180 = mLeg.*rBody.*rBodyMCD.*t18.*t51.*2.0;
t183 = mArm.*mBody.*mLeg.*rBody.*rBodyMCD.*t51.*-2.0;
t184 = mBody.*rBody.*rBodyMCD.*t19.*t52.*2.0;
t185 = mLeg.*rBody.*rBodyMCD.*t18.*t52.*2.0;
t186 = mArm.*mBody.*mLeg.*rArm.*rLegMCD.*t3.*t31.*2.0;
t187 = mArm.*mBody.*mLeg.*rArmMCD.*rLegMCD.*t3.*t31.*2.0;
t188 = mArm.*mBody.*mLeg.*rBody.*rBodyMCD.*t52.*-2.0;
t189 = ddthWaist.*mLeg.*rBody.*rLegMCD.*t27.*t30;
t190 = ddthShoulder.*mLeg.*rBody.*rLegMCD.*t28.*t31.*2.0;
t191 = -t140;
t192 = -t141;
t193 = -t144;
t194 = -t145;
t196 = mArm.*mLeg.*rBody.*rLegMCD.*t28.*t31.*2.0;
t197 = mBody.*mLeg.*rBody.*rLegMCD.*t28.*t31.*2.0;
t198 = mBody.*mLeg.*rBodyMCD.*rLegMCD.*t28.*t31.*2.0;
t199 = -t150;
t200 = -t151;
t201 = -t154;
t202 = -t155;
t203 = mArm.*rArm.*rLegMCD.*t2.*t19.*t30.*2.0;
t204 = mLeg.*rArm.*rLegMCD.*t2.*t17.*t30.*2.0;
t205 = mArm.*rArmMCD.*rLegMCD.*t2.*t19.*t30.*2.0;
t206 = mLeg.*rArmMCD.*rLegMCD.*t2.*t17.*t30.*2.0;
t210 = mArm.*rArm.*rLegMCD.*t3.*t19.*t31.*2.0;
t211 = mLeg.*rArm.*rLegMCD.*t3.*t17.*t31.*2.0;
t212 = mArm.*rArmMCD.*rLegMCD.*t3.*t19.*t31.*2.0;
t213 = mLeg.*rArmMCD.*rLegMCD.*t3.*t17.*t31.*2.0;
t217 = ddthShoulder.*mLeg.*rBody.*rLegMCD.*t27.*t30.*2.0;
t218 = mArm.*mLeg.*rBody.*rLegMCD.*t27.*t30.*2.0;
t219 = mBody.*mLeg.*rBody.*rLegMCD.*t27.*t30.*2.0;
t220 = mBody.*mLeg.*rBodyMCD.*rLegMCD.*t27.*t30.*2.0;
t231 = mLeg.*rBody.*rLegMCD.*t15.*t28.*t30;
t232 = mLeg.*rBody.*rLegMCD.*t15.*t27.*t31;
t233 = dthHand.*dthWaist.*mLeg.*rBody.*rLegMCD.*t28.*t30.*2.0;
t234 = dthHand.*dthWaist.*mLeg.*rBody.*rLegMCD.*t27.*t31.*2.0;
t235 = dthWaist.*dthShoulder.*mLeg.*rBody.*rLegMCD.*t28.*t30.*2.0;
t236 = dthWaist.*dthShoulder.*mLeg.*rBody.*rLegMCD.*t27.*t31.*2.0;
t237 = mArm.*mBody.*mLeg.*rBody.*rLegMCD.*t27.*t30.*4.0;
t241 = mArm.*mBody.*mLeg.*rBody.*rLegMCD.*t28.*t31.*4.0;
t246 = mArm.*rBody.*rLegMCD.*t19.*t27.*t30.*2.0;
t247 = mLeg.*rBody.*rLegMCD.*t17.*t27.*t30.*2.0;
t248 = mBody.*rBody.*rLegMCD.*t19.*t27.*t30.*2.0;
t249 = mLeg.*rBody.*rLegMCD.*t18.*t27.*t30.*2.0;
t250 = mBody.*rBodyMCD.*rLegMCD.*t19.*t27.*t30.*2.0;
t251 = mLeg.*rBodyMCD.*rLegMCD.*t18.*t27.*t30.*2.0;
t254 = mArm.*mBody.*mLeg.*rBodyMCD.*rLegMCD.*t27.*t30.*-2.0;
t255 = mArm.*rBody.*rLegMCD.*t19.*t28.*t31.*2.0;
t256 = mLeg.*rBody.*rLegMCD.*t17.*t28.*t31.*2.0;
t257 = mBody.*rBody.*rLegMCD.*t19.*t28.*t31.*2.0;
t258 = mLeg.*rBody.*rLegMCD.*t18.*t28.*t31.*2.0;
t259 = mBody.*rBodyMCD.*rLegMCD.*t19.*t28.*t31.*2.0;
t260 = mLeg.*rBodyMCD.*rLegMCD.*t18.*t28.*t31.*2.0;
t261 = mArm.*mBody.*mLeg.*rBodyMCD.*rLegMCD.*t28.*t31.*-2.0;
t113 = -t75;
t118 = -t76;
t119 = ddthWaist.*mLeg.*t24.*t53;
t120 = ddthShoulder.*mLeg.*t24.*t53;
t121 = mArm.*mLeg.*t24.*t53;
t122 = mBody.*mLeg.*t24.*t53;
t123 = ddthWaist.*mLeg.*t24.*t55;
t124 = ddthShoulder.*mLeg.*t24.*t55;
t125 = mArm.*t75;
t126 = mArm.*mLeg.*t24.*t55;
t127 = mBody.*mLeg.*t24.*t55;
t128 = mArm.*t76;
t158 = g.*mLeg.*rLegMCD.*t60;
t169 = mBody.*t66.*2.0;
t170 = mLeg.*t65.*2.0;
t181 = mBody.*t72.*2.0;
t182 = mLeg.*t71.*2.0;
t207 = -t168;
t208 = -t179;
t209 = -t180;
t214 = -t184;
t215 = -t185;
t216 = -t187;
t221 = mArm.*t19.*t24.*t53;
t222 = mLeg.*t17.*t24.*t53;
t223 = mBody.*t19.*t24.*t53;
t224 = mLeg.*t18.*t24.*t53;
t226 = mArm.*t19.*t24.*t55;
t227 = mLeg.*t17.*t24.*t55;
t228 = mBody.*t19.*t24.*t55;
t229 = mLeg.*t18.*t24.*t55;
t230 = -t198;
t238 = mArm.*t220;
t239 = -t205;
t240 = -t206;
t242 = mArm.*t198;
t243 = -t212;
t244 = -t213;
t245 = -t220;
t252 = -t234;
t253 = -t236;
t262 = -t250;
t263 = -t251;
t264 = -t232;
t265 = -t259;
t266 = -t260;
t195 = mBody.*t126.*2.0;
t225 = mBody.*t121.*2.0;
t267 = t32+t33+t34+t35+t36+t37+t38+t39+t40+t41+t42+t43+t44+t45+t46+t47+t48+t49+t77+t78+t79+t80+t81+t82+t83+t84+t85+t86+t87+t88+t89+t90+t91+t92+t93+t94+t99+t100+t101+t106+t109+t110+t114+t115+t129+t130+t131+t132+t133+t134+t135+t136+t138+t139+t142+t143+t146+t147+t148+t149+t152+t153+t156+t157+t159+t160+t161+t162+t163+t164+t165+t166+t167+t169+t170+t171+t172+t173+t174+t175+t176+t177+t178+t181+t182+t183+t186+t188+t191+t192+t193+t194+t195+t199+t200+t201+t202+t203+t204+t207+t208+t209+t210+t211+t214+t215+t216+t221+t222+t223+t224+t225+t226+t227+t228+t229+t237+t239+t240+t241+t243+t244+t246+t247+t248+t249+t254+t255+t256+t257+t258+t261+t262+t263+t265+t266;
t268 = 1.0./t267;
MthShoulder = t4+t5+t6+t63+t64+t69+t70+t107+t108+t119+t120+t123+t124+t137+t158+t189+t190+t217+t231+t233+t235+t252+t253+t264-t268.*(-ddthShoulder.*mBody.*rBodyMCD.*t27-ddthShoulder.*mLeg.*rBody.*t27-ddthWaist.*mLeg.*rLegMCD.*t30-ddthShoulder.*mLeg.*rLegMCD.*t30+mArm.*rArmMCD.*t3.*t14+mBody.*rArm.*t3.*t14+mBody.*rBodyMCD.*t14.*t28+mBody.*rBodyMCD.*t16.*t28+mLeg.*rArm.*t3.*t14+mLeg.*rBody.*t14.*t28+mLeg.*rBody.*t16.*t28+mLeg.*rLegMCD.*t14.*t31+mLeg.*rLegMCD.*t15.*t31+mLeg.*rLegMCD.*t16.*t31+dthHand.*dthShoulder.*mBody.*rBodyMCD.*t28.*2.0+dthHand.*dthShoulder.*mLeg.*rBody.*t28.*2.0+dthHand.*dthWaist.*mLeg.*rLegMCD.*t31.*2.0+dthHand.*dthShoulder.*mLeg.*rLegMCD.*t31.*2.0+dthWaist.*dthShoulder.*mLeg.*rLegMCD.*t31.*2.0).*(rArm.*t2.*t35+rArm.*t2.*t37+rArm.*t2.*t38+rArm.*t2.*t40+rArm.*t2.*t47+rArm.*t2.*t49+rArm.*t2.*t163+rArm.*t2.*t164+rArm.*t2.*t165+rArm.*t2.*t166+rArm.*t2.*t171+rArm.*t2.*t173+rArm.*t2.*t175+rArm.*t2.*t176+rArm.*t2.*t177+rArm.*t2.*t178+rArm.*t2.*t183+rArm.*t2.*t223+rArm.*t2.*t224+rArm.*t2.*t226+rArm.*t2.*t228+rArm.*t2.*t229+rArmMCD.*t2.*t32+rArmMCD.*t2.*t34+rArm.*t2.*t248+rArm.*t2.*t249+rArm.*t2.*t254+rArm.*t2.*t255+rArm.*t2.*t257+rArm.*t2.*t258+rArmMCD.*t2.*t159+rArmMCD.*t2.*t160+rArmMCD.*t2.*t161+rArmMCD.*t2.*t162+rArmMCD.*t2.*t172+rArmMCD.*t2.*t174+rArmMCD.*t2.*t188+rArmMCD.*t2.*t221+rArmMCD.*t2.*t222+rArmMCD.*t2.*t227+rArmMCD.*t2.*t256+rArmMCD.*t2.*t261-rBody.*t27.*t39-rBody.*t27.*t83-rBody.*t27.*t84-rBody.*t27.*t91-rBody.*t27.*t93+rBody.*t27.*t104-rBodyMCD.*t27.*t36-rBodyMCD.*t27.*t79-rBodyMCD.*t27.*t80-rBodyMCD.*t27.*t87-rBodyMCD.*t27.*t89+rBodyMCD.*t27.*t102+rBodyMCD.*t27.*t116-rLegMCD.*t30.*t39-rLegMCD.*t30.*t83-rLegMCD.*t30.*t84-rLegMCD.*t30.*t91-rLegMCD.*t30.*t93+rLegMCD.*t30.*t104+rLegMCD.*t30.*t109+rLegMCD.*t30.*t111+rLegMCD.*t30.*t144+rLegMCD.*t30.*t145+mBody.*rArm.*t2.*t7+mBody.*rArm.*t2.*t8+mBody.*rArm.*t2.*t66+mBody.*rArm.*t2.*t72+mBody.*rArm.*t2.*t121+mBody.*rArm.*t2.*t126+mBody.*rArm.*t2.*t196+mBody.*rArmMCD.*t2.*t7+mBody.*rArmMCD.*t2.*t8+mBody.*rArmMCD.*t2.*t66+mBody.*rArmMCD.*t2.*t72+mBody.*rArmMCD.*t2.*t121+mBody.*rArmMCD.*t2.*t126+mBody.*rArmMCD.*t2.*t196+mLeg.*rArm.*t2.*t7+mLeg.*rArm.*t2.*t8+mLeg.*rArm.*t2.*t65+mLeg.*rArm.*t2.*t71+mLeg.*rArmMCD.*t2.*t7+mLeg.*rArmMCD.*t2.*t8+mLeg.*rArmMCD.*t2.*t65+mLeg.*rArmMCD.*t2.*t71-InertiaArm.*mArm.*mBody.*rBodyMCD.*t27-InertiaArm.*mArm.*mLeg.*rBody.*t27-InertiaArm.*mBody.*mLeg.*rBody.*t27-InertiaArm.*mBody.*mLeg.*rBodyMCD.*t27-InertiaArm.*mArm.*mLeg.*rLegMCD.*t30-InertiaArm.*mBody.*mLeg.*rLegMCD.*t30-mArm.*mBody.*mLeg.*rBody.*t20.*t26.*t27-mArm.*mBody.*mLeg.*rBody.*t21.*t25.*t27-mArm.*mBody.*mLeg.*rBody.*t21.*t26.*t27-mArm.*mBody.*mLeg.*rBodyMCD.*t20.*t26.*t27-mArm.*mBody.*mLeg.*rBodyMCD.*t21.*t25.*t27-mArm.*mBody.*mLeg.*rBodyMCD.*t21.*t26.*t27-mArm.*mBody.*mLeg.*rLegMCD.*t20.*t26.*t30-mArm.*mBody.*mLeg.*rLegMCD.*t21.*t25.*t30-mArm.*mBody.*mLeg.*rLegMCD.*t21.*t26.*t30+mArm.*rArm.*rArmMCD.*rBody.*t19.*t25.*t27+mArm.*rArm.*rArmMCD.*rBodyMCD.*t18.*t25.*t27+mBody.*rArm.*rArmMCD.*rBodyMCD.*t17.*t25.*t27-mBody.*rArm.*rBody.*rBodyMCD.*t2.*t19.*t51.*2.0-mBody.*rArm.*rBody.*rBodyMCD.*t2.*t19.*t52.*2.0+mArm.*rArm.*rArmMCD.*rLegMCD.*t19.*t25.*t30+mLeg.*rArm.*rArmMCD.*rBody.*t17.*t25.*t27-mLeg.*rArm.*rBody.*rBodyMCD.*t2.*t18.*t51.*2.0-mLeg.*rArm.*rBody.*rBodyMCD.*t2.*t18.*t52.*2.0+mLeg.*rArm.*rArmMCD.*rLegMCD.*t17.*t25.*t30-mArm.*rArm.*t3.*t18.*t23.*t27.*t28-mArm.*rArm.*t3.*t19.*t22.*t27.*t28-mArm.*rArm.*t3.*t19.*t24.*t30.*t31+mArm.*rArmMCD.*t3.*t18.*t23.*t27.*t28+mArm.*rArmMCD.*t3.*t19.*t22.*t27.*t28+mArm.*rArmMCD.*t3.*t19.*t24.*t30.*t31+mArm.*rBody.*t2.*t3.*t19.*t20.*t28+mArm.*rBodyMCD.*t2.*t3.*t18.*t20.*t28-mBody.*rBodyMCD.*t2.*t3.*t17.*t21.*t28+mArm.*rLegMCD.*t2.*t3.*t19.*t20.*t31-mLeg.*rBody.*t2.*t3.*t17.*t21.*t28-mLeg.*rLegMCD.*t2.*t3.*t17.*t21.*t31+mArm.*mBody.*mLeg.*rArm.*rArmMCD.*rBody.*t25.*t27+mArm.*mBody.*mLeg.*rArm.*rArmMCD.*rBody.*t26.*t27.*2.0+mArm.*mBody.*mLeg.*rArm.*rArmMCD.*rBodyMCD.*t25.*t27+mArm.*mBody.*mLeg.*rArm.*rArmMCD.*rBodyMCD.*t26.*t27.*2.0+mArm.*mBody.*mLeg.*rArm.*rArmMCD.*rLegMCD.*t25.*t30+mArm.*mBody.*mLeg.*rArm.*rArmMCD.*rLegMCD.*t26.*t30.*2.0+mArm.*mBody.*mLeg.*rBody.*t2.*t3.*t20.*t28+mArm.*mBody.*mLeg.*rBodyMCD.*t2.*t3.*t20.*t28+mArm.*mBody.*mLeg.*rLegMCD.*t2.*t3.*t20.*t31-mArm.*rArm.*rArmMCD.*rBody.*t2.*t3.*t19.*t28-mArm.*rArm.*rArmMCD.*rBodyMCD.*t2.*t3.*t18.*t28+mBody.*rArm.*rArmMCD.*rBodyMCD.*t2.*t3.*t17.*t28-mArm.*rArm.*rArmMCD.*rLegMCD.*t2.*t3.*t19.*t31+mLeg.*rArm.*rArmMCD.*rBody.*t2.*t3.*t17.*t28-mArm.*rArm.*rBody.*rLegMCD.*t3.*t19.*t27.*t31-mArm.*rArm.*rBody.*rLegMCD.*t3.*t19.*t28.*t30+mArm.*rArmMCD.*rBody.*rLegMCD.*t3.*t19.*t27.*t31+mArm.*rArmMCD.*rBody.*rLegMCD.*t3.*t19.*t28.*t30-mBody.*rArm.*rBodyMCD.*rLegMCD.*t2.*t19.*t27.*t30.*2.0-mBody.*rArm.*rBodyMCD.*rLegMCD.*t2.*t19.*t28.*t31.*2.0+mLeg.*rArm.*rArmMCD.*rLegMCD.*t2.*t3.*t17.*t31-mLeg.*rArm.*rBodyMCD.*rLegMCD.*t2.*t18.*t27.*t30.*2.0-mLeg.*rArm.*rBodyMCD.*rLegMCD.*t2.*t18.*t28.*t31.*2.0-mArm.*mBody.*mLeg.*rArm.*rArmMCD.*rBody.*t2.*t3.*t28-mArm.*mBody.*mLeg.*rArm.*rArmMCD.*rBodyMCD.*t2.*t3.*t28-mArm.*mBody.*mLeg.*rArm.*rBody.*rBodyMCD.*t3.*t27.*t28.*2.0-mArm.*mBody.*mLeg.*rArm.*rArmMCD.*rLegMCD.*t2.*t3.*t31-mArm.*mBody.*mLeg.*rArm.*rBodyMCD.*rLegMCD.*t3.*t27.*t31-mArm.*mBody.*mLeg.*rArm.*rBodyMCD.*rLegMCD.*t3.*t28.*t30+mArm.*mBody.*mLeg.*rArmMCD.*rBodyMCD.*rLegMCD.*t3.*t27.*t31+mArm.*mBody.*mLeg.*rArmMCD.*rBodyMCD.*rLegMCD.*t3.*t28.*t30)+t268.*(-g.*mArm-g.*mBody-g.*mLeg+ddthShoulder.*mBody.*rBodyMCD.*t28+ddthShoulder.*mLeg.*rBody.*t28+ddthWaist.*mLeg.*rLegMCD.*t31+ddthShoulder.*mLeg.*rLegMCD.*t31+mArm.*rArmMCD.*t2.*t14+mBody.*rArm.*t2.*t14+mBody.*rBodyMCD.*t14.*t27+mBody.*rBodyMCD.*t16.*t27+mLeg.*rArm.*t2.*t14+mLeg.*rBody.*t14.*t27+mLeg.*rBody.*t16.*t27+mLeg.*rLegMCD.*t14.*t30+mLeg.*rLegMCD.*t15.*t30+mLeg.*rLegMCD.*t16.*t30+dthHand.*dthShoulder.*mBody.*rBodyMCD.*t27.*2.0+dthHand.*dthShoulder.*mLeg.*rBody.*t27.*2.0+dthHand.*dthWaist.*mLeg.*rLegMCD.*t30.*2.0+dthHand.*dthShoulder.*mLeg.*rLegMCD.*t30.*2.0+dthWaist.*dthShoulder.*mLeg.*rLegMCD.*t30.*2.0).*(rArm.*t3.*t35+rArm.*t3.*t37+rArm.*t3.*t38+rArm.*t3.*t40+rArm.*t3.*t47+rArm.*t3.*t49+rArm.*t3.*t159+rArm.*t3.*t161+rArm.*t3.*t163+rArm.*t3.*t164+rArm.*t3.*t165+rArm.*t3.*t166+rArm.*t3.*t175+rArm.*t3.*t176+rArm.*t3.*t177+rArm.*t3.*t178+rArm.*t3.*t188+rArm.*t3.*t221+rArm.*t3.*t223+rArm.*t3.*t224+rArm.*t3.*t228+rArm.*t3.*t229+rArmMCD.*t3.*t32+rArm.*t3.*t246+rArmMCD.*t3.*t34+rArm.*t3.*t248+rArm.*t3.*t249+rArm.*t3.*t257+rArm.*t3.*t258+rArm.*t3.*t261+rArmMCD.*t3.*t160+rArmMCD.*t3.*t162+rArmMCD.*t3.*t171+rArmMCD.*t3.*t172+rArmMCD.*t3.*t173+rArmMCD.*t3.*t174+rArmMCD.*t3.*t183+rArmMCD.*t3.*t222+rArmMCD.*t3.*t226+rArmMCD.*t3.*t227+rArmMCD.*t3.*t247+rArmMCD.*t3.*t254-rBody.*t28.*t39-rBody.*t28.*t81-rBody.*t28.*t83-rBody.*t28.*t93-rBody.*t28.*t94+rBody.*t28.*t97-rBodyMCD.*t28.*t36-rBodyMCD.*t28.*t77-rBodyMCD.*t28.*t79-rBodyMCD.*t28.*t89-rBodyMCD.*t28.*t90+rBodyMCD.*t28.*t95+rBodyMCD.*t28.*t111-rLegMCD.*t31.*t39-rLegMCD.*t31.*t81-rLegMCD.*t31.*t83-rLegMCD.*t31.*t93-rLegMCD.*t31.*t94+rLegMCD.*t31.*t97+rLegMCD.*t31.*t114+rLegMCD.*t31.*t116+rLegMCD.*t31.*t154+rLegMCD.*t31.*t155+mBody.*rArm.*t3.*t7+mBody.*rArm.*t3.*t8+mBody.*rArm.*t3.*t66+mBody.*rArm.*t3.*t72+mBody.*rArm.*t3.*t121+mBody.*rArm.*t3.*t126+mBody.*rArm.*t3.*t218+mBody.*rArmMCD.*t3.*t7+mBody.*rArmMCD.*t3.*t8+mBody.*rArmMCD.*t3.*t66+mBody.*rArmMCD.*t3.*t72+mBody.*rArmMCD.*t3.*t121+mBody.*rArmMCD.*t3.*t126+mBody.*rArmMCD.*t3.*t218+mLeg.*rArm.*t3.*t7+mLeg.*rArm.*t3.*t8+mLeg.*rArm.*t3.*t65+mLeg.*rArm.*t3.*t71+mLeg.*rArmMCD.*t3.*t7+mLeg.*rArmMCD.*t3.*t8+mLeg.*rArmMCD.*t3.*t65+mLeg.*rArmMCD.*t3.*t71-InertiaArm.*mArm.*mBody.*rBodyMCD.*t28-InertiaArm.*mArm.*mLeg.*rBody.*t28-InertiaArm.*mBody.*mLeg.*rBody.*t28-InertiaArm.*mBody.*mLeg.*rBodyMCD.*t28-InertiaArm.*mArm.*mLeg.*rLegMCD.*t31-InertiaArm.*mBody.*mLeg.*rLegMCD.*t31-mArm.*mBody.*mLeg.*rBody.*t20.*t25.*t28-mArm.*mBody.*mLeg.*rBody.*t21.*t25.*t28-mArm.*mBody.*mLeg.*rBody.*t21.*t26.*t28-mArm.*mBody.*mLeg.*rBodyMCD.*t20.*t25.*t28-mArm.*mBody.*mLeg.*rBodyMCD.*t21.*t25.*t28-mArm.*mBody.*mLeg.*rBodyMCD.*t21.*t26.*t28-mArm.*mBody.*mLeg.*rLegMCD.*t20.*t25.*t31-mArm.*mBody.*mLeg.*rLegMCD.*t21.*t25.*t31-mArm.*mBody.*mLeg.*rLegMCD.*t21.*t26.*t31+mArm.*rArm.*rArmMCD.*rBody.*t19.*t26.*t28+mArm.*rArm.*rArmMCD.*rBodyMCD.*t18.*t26.*t28+mBody.*rArm.*rArmMCD.*rBodyMCD.*t17.*t26.*t28-mBody.*rArm.*rBody.*rBodyMCD.*t3.*t19.*t51.*2.0-mBody.*rArm.*rBody.*rBodyMCD.*t3.*t19.*t52.*2.0+mArm.*rArm.*rArmMCD.*rLegMCD.*t19.*t26.*t31+mLeg.*rArm.*rArmMCD.*rBody.*t17.*t26.*t28-mLeg.*rArm.*rBody.*rBodyMCD.*t3.*t18.*t51.*2.0-mLeg.*rArm.*rBody.*rBodyMCD.*t3.*t18.*t52.*2.0+mLeg.*rArm.*rArmMCD.*rLegMCD.*t17.*t26.*t31-mArm.*rArm.*t2.*t18.*t23.*t27.*t28-mArm.*rArm.*t2.*t19.*t22.*t27.*t28-mArm.*rArm.*t2.*t19.*t24.*t30.*t31+mArm.*rArmMCD.*t2.*t18.*t23.*t27.*t28+mArm.*rArmMCD.*t2.*t19.*t22.*t27.*t28+mArm.*rArmMCD.*t2.*t19.*t24.*t30.*t31+mArm.*rBody.*t2.*t3.*t19.*t20.*t27+mArm.*rBodyMCD.*t2.*t3.*t18.*t20.*t27-mBody.*rBodyMCD.*t2.*t3.*t17.*t21.*t27+mArm.*rLegMCD.*t2.*t3.*t19.*t20.*t30-mLeg.*rBody.*t2.*t3.*t17.*t21.*t27-mLeg.*rLegMCD.*t2.*t3.*t17.*t21.*t30+mArm.*mBody.*mLeg.*rArm.*rArmMCD.*rBody.*t25.*t28.*2.0+mArm.*mBody.*mLeg.*rArm.*rArmMCD.*rBody.*t26.*t28+mArm.*mBody.*mLeg.*rArm.*rArmMCD.*rBodyMCD.*t25.*t28.*2.0+mArm.*mBody.*mLeg.*rArm.*rArmMCD.*rBodyMCD.*t26.*t28+mArm.*mBody.*mLeg.*rArm.*rArmMCD.*rLegMCD.*t25.*t31.*2.0+mArm.*mBody.*mLeg.*rArm.*rArmMCD.*rLegMCD.*t26.*t31+mArm.*mBody.*mLeg.*rBody.*t2.*t3.*t20.*t27+mArm.*mBody.*mLeg.*rBodyMCD.*t2.*t3.*t20.*t27+mArm.*mBody.*mLeg.*rLegMCD.*t2.*t3.*t20.*t30-mArm.*rArm.*rArmMCD.*rBody.*t2.*t3.*t19.*t27-mArm.*rArm.*rArmMCD.*rBodyMCD.*t2.*t3.*t18.*t27+mBody.*rArm.*rArmMCD.*rBodyMCD.*t2.*t3.*t17.*t27-mArm.*rArm.*rArmMCD.*rLegMCD.*t2.*t3.*t19.*t30+mLeg.*rArm.*rArmMCD.*rBody.*t2.*t3.*t17.*t27-mArm.*rArm.*rBody.*rLegMCD.*t2.*t19.*t27.*t31-mArm.*rArm.*rBody.*rLegMCD.*t2.*t19.*t28.*t30+mArm.*rArmMCD.*rBody.*rLegMCD.*t2.*t19.*t27.*t31+mArm.*rArmMCD.*rBody.*rLegMCD.*t2.*t19.*t28.*t30-mBody.*rArm.*rBodyMCD.*rLegMCD.*t3.*t19.*t27.*t30.*2.0-mBody.*rArm.*rBodyMCD.*rLegMCD.*t3.*t19.*t28.*t31.*2.0+mLeg.*rArm.*rArmMCD.*rLegMCD.*t2.*t3.*t17.*t30-mLeg.*rArm.*rBodyMCD.*rLegMCD.*t3.*t18.*t27.*t30.*2.0-mLeg.*rArm.*rBodyMCD.*rLegMCD.*t3.*t18.*t28.*t31.*2.0-mArm.*mBody.*mLeg.*rArm.*rArmMCD.*rBody.*t2.*t3.*t27-mArm.*mBody.*mLeg.*rArm.*rArmMCD.*rBodyMCD.*t2.*t3.*t27-mArm.*mBody.*mLeg.*rArm.*rBody.*rBodyMCD.*t2.*t27.*t28.*2.0-mArm.*mBody.*mLeg.*rArm.*rArmMCD.*rLegMCD.*t2.*t3.*t30-mArm.*mBody.*mLeg.*rArm.*rBodyMCD.*rLegMCD.*t2.*t27.*t31-mArm.*mBody.*mLeg.*rArm.*rBodyMCD.*rLegMCD.*t2.*t28.*t30+mArm.*mBody.*mLeg.*rArmMCD.*rBodyMCD.*rLegMCD.*t2.*t27.*t31+mArm.*mBody.*mLeg.*rArmMCD.*rBodyMCD.*rLegMCD.*t2.*t28.*t30)-((t7+t8+t9+t10+t11+t12+t65+t66+t67+t68+t71+t72+t73+t74+t113+t118+t121+t122+t126+t127+t196+t197+t218+t219+t230+t245+mArm.*mBody.*rArm.*rBodyMCD.*t2.*t27+mArm.*mBody.*rArm.*rBodyMCD.*t3.*t28-mArm.*mBody.*rArmMCD.*rBodyMCD.*t2.*t27-mArm.*mBody.*rArmMCD.*rBodyMCD.*t3.*t28+mArm.*mLeg.*rArm.*rBody.*t2.*t27+mArm.*mLeg.*rArm.*rBody.*t3.*t28-mArm.*mLeg.*rArmMCD.*rBody.*t2.*t27-mArm.*mLeg.*rArmMCD.*rBody.*t3.*t28+mArm.*mLeg.*rArm.*rLegMCD.*t2.*t30+mArm.*mLeg.*rArm.*rLegMCD.*t3.*t31-mArm.*mLeg.*rArmMCD.*rLegMCD.*t2.*t30-mArm.*mLeg.*rArmMCD.*rLegMCD.*t3.*t31).*(t4+t5+t6+t63+t64+t69+t70+t107+t108+t119+t120+t123+t124+t137+t158+t189+t190+t217+t231+t233+t235+t252+t253+t264+g.*mArm.*rArmMCD.*t56+g.*mBody.*rArm.*t56+g.*mLeg.*rArm.*t56-mBody.*rArm.*rBodyMCD.*t2.*t16.*t28+mBody.*rArm.*rBodyMCD.*t3.*t16.*t27-mLeg.*rArm.*rBody.*t2.*t16.*t28+mLeg.*rArm.*rBody.*t3.*t16.*t27-mLeg.*rArm.*rLegMCD.*t2.*t15.*t31+mLeg.*rArm.*rLegMCD.*t3.*t15.*t30-mLeg.*rArm.*rLegMCD.*t2.*t16.*t31+mLeg.*rArm.*rLegMCD.*t3.*t16.*t30+ddthShoulder.*mBody.*rArm.*rBodyMCD.*t2.*t27+ddthShoulder.*mBody.*rArm.*rBodyMCD.*t3.*t28+ddthShoulder.*mLeg.*rArm.*rBody.*t2.*t27+ddthShoulder.*mLeg.*rArm.*rBody.*t3.*t28+ddthWaist.*mLeg.*rArm.*rLegMCD.*t2.*t30+ddthWaist.*mLeg.*rArm.*rLegMCD.*t3.*t31+ddthShoulder.*mLeg.*rArm.*rLegMCD.*t2.*t30+ddthShoulder.*mLeg.*rArm.*rLegMCD.*t3.*t31-dthHand.*dthShoulder.*mBody.*rArm.*rBodyMCD.*t2.*t28.*2.0+dthHand.*dthShoulder.*mBody.*rArm.*rBodyMCD.*t3.*t27.*2.0-dthHand.*dthShoulder.*mLeg.*rArm.*rBody.*t2.*t28.*2.0+dthHand.*dthShoulder.*mLeg.*rArm.*rBody.*t3.*t27.*2.0-dthHand.*dthWaist.*mLeg.*rArm.*rLegMCD.*t2.*t31.*2.0+dthHand.*dthWaist.*mLeg.*rArm.*rLegMCD.*t3.*t30.*2.0-dthHand.*dthShoulder.*mLeg.*rArm.*rLegMCD.*t2.*t31.*2.0+dthHand.*dthShoulder.*mLeg.*rArm.*rLegMCD.*t3.*t30.*2.0-dthWaist.*dthShoulder.*mLeg.*rArm.*rLegMCD.*t2.*t31.*2.0+dthWaist.*dthShoulder.*mLeg.*rArm.*rLegMCD.*t3.*t30.*2.0))./(t7+t8+t9+t10+t11+t12+t65+t66+t67+t68+t71+t72+t73+t74+t113+t118+t121+t122+t126+t127+t196+t197+t218+t219+t230+t245+InertiaArm.*mArm+InertiaArm.*mBody+InertiaArm.*mLeg+mArm.*mBody.*t20.*t25+mArm.*mBody.*t20.*t26+mArm.*mBody.*t21.*t25+mArm.*mBody.*t21.*t26+mArm.*mLeg.*t20.*t25+mArm.*mLeg.*t20.*t26+mArm.*mLeg.*t21.*t25+mArm.*mLeg.*t21.*t26-mArm.*mBody.*rArm.*rArmMCD.*t25.*2.0-mArm.*mBody.*rArm.*rArmMCD.*t26.*2.0-mArm.*mLeg.*rArm.*rArmMCD.*t25.*2.0-mArm.*mLeg.*rArm.*rArmMCD.*t26.*2.0+mArm.*mBody.*rArm.*rBodyMCD.*t2.*t27.*2.0+mArm.*mBody.*rArm.*rBodyMCD.*t3.*t28.*2.0-mArm.*mBody.*rArmMCD.*rBodyMCD.*t2.*t27.*2.0-mArm.*mBody.*rArmMCD.*rBodyMCD.*t3.*t28.*2.0+mArm.*mLeg.*rArm.*rBody.*t2.*t27.*2.0+mArm.*mLeg.*rArm.*rBody.*t3.*t28.*2.0-mArm.*mLeg.*rArmMCD.*rBody.*t2.*t27.*2.0-mArm.*mLeg.*rArmMCD.*rBody.*t3.*t28.*2.0+mArm.*mLeg.*rArm.*rLegMCD.*t2.*t30.*2.0+mArm.*mLeg.*rArm.*rLegMCD.*t3.*t31.*2.0-mArm.*mLeg.*rArmMCD.*rLegMCD.*t2.*t30.*2.0-mArm.*mLeg.*rArmMCD.*rLegMCD.*t3.*t31.*2.0)+mBody.*rArm.*rBodyMCD.*t2.*t14.*t28-mBody.*rArm.*rBodyMCD.*t3.*t14.*t27+mLeg.*rArm.*rBody.*t2.*t14.*t28-mLeg.*rArm.*rBody.*t3.*t14.*t27+mLeg.*rArm.*rLegMCD.*t2.*t14.*t31-mLeg.*rArm.*rLegMCD.*t3.*t14.*t30;
