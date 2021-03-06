function ddthShoulder = find_ddthShoulder(InertiaLeg,InertiaArm,InertiaBody,MrPB,MthHand,MthWaist,MthShoulder,dthHand,dthWaist,dthShoulder,g,kPB,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,rPB,thHand,thShoulder,thWaist)
%FIND_DDTHSHOULDER
%    DDTHSHOULDER = FIND_DDTHSHOULDER(INERTIALEG,INERTIAARM,INERTIABODY,MRPB,MTHHAND,MTHWAIST,MTHSHOULDER,DTHHAND,DTHWAIST,DTHSHOULDER,G,KPB,MARM,MBODY,MLEG,MPB,RARM,RARMMCD,RBODY,RBODYMCD,RLEGMCD,RPB,THHAND,THSHOULDER,THWAIST)

%    This function was generated by the Symbolic Math Toolbox version 8.5.
%    25-May-2020 19:55:39

t2 = cos(thHand);
t3 = sin(thHand);
t4 = thHand+thShoulder;
t5 = dthHand.^2;
t6 = dthWaist.^2;
t7 = dthShoulder.^2;
t8 = mArm.^2;
t9 = mBody.^2;
t10 = mLeg.^2;
t11 = rArm.^2;
t12 = rArmMCD.^2;
t13 = rBody.^2;
t14 = rBodyMCD.^2;
t15 = rLegMCD.^2;
t18 = InertiaLeg.*InertiaArm.*mArm;
t19 = InertiaLeg.*InertiaBody.*mArm;
t20 = InertiaLeg.*InertiaArm.*mBody;
t21 = InertiaLeg.*InertiaBody.*mBody;
t22 = InertiaLeg.*InertiaArm.*mLeg;
t23 = InertiaLeg.*InertiaBody.*mLeg;
t24 = InertiaLeg.*InertiaArm.*mPB;
t25 = InertiaLeg.*InertiaBody.*mPB;
t35 = pi./2.0;
t16 = t2.^2;
t17 = t3.^2;
t26 = cos(t4);
t27 = sin(t4);
t28 = t4+thWaist;
t31 = InertiaBody.*t18;
t32 = InertiaBody.*t20;
t33 = InertiaBody.*t22;
t34 = InertiaBody.*t24;
t38 = InertiaLeg.*mArm.*mBody.*t12;
t39 = InertiaLeg.*mArm.*mLeg.*t12;
t40 = InertiaLeg.*mArm.*mPB.*t12;
t42 = t35+thHand;
t44 = InertiaLeg.*t8.*t12;
t45 = mBody.*t12.*t19;
t46 = mLeg.*t12.*t19;
t47 = mPB.*t12.*t19;
t49 = t4+t35;
t29 = cos(t28);
t30 = sin(t28);
t36 = t26.^2;
t37 = t27.^2;
t48 = cos(t42);
t50 = cos(t49);
t51 = t28+t35;
t52 = InertiaBody.*t44;
t54 = InertiaLeg.*mArm.*mBody.*t11.*t16;
t55 = InertiaLeg.*mArm.*mLeg.*t11.*t16;
t56 = InertiaLeg.*mBody.*mPB.*t11.*t16;
t57 = InertiaLeg.*mLeg.*mPB.*t11.*t16;
t58 = InertiaLeg.*mArm.*mBody.*t11.*t17;
t59 = InertiaLeg.*mArm.*mLeg.*t11.*t17;
t60 = InertiaLeg.*mBody.*mPB.*t11.*t17;
t61 = InertiaLeg.*mLeg.*mPB.*t11.*t17;
t62 = InertiaLeg.*mArm.*mBody.*rArm.*rArmMCD.*t17.*2.0;
t63 = InertiaLeg.*mArm.*mLeg.*rArm.*rArmMCD.*t17.*2.0;
t64 = InertiaLeg.*mArm.*mBody.*rArm.*rBodyMCD.*t3.*t27;
t65 = InertiaLeg.*mArm.*mBody.*rArmMCD.*rBodyMCD.*t3.*t27;
t66 = InertiaLeg.*mArm.*mLeg.*rArm.*rBody.*t3.*t27;
t67 = InertiaLeg.*mArm.*mLeg.*rArmMCD.*rBody.*t3.*t27;
t68 = InertiaLeg.*mBody.*mPB.*rArm.*rBodyMCD.*t3.*t27;
t69 = InertiaLeg.*mLeg.*mPB.*rArm.*rBody.*t3.*t27;
t70 = InertiaLeg.*t9.*t11.*t16;
t71 = InertiaLeg.*t10.*t11.*t16;
t72 = InertiaLeg.*mBody.*mLeg.*t11.*t16.*2.0;
t73 = t17.*t44;
t76 = mBody.*t11.*t16.*t19;
t77 = mLeg.*t11.*t16.*t19;
t78 = mPB.*t11.*t16.*t21;
t79 = mPB.*t11.*t16.*t23;
t80 = mBody.*t11.*t17.*t19;
t81 = mLeg.*t11.*t17.*t19;
t82 = mPB.*t11.*t17.*t21;
t83 = mPB.*t11.*t17.*t23;
t84 = InertiaLeg.*mArm.*mBody.*rArm.*rBodyMCD.*t2.*t26;
t85 = InertiaLeg.*mArm.*mLeg.*rArm.*rBody.*t2.*t26;
t86 = InertiaLeg.*mBody.*mLeg.*rArm.*rBody.*t2.*t26;
t87 = InertiaLeg.*mBody.*mLeg.*rArm.*rBodyMCD.*t2.*t26;
t88 = InertiaLeg.*mBody.*mPB.*rArm.*rBodyMCD.*t2.*t26;
t89 = InertiaLeg.*mLeg.*mPB.*rArm.*rBody.*t2.*t26;
t90 = mBody.*rArm.*rArmMCD.*t17.*t19.*2.0;
t91 = mLeg.*rArm.*rArmMCD.*t17.*t19.*2.0;
t109 = mLeg.*t11.*t16.*t21.*2.0;
t111 = InertiaLeg.*rArm.*rBodyMCD.*t2.*t9.*t26;
t112 = InertiaLeg.*rArm.*rBody.*t2.*t10.*t26;
t327 = InertiaLeg.*mArm.*mBody.*mLeg.*rBody.*rBodyMCD.*t2.*t3.*t11.*t26.*t27.*4.0;
t328 = InertiaLeg.*mBody.*mLeg.*mPB.*rBody.*rBodyMCD.*t2.*t3.*t11.*t26.*t27.*4.0;
t356 = InertiaLeg.*mArm.*rArm.*rArmMCD.*t2.*t3.*t9.*t14.*t26.*t27.*2.0;
t357 = InertiaLeg.*mArm.*rArm.*rArmMCD.*t2.*t3.*t10.*t13.*t26.*t27.*2.0;
t390 = InertiaLeg.*mArm.*t2.*t3.*t9.*t11.*t14.*t26.*t27.*2.0;
t391 = InertiaLeg.*mArm.*t2.*t3.*t10.*t11.*t13.*t26.*t27.*2.0;
t392 = InertiaLeg.*mPB.*t2.*t3.*t9.*t11.*t14.*t26.*t27.*2.0;
t393 = InertiaLeg.*mPB.*t2.*t3.*t10.*t11.*t13.*t26.*t27.*2.0;
t41 = t29.^2;
t43 = t30.^2;
t53 = cos(t51);
t74 = -t62;
t75 = -t63;
t92 = g.*mBody.*rBodyMCD.*t50;
t93 = g.*mLeg.*rBody.*t50;
t94 = InertiaLeg.*mArm.*mBody.*t14.*t36;
t95 = InertiaLeg.*mArm.*mLeg.*t13.*t36;
t96 = InertiaLeg.*mBody.*mLeg.*t13.*t36;
t97 = InertiaLeg.*mBody.*mLeg.*t14.*t36;
t98 = InertiaLeg.*mBody.*mPB.*t14.*t36;
t99 = InertiaLeg.*mLeg.*mPB.*t13.*t36;
t100 = InertiaLeg.*mArm.*mBody.*t14.*t37;
t101 = InertiaLeg.*mArm.*mLeg.*t13.*t37;
t102 = InertiaLeg.*mBody.*mLeg.*t13.*t37;
t103 = InertiaLeg.*mBody.*mLeg.*t14.*t37;
t104 = InertiaLeg.*mBody.*mPB.*t14.*t37;
t105 = InertiaLeg.*mLeg.*mPB.*t13.*t37;
t106 = InertiaLeg.*mBody.*mLeg.*rBody.*rBodyMCD.*t37.*2.0;
t107 = InertiaBody.*t70;
t108 = InertiaBody.*t71;
t110 = t17.*t52;
t113 = -t90;
t114 = -t91;
t115 = -t65;
t116 = -t67;
t117 = InertiaLeg.*t9.*t14.*t36;
t118 = InertiaLeg.*t10.*t13.*t36;
t120 = mLeg.*rArm.*rLegMCD.*t3.*t5.*t29;
t121 = mLeg.*rArm.*rLegMCD.*t2.*t5.*t30;
t123 = -t73;
t124 = mBody.*t14.*t18.*t36;
t125 = mLeg.*t13.*t18.*t36;
t126 = mLeg.*t13.*t20.*t36;
t127 = mLeg.*t14.*t20.*t36;
t128 = mPB.*t14.*t20.*t36;
t129 = mPB.*t13.*t22.*t36;
t130 = mBody.*t14.*t18.*t37;
t131 = mLeg.*t13.*t18.*t37;
t132 = mLeg.*t13.*t20.*t37;
t133 = mLeg.*t14.*t20.*t37;
t134 = mPB.*t14.*t20.*t37;
t135 = mPB.*t13.*t22.*t37;
t136 = mLeg.*rBody.*rBodyMCD.*t20.*t37.*2.0;
t162 = mLeg.*rBody.*rLegMCD.*t6.*t27.*t29;
t163 = mLeg.*rBody.*rLegMCD.*t6.*t26.*t30;
t164 = dthHand.*dthWaist.*mLeg.*rBody.*rLegMCD.*t27.*t29.*2.0;
t165 = dthHand.*dthWaist.*mLeg.*rBody.*rLegMCD.*t26.*t30.*2.0;
t166 = dthWaist.*dthShoulder.*mLeg.*rBody.*rLegMCD.*t27.*t29.*2.0;
t167 = dthWaist.*dthShoulder.*mLeg.*rBody.*rLegMCD.*t26.*t30.*2.0;
t170 = mLeg.*t13.*t36.*t38;
t171 = mLeg.*t14.*t36.*t38;
t172 = mPB.*t14.*t36.*t38;
t173 = mPB.*t13.*t36.*t39;
t174 = mLeg.*t13.*t37.*t38;
t175 = mLeg.*t14.*t37.*t38;
t176 = mPB.*t14.*t37.*t38;
t177 = mPB.*t13.*t37.*t39;
t178 = mLeg.*rBody.*rBodyMCD.*t37.*t38.*2.0;
t189 = mBody.*t14.*t36.*t44;
t191 = mLeg.*t13.*t36.*t44;
t192 = mBody.*t14.*t37.*t44;
t193 = mLeg.*t13.*t37.*t44;
t201 = InertiaLeg.*mArm.*mBody.*mLeg.*rArm.*rArmMCD.*rBody.*rBodyMCD.*t17.*t37.*4.0;
t204 = mLeg.*t13.*t37.*t62;
t205 = mLeg.*t14.*t37.*t62;
t206 = mLeg.*rBody.*rBodyMCD.*t37.*t58.*2.0;
t207 = mLeg.*rBody.*rBodyMCD.*t37.*t60.*2.0;
t216 = mLeg.*t13.*t36.*t54;
t217 = mLeg.*t14.*t36.*t54;
t218 = mLeg.*t13.*t36.*t56;
t219 = mLeg.*t14.*t36.*t56;
t220 = mLeg.*t13.*t36.*t58;
t221 = mLeg.*t13.*t37.*t54;
t222 = mLeg.*t14.*t36.*t58;
t223 = mLeg.*t14.*t37.*t54;
t224 = mLeg.*t13.*t36.*t60;
t225 = mLeg.*t13.*t37.*t56;
t226 = mLeg.*t14.*t36.*t60;
t227 = mLeg.*t14.*t37.*t56;
t228 = mLeg.*rBody.*rBodyMCD.*t36.*t54.*2.0;
t229 = mLeg.*rBody.*rBodyMCD.*t36.*t56.*2.0;
t230 = mLeg.*t13.*t37.*t58;
t231 = mLeg.*t14.*t37.*t58;
t232 = mLeg.*t13.*t37.*t60;
t233 = mLeg.*t14.*t37.*t60;
t234 = mLeg.*t13.*t36.*t62;
t235 = mLeg.*t14.*t36.*t62;
t271 = mBody.*t13.*t36.*t71;
t272 = mLeg.*t13.*t36.*t70;
t273 = mBody.*t14.*t36.*t71;
t274 = mLeg.*t14.*t36.*t70;
t276 = mArm.*t14.*t37.*t70;
t277 = mBody.*t14.*t36.*t73;
t279 = mArm.*t13.*t37.*t71;
t280 = mLeg.*t13.*t36.*t73;
t281 = mBody.*t13.*t37.*t71;
t282 = mLeg.*t13.*t37.*t70;
t283 = mBody.*t14.*t37.*t71;
t284 = mLeg.*t14.*t37.*t70;
t286 = mPB.*t14.*t37.*t70;
t288 = mPB.*t13.*t37.*t71;
t289 = mBody.*rBody.*rBodyMCD.*t36.*t71.*2.0;
t290 = mLeg.*rBody.*rBodyMCD.*t36.*t70.*2.0;
t291 = mLeg.*rArmMCD.*rBody.*t2.*t26.*t64.*4.0;
t292 = mBody.*t14.*t37.*t73;
t293 = mLeg.*t13.*t37.*t73;
t298 = mBody.*rBody.*rBodyMCD.*t37.*t71.*2.0;
t299 = mLeg.*rBody.*rBodyMCD.*t37.*t70.*2.0;
t360 = -t327;
t361 = -t328;
t388 = mArm.*rArm.*rArmMCD.*t2.*t3.*t10.*t15.*t29.*t30.*2.0;
t395 = mArm.*rArm.*rBody.*t3.*t10.*t15.*t26.*t29.*t30;
t396 = mArm.*rArm.*rBody.*t2.*t10.*t15.*t27.*t29.*t30;
t397 = mArm.*rArmMCD.*rBody.*t3.*t10.*t15.*t26.*t29.*t30;
t398 = mBody.*rArm.*rBody.*t2.*t10.*t15.*t27.*t29.*t30;
t399 = mBody.*rArm.*rBodyMCD.*t2.*t10.*t15.*t27.*t29.*t30;
t400 = mPB.*rArm.*rBody.*t3.*t10.*t15.*t26.*t29.*t30;
t401 = mPB.*rArm.*rBody.*t2.*t10.*t15.*t27.*t29.*t30;
t403 = mArm.*t2.*t3.*t10.*t11.*t15.*t29.*t30.*2.0;
t404 = mPB.*t2.*t3.*t10.*t11.*t15.*t29.*t30.*2.0;
t406 = -t390;
t407 = -t391;
t408 = -t392;
t409 = -t393;
t436 = InertiaBody.*mArm.*t2.*t3.*t10.*t11.*t15.*t29.*t30.*-2.0;
t437 = InertiaBody.*mPB.*t2.*t3.*t10.*t11.*t15.*t29.*t30.*-2.0;
t438 = mBody.*rBody.*rBodyMCD.*t10.*t15.*t26.*t27.*t29.*t30.*2.0;
t443 = mArm.*t10.*t13.*t15.*t26.*t27.*t29.*t30.*2.0;
t444 = mBody.*t10.*t13.*t15.*t26.*t27.*t29.*t30.*2.0;
t445 = mPB.*t10.*t13.*t15.*t26.*t27.*t29.*t30.*2.0;
t453 = InertiaArm.*mArm.*t10.*t13.*t15.*t26.*t27.*t29.*t30.*-2.0;
t454 = InertiaArm.*mBody.*t10.*t13.*t15.*t26.*t27.*t29.*t30.*-2.0;
t455 = InertiaArm.*mPB.*t10.*t13.*t15.*t26.*t27.*t29.*t30.*-2.0;
t533 = t8.*t10.*t12.*t13.*t15.*t26.*t27.*t29.*t30.*2.0;
t536 = mArm.*mBody.*t10.*t12.*t13.*t15.*t26.*t27.*t29.*t30.*-2.0;
t537 = mArm.*mPB.*t10.*t12.*t13.*t15.*t26.*t27.*t29.*t30.*-2.0;
t550 = mArm.*mBody.*rArm.*rArmMCD.*rBody.*rBodyMCD.*t2.*t3.*t10.*t15.*t29.*t30.*t36.*-2.0;
t551 = mArm.*mBody.*rArm.*rArmMCD.*rBody.*rBodyMCD.*t2.*t3.*t10.*t15.*t29.*t30.*t37.*-2.0;
t559 = mArm.*mBody.*rArm.*rArmMCD.*rBody.*rBodyMCD.*t10.*t15.*t17.*t26.*t27.*t29.*t30.*4.0;
t564 = mArm.*mBody.*rArm.*rArmMCD.*t10.*t13.*t15.*t17.*t26.*t27.*t29.*t30.*4.0;
t567 = mArm.*mBody.*t2.*t3.*t10.*t11.*t14.*t15.*t29.*t30.*t36.*-2.0;
t568 = mBody.*mPB.*t2.*t3.*t10.*t11.*t14.*t15.*t29.*t30.*t36.*-2.0;
t570 = mArm.*mBody.*t2.*t3.*t10.*t11.*t14.*t15.*t29.*t30.*t37.*-2.0;
t571 = mBody.*mPB.*t2.*t3.*t10.*t11.*t14.*t15.*t29.*t30.*t37.*-2.0;
t574 = rBody.*rBodyMCD.*t9.*t10.*t11.*t15.*t16.*t26.*t27.*t29.*t30.*4.0;
t577 = t9.*t10.*t11.*t13.*t15.*t16.*t26.*t27.*t29.*t30.*2.0;
t578 = t9.*t10.*t11.*t14.*t15.*t16.*t26.*t27.*t29.*t30.*2.0;
t579 = mArm.*mBody.*t10.*t11.*t13.*t15.*t16.*t26.*t27.*t29.*t30.*-2.0;
t580 = mBody.*mPB.*t10.*t11.*t13.*t15.*t16.*t26.*t27.*t29.*t30.*-2.0;
t582 = mArm.*mBody.*t10.*t11.*t13.*t15.*t17.*t26.*t27.*t29.*t30.*-2.0;
t583 = mBody.*mPB.*t10.*t11.*t13.*t15.*t17.*t26.*t27.*t29.*t30.*-2.0;
t119 = g.*mLeg.*rLegMCD.*t53;
t122 = -t106;
t137 = InertiaArm.*mArm.*mLeg.*t15.*t41;
t138 = InertiaBody.*mArm.*mLeg.*t15.*t41;
t139 = InertiaArm.*mBody.*mLeg.*t15.*t41;
t140 = InertiaBody.*mBody.*mLeg.*t15.*t41;
t141 = InertiaArm.*mLeg.*mPB.*t15.*t41;
t142 = InertiaBody.*mLeg.*mPB.*t15.*t41;
t143 = InertiaArm.*mArm.*mLeg.*t15.*t43;
t144 = InertiaBody.*mArm.*mLeg.*t15.*t43;
t145 = InertiaArm.*mBody.*mLeg.*t15.*t43;
t146 = InertiaBody.*mBody.*mLeg.*t15.*t43;
t147 = InertiaArm.*mLeg.*mPB.*t15.*t43;
t148 = InertiaBody.*mLeg.*mPB.*t15.*t43;
t155 = InertiaArm.*t117;
t156 = InertiaArm.*t118;
t157 = InertiaArm.*t10.*t15.*t41;
t158 = InertiaBody.*t10.*t15.*t41;
t159 = -t136;
t160 = -t110;
t168 = -t165;
t169 = -t167;
t179 = mArm.*mBody.*mLeg.*t12.*t15.*t41;
t180 = mArm.*mLeg.*mPB.*t12.*t15.*t41;
t181 = mArm.*mBody.*mLeg.*t12.*t15.*t43;
t182 = mArm.*mLeg.*mPB.*t12.*t15.*t43;
t187 = -t163;
t188 = mArm.*t12.*t117;
t190 = mArm.*t12.*t118;
t194 = mArm.*t10.*t12.*t15.*t41;
t195 = mLeg.*t8.*t12.*t15.*t41;
t196 = -t178;
t197 = mLeg.*t8.*t12.*t15.*t43;
t202 = mArm.*mBody.*mLeg.*t11.*t15.*t16.*t41;
t203 = mBody.*mLeg.*mPB.*t11.*t15.*t16.*t41;
t208 = mArm.*mBody.*mLeg.*t11.*t15.*t17.*t41;
t209 = mArm.*mBody.*mLeg.*t11.*t15.*t16.*t43;
t210 = mBody.*mLeg.*mPB.*t11.*t15.*t17.*t41;
t211 = mBody.*mLeg.*mPB.*t11.*t15.*t16.*t43;
t212 = mArm.*mBody.*mLeg.*t11.*t15.*t17.*t43;
t213 = mBody.*mLeg.*mPB.*t11.*t15.*t17.*t43;
t214 = mArm.*mBody.*mLeg.*rArm.*rArmMCD.*t15.*t17.*t41.*2.0;
t215 = mArm.*mBody.*mLeg.*rArm.*rArmMCD.*t15.*t17.*t43.*2.0;
t236 = mArm.*t10.*t11.*t15.*t17.*t41;
t237 = mArm.*t10.*t11.*t15.*t16.*t43;
t239 = mBody.*t10.*t11.*t15.*t16.*t43;
t240 = mLeg.*t9.*t11.*t15.*t16.*t43;
t241 = mPB.*t10.*t11.*t15.*t17.*t41;
t242 = mPB.*t10.*t11.*t15.*t16.*t43;
t243 = mBody.*rArm.*rArmMCD.*t17.*t101.*-2.0;
t244 = mLeg.*rArm.*rArmMCD.*t17.*t100.*-2.0;
t245 = -t206;
t246 = -t207;
t248 = mArm.*rArm.*rArmMCD.*t10.*t15.*t17.*t41.*2.0;
t257 = mArm.*mBody.*mLeg.*rArm.*rBodyMCD.*t2.*t15.*t26.*t41;
t258 = mBody.*mLeg.*mPB.*rArm.*rBodyMCD.*t2.*t15.*t26.*t41;
t262 = mArm.*mBody.*mLeg.*rArm.*rBodyMCD.*t2.*t15.*t26.*t43;
t263 = mBody.*mLeg.*mPB.*rArm.*rBodyMCD.*t2.*t15.*t26.*t43;
t265 = mArm.*mBody.*mLeg.*rArm.*rBodyMCD.*t3.*t15.*t27.*t41;
t266 = mArm.*mBody.*mLeg.*rArmMCD.*rBodyMCD.*t3.*t15.*t27.*t41;
t267 = mBody.*mLeg.*mPB.*rArm.*rBodyMCD.*t3.*t15.*t27.*t41;
t268 = mArm.*mBody.*mLeg.*rArm.*rBodyMCD.*t3.*t15.*t27.*t43;
t269 = mArm.*mBody.*mLeg.*rArmMCD.*rBodyMCD.*t3.*t15.*t27.*t43;
t270 = mBody.*mLeg.*mPB.*rArm.*rBodyMCD.*t3.*t15.*t27.*t43;
t275 = mArm.*t11.*t17.*t117;
t278 = mArm.*t11.*t17.*t118;
t285 = mPB.*t11.*t17.*t117;
t287 = mPB.*t11.*t17.*t118;
t294 = -t228;
t295 = -t229;
t296 = mArm.*rArm.*rArmMCD.*t17.*t117.*2.0;
t297 = mArm.*rArm.*rArmMCD.*t17.*t118.*2.0;
t300 = mBody.*t10.*t11.*t15.*t16.*t41;
t301 = mLeg.*t9.*t11.*t15.*t16.*t41;
t302 = mBody.*rArm.*rArmMCD.*t17.*t95.*-2.0;
t303 = mLeg.*rArm.*rArmMCD.*t17.*t94.*-2.0;
t314 = mBody.*rArm.*rBodyMCD.*t2.*t10.*t15.*t26.*t41;
t315 = mLeg.*rArm.*rBodyMCD.*t2.*t9.*t15.*t26.*t41;
t318 = mArm.*rArm.*rBody.*t2.*t10.*t15.*t26.*t43;
t319 = mBody.*rArm.*rBody.*t2.*t10.*t15.*t26.*t43;
t320 = mLeg.*rArm.*rBodyMCD.*t2.*t9.*t15.*t26.*t43;
t321 = mPB.*rArm.*rBody.*t2.*t10.*t15.*t26.*t43;
t323 = mArm.*rArm.*rBody.*t3.*t10.*t15.*t27.*t41;
t324 = mArm.*rArmMCD.*rBody.*t3.*t10.*t15.*t27.*t41;
t325 = mPB.*rArm.*rBody.*t3.*t10.*t15.*t27.*t41;
t329 = mArm.*mBody.*mLeg.*t14.*t15.*t36.*t41;
t330 = mBody.*mLeg.*mPB.*t14.*t15.*t36.*t41;
t331 = -t289;
t332 = -t290;
t333 = mArm.*mBody.*mLeg.*t14.*t15.*t37.*t41;
t334 = mArm.*mBody.*mLeg.*t14.*t15.*t36.*t43;
t335 = mBody.*mLeg.*mPB.*t14.*t15.*t37.*t41;
t336 = mBody.*mLeg.*mPB.*t14.*t15.*t36.*t43;
t339 = -t298;
t340 = -t299;
t341 = mArm.*mBody.*mLeg.*t14.*t15.*t37.*t43;
t342 = mBody.*mLeg.*mPB.*t14.*t15.*t37.*t43;
t358 = mBody.*t10.*t14.*t15.*t36.*t41;
t359 = mLeg.*t9.*t14.*t15.*t36.*t41;
t362 = mArm.*t10.*t13.*t15.*t37.*t41;
t363 = mArm.*t10.*t13.*t15.*t36.*t43;
t364 = mBody.*t10.*t13.*t15.*t37.*t41;
t365 = mBody.*t10.*t13.*t15.*t36.*t43;
t366 = mBody.*t10.*t14.*t15.*t37.*t41;
t367 = mLeg.*t9.*t14.*t15.*t36.*t43;
t368 = mPB.*t10.*t13.*t15.*t37.*t41;
t369 = mPB.*t10.*t13.*t15.*t36.*t43;
t370 = mBody.*t14.*t36.*t123;
t371 = mLeg.*t13.*t36.*t123;
t372 = mBody.*t14.*t37.*t123;
t373 = mLeg.*t13.*t37.*t123;
t374 = mBody.*rBody.*rBodyMCD.*t10.*t15.*t37.*t41.*2.0;
t405 = InertiaBody.*t388;
t414 = -t403;
t415 = -t404;
t416 = InertiaBody.*t403;
t417 = InertiaBody.*t404;
t431 = -t395;
t432 = -t396;
t433 = -t398;
t434 = -t400;
t435 = -t401;
t439 = t8.*t10.*t12.*t13.*t15.*t37.*t41;
t440 = t8.*t10.*t12.*t13.*t15.*t36.*t43;
t442 = InertiaArm.*t438;
t446 = InertiaArm.*t443;
t447 = InertiaArm.*t444;
t448 = InertiaArm.*t445;
t449 = mArm.*mBody.*rArm.*rArmMCD.*rBody.*rBodyMCD.*t10.*t15.*t17.*t37.*t41.*4.0;
t450 = -t443;
t451 = -t444;
t452 = -t445;
t494 = t9.*t10.*t11.*t13.*t15.*t16.*t37.*t41;
t495 = t9.*t10.*t11.*t13.*t15.*t16.*t36.*t43;
t496 = t9.*t10.*t11.*t14.*t15.*t16.*t37.*t41;
t497 = t9.*t10.*t11.*t14.*t15.*t16.*t36.*t43;
t498 = mArm.*t12.*t438;
t502 = rBody.*rBodyMCD.*t9.*t10.*t11.*t15.*t16.*t37.*t41.*2.0;
t503 = rBody.*rBodyMCD.*t9.*t10.*t11.*t15.*t16.*t36.*t43.*2.0;
t515 = mBody.*t12.*t443;
t516 = mPB.*t12.*t443;
t517 = mArm.*mLeg.*rArm.*rArmMCD.*t2.*t3.*t9.*t14.*t15.*t26.*t27.*t41.*2.0;
t518 = mArm.*mBody.*rBody.*rBodyMCD.*t2.*t3.*t10.*t11.*t15.*t26.*t27.*t41.*2.0;
t519 = mBody.*mPB.*rBody.*rBodyMCD.*t2.*t3.*t10.*t11.*t15.*t26.*t27.*t41.*2.0;
t520 = mArm.*mLeg.*rArm.*rArmMCD.*t2.*t3.*t9.*t14.*t15.*t26.*t27.*t43.*2.0;
t521 = mArm.*mBody.*rBody.*rBodyMCD.*t2.*t3.*t10.*t11.*t15.*t26.*t27.*t43.*2.0;
t522 = mBody.*mPB.*rBody.*rBodyMCD.*t2.*t3.*t10.*t11.*t15.*t26.*t27.*t43.*2.0;
t529 = mBody.*rBody.*rBodyMCD.*t36.*t388;
t530 = mBody.*rBody.*rBodyMCD.*t37.*t388;
t531 = mArm.*mLeg.*t2.*t3.*t9.*t11.*t14.*t15.*t26.*t27.*t41.*2.0;
t532 = mLeg.*mPB.*t2.*t3.*t9.*t11.*t14.*t15.*t26.*t27.*t41.*2.0;
t534 = mArm.*mLeg.*t2.*t3.*t9.*t11.*t14.*t15.*t26.*t27.*t43.*2.0;
t535 = mLeg.*mPB.*t2.*t3.*t9.*t11.*t14.*t15.*t26.*t27.*t43.*2.0;
t544 = mBody.*t14.*t36.*t388;
t545 = mBody.*rBody.*rBodyMCD.*t36.*t403;
t546 = mBody.*rBody.*rBodyMCD.*t36.*t404;
t547 = mBody.*t14.*t37.*t388;
t548 = mBody.*rBody.*rBodyMCD.*t37.*t403;
t549 = mBody.*rBody.*rBodyMCD.*t37.*t404;
t554 = -t533;
t557 = mBody.*t14.*t36.*t403;
t558 = mBody.*t14.*t36.*t404;
t560 = mBody.*t14.*t37.*t403;
t561 = mBody.*t14.*t37.*t404;
t562 = mArm.*t11.*t16.*t438;
t563 = mPB.*t11.*t16.*t438;
t565 = mArm.*t11.*t17.*t438;
t566 = mPB.*t11.*t17.*t438;
t569 = -t559;
t572 = mBody.*t11.*t16.*t443;
t573 = mPB.*t11.*t16.*t444;
t575 = mBody.*t11.*t17.*t443;
t576 = mPB.*t11.*t17.*t444;
t581 = t17.*t533;
t584 = -t577;
t585 = -t578;
t149 = InertiaBody.*t137;
t150 = InertiaBody.*t139;
t151 = InertiaBody.*t141;
t152 = InertiaBody.*t143;
t153 = InertiaBody.*t145;
t154 = InertiaBody.*t147;
t161 = InertiaBody.*t157;
t183 = mBody.*t12.*t138;
t184 = mPB.*t12.*t138;
t185 = mBody.*t12.*t144;
t186 = mPB.*t12.*t144;
t198 = mArm.*t12.*t158;
t199 = InertiaBody.*t195;
t200 = InertiaBody.*t197;
t238 = t17.*t195;
t247 = t17.*t197;
t249 = -t214;
t250 = -t215;
t251 = mBody.*t11.*t16.*t138;
t252 = mPB.*t11.*t16.*t140;
t253 = mBody.*t11.*t17.*t138;
t254 = mBody.*t11.*t16.*t144;
t255 = mPB.*t11.*t17.*t140;
t256 = mPB.*t11.*t16.*t146;
t259 = mBody.*t11.*t17.*t144;
t260 = mPB.*t11.*t17.*t146;
t261 = mBody.*rArm.*rArmMCD.*t17.*t138.*2.0;
t264 = mBody.*rArm.*rArmMCD.*t17.*t144.*2.0;
t304 = -t248;
t305 = mBody.*t11.*t16.*t158;
t306 = InertiaBody.*t301;
t307 = mArm.*t11.*t17.*t158;
t308 = InertiaBody.*t237;
t310 = InertiaBody.*t239;
t311 = InertiaBody.*t240;
t312 = mPB.*t11.*t17.*t158;
t313 = InertiaBody.*t242;
t317 = mArm.*rArm.*rArmMCD.*t17.*t158.*2.0;
t337 = -t296;
t338 = -t297;
t345 = mBody.*t14.*t36.*t137;
t346 = mPB.*t14.*t36.*t139;
t347 = mBody.*t14.*t37.*t137;
t348 = mBody.*t14.*t36.*t143;
t349 = mPB.*t14.*t37.*t139;
t350 = mPB.*t14.*t36.*t145;
t351 = mBody.*t14.*t37.*t143;
t352 = mPB.*t14.*t37.*t145;
t354 = -t266;
t355 = -t269;
t375 = mBody.*t14.*t36.*t157;
t376 = InertiaArm.*t359;
t377 = mArm.*t13.*t37.*t157;
t378 = InertiaArm.*t363;
t379 = mBody.*t13.*t37.*t157;
t380 = InertiaArm.*t365;
t381 = mBody.*t14.*t37.*t157;
t382 = InertiaArm.*t367;
t383 = mPB.*t13.*t37.*t157;
t384 = InertiaArm.*t369;
t385 = mBody.*rBody.*rBodyMCD.*t37.*t157.*2.0;
t389 = -t324;
t394 = -t374;
t410 = mPB.*t14.*t36.*t179;
t411 = mPB.*t14.*t37.*t179;
t412 = mPB.*t14.*t36.*t181;
t413 = mPB.*t14.*t37.*t181;
t418 = mBody.*t14.*t36.*t194;
t419 = mArm.*t12.*t359;
t420 = mBody.*t14.*t36.*t195;
t421 = mBody.*t13.*t37.*t194;
t422 = mBody.*t12.*t363;
t423 = mBody.*t14.*t37.*t194;
t424 = mArm.*t12.*t367;
t425 = mBody.*t14.*t37.*t195;
t426 = mBody.*t14.*t36.*t197;
t427 = mPB.*t13.*t37.*t194;
t428 = mPB.*t12.*t363;
t429 = mBody.*t14.*t37.*t197;
t430 = mBody.*rBody.*rBodyMCD.*t37.*t194.*2.0;
t456 = mArm.*t13.*t37.*t300;
t457 = mBody.*t13.*t36.*t237;
t458 = mBody.*t14.*t36.*t236;
t459 = mBody.*t14.*t36.*t237;
t460 = mArm.*t11.*t17.*t359;
t461 = mArm.*t14.*t37.*t301;
t463 = mPB.*t13.*t37.*t300;
t464 = mPB.*t13.*t36.*t239;
t465 = mBody.*t14.*t36.*t241;
t466 = mPB.*t14.*t36.*t239;
t467 = mPB.*t11.*t17.*t359;
t468 = mPB.*t14.*t37.*t301;
t469 = mBody.*t13.*t37.*t236;
t470 = mBody.*t11.*t17.*t363;
t471 = mBody.*t14.*t37.*t236;
t472 = mBody.*t14.*t37.*t237;
t473 = mArm.*t11.*t17.*t367;
t474 = mArm.*t14.*t37.*t240;
t477 = mBody.*t13.*t37.*t241;
t478 = mPB.*t11.*t17.*t365;
t479 = mBody.*t14.*t37.*t241;
t480 = mPB.*t14.*t37.*t239;
t481 = mPB.*t11.*t17.*t367;
t482 = mPB.*t14.*t37.*t240;
t483 = mBody.*t14.*t36.*t248;
t484 = mArm.*rArm.*rArmMCD.*t17.*t359.*2.0;
t485 = mBody.*rBody.*rBodyMCD.*t36.*t237.*2.0;
t486 = mPB.*rBody.*rBodyMCD.*t36.*t239.*2.0;
t488 = mBody.*t13.*t37.*t248;
t489 = mBody.*rArm.*rArmMCD.*t17.*t363.*2.0;
t490 = mBody.*t14.*t37.*t248;
t491 = mArm.*rArm.*rArmMCD.*t17.*t367.*2.0;
t492 = mBody.*rBody.*rBodyMCD.*t37.*t236.*2.0;
t493 = mBody.*rBody.*rBodyMCD.*t37.*t241.*2.0;
t499 = mArm.*rArmMCD.*rBody.*t3.*t27.*t314.*2.0;
t500 = t17.*t439;
t501 = t17.*t440;
t504 = mBody.*rArmMCD.*rBodyMCD.*t3.*t27.*t318.*2.0;
t505 = mArm.*rArm.*rArmMCD.*t17.*t358.*-2.0;
t509 = mBody.*rArm.*rArmMCD.*t17.*t362.*-2.0;
t511 = mArm.*rArm.*rArmMCD.*t17.*t366.*-2.0;
t524 = -t502;
t525 = -t503;
t538 = -t518;
t539 = -t519;
t540 = -t521;
t541 = -t522;
t552 = -t531;
t553 = -t532;
t555 = -t534;
t556 = -t535;
t309 = t17.*t199;
t316 = t17.*t200;
t322 = -t261;
t326 = -t264;
t343 = -t238;
t344 = -t247;
t353 = -t317;
t402 = -t385;
t441 = -t430;
t462 = mBody.*t14.*t36.*t238;
t475 = mBody.*t14.*t37.*t238;
t476 = mBody.*t14.*t36.*t247;
t487 = mBody.*t14.*t37.*t247;
t506 = -t484;
t507 = -t485;
t508 = -t486;
t510 = -t489;
t512 = -t491;
t513 = -t492;
t514 = -t493;
t542 = -t500;
t543 = -t501;
t386 = -t309;
t387 = -t316;
t523 = mBody.*t14.*t36.*t343;
t526 = mBody.*t14.*t37.*t343;
t527 = mBody.*t14.*t36.*t344;
t528 = mBody.*t14.*t37.*t344;
t586 = t31+t32+t33+t34+t45+t46+t47+t52+t76+t77+t78+t79+t80+t81+t82+t83+t107+t108+t109+t113+t114+t124+t125+t126+t127+t128+t129+t130+t131+t132+t133+t134+t135+t149+t150+t151+t152+t153+t154+t155+t156+t159+t160+t161+t170+t171+t172+t173+t174+t175+t176+t177+t183+t184+t185+t186+t188+t189+t190+t191+t192+t193+t196+t198+t199+t200+t201+t216+t217+t218+t219+t220+t221+t222+t223+t224+t225+t226+t227+t230+t231+t232+t233+t243+t244+t245+t246+t251+t252+t253+t254+t255+t256+t259+t260+t271+t272+t273+t274+t275+t276+t278+t279+t281+t282+t283+t284+t285+t286+t287+t288+t291+t294+t295+t302+t303+t305+t306+t307+t308+t310+t311+t312+t313+t322+t326+t331+t332+t337+t338+t339+t340+t345+t346+t347+t348+t349+t350+t351+t352+t353+t356+t357+t360+t361+t370+t371+t372+t373+t375+t376+t377+t378+t379+t380+t381+t382+t383+t384+t386+t387+t402+t405+t406+t407+t408+t409+t410+t411+t412+t413+t418+t419+t420+t421+t422+t423+t424+t425+t426+t427+t428+t429+t436+t437+t439+t440+t441+t442+t449+t453+t454+t455+t456+t457+t458+t459+t460+t461+t463+t464+t465+t466+t467+t468+t469+t470+t471+t472+t473+t474+t477+t478+t479+t480+t481+t482+t494+t495+t496+t497+t498+t499+t504+t505+t506+t507+t508+t509+t510+t511+t512+t513+t514+t517+t520+t523+t524+t525+t526+t527+t528+t536+t537+t538+t539+t540+t541+t542+t543+t544+t545+t546+t547+t548+t549+t550+t551+t552+t553+t554+t555+t556+t562+t563+t564+t565+t566+t567+t568+t569+t570+t571+t574+t579+t580+t581+t582+t583+t584+t585;
t587 = 1.0./t586;
ddthShoulder = -t587.*(MthWaist-t119+t120-t121-mLeg.*rBody.*rLegMCD.*t5.*t26.*t30+mLeg.*rBody.*rLegMCD.*t5.*t27.*t29-mLeg.*rBody.*rLegMCD.*t7.*t26.*t30+mLeg.*rBody.*rLegMCD.*t7.*t27.*t29-dthHand.*dthShoulder.*mLeg.*rBody.*rLegMCD.*t26.*t30.*2.0+dthHand.*dthShoulder.*mLeg.*rBody.*rLegMCD.*t27.*t29.*2.0).*(t18+t20+t22+t24+t38+t39+t40+t44+t54+t55+t56+t57+t58+t59+t60+t61+t64+t66+t68+t69+t70+t71+t72+t74+t75+t84+t85+t86+t87+t88+t89+t111+t112+t115+t116+t123+t137+t139+t141+t143+t145+t147+t157+t179+t180+t181+t182+t194+t195+t197+t202+t203+t208+t209+t210+t211+t212+t213+t236+t237+t239+t240+t241+t242+t249+t250+t257+t258+t262+t263+t265+t267+t268+t270+t300+t301+t304+t314+t315+t318+t319+t320+t321+t323+t325+t343+t344+t354+t355+t388+t389+t397+t399+t414+t415+t431+t432+t433+t434+t435-InertiaBody.*rArm.*rLegMCD.*t2.*t10.*t29+InertiaArm.*rBody.*rLegMCD.*t10.*t26.*t29-InertiaBody.*mArm.*mLeg.*rArm.*rLegMCD.*t2.*t29-InertiaBody.*mArm.*mLeg.*rArm.*rLegMCD.*t3.*t30+InertiaBody.*mArm.*mLeg.*rArmMCD.*rLegMCD.*t3.*t30+InertiaArm.*mArm.*mLeg.*rBody.*rLegMCD.*t26.*t29+InertiaArm.*mArm.*mLeg.*rBody.*rLegMCD.*t27.*t30-InertiaBody.*mBody.*mLeg.*rArm.*rLegMCD.*t2.*t29+InertiaArm.*mBody.*mLeg.*rBody.*rLegMCD.*t26.*t29+InertiaArm.*mBody.*mLeg.*rBody.*rLegMCD.*t27.*t30-InertiaArm.*mBody.*mLeg.*rBodyMCD.*rLegMCD.*t27.*t30-InertiaBody.*mLeg.*mPB.*rArm.*rLegMCD.*t2.*t29-InertiaBody.*mLeg.*mPB.*rArm.*rLegMCD.*t3.*t30+InertiaArm.*mLeg.*mPB.*rBody.*rLegMCD.*t26.*t29+InertiaArm.*mLeg.*mPB.*rBody.*rLegMCD.*t27.*t30+mArm.*rBody.*rLegMCD.*t10.*t12.*t26.*t29+mLeg.*rBody.*rLegMCD.*t8.*t12.*t26.*t29+mLeg.*rBody.*rLegMCD.*t8.*t12.*t27.*t30+mArm.*mBody.*mLeg.*rBody.*rLegMCD.*t12.*t26.*t29+mArm.*mBody.*mLeg.*rBody.*rLegMCD.*t12.*t27.*t30-mArm.*mBody.*mLeg.*rBodyMCD.*rLegMCD.*t12.*t27.*t30+mArm.*mLeg.*mPB.*rBody.*rLegMCD.*t12.*t26.*t29+mArm.*mLeg.*mPB.*rBody.*rLegMCD.*t12.*t27.*t30-mArm.*rArm.*rLegMCD.*t2.*t10.*t13.*t29.*t37-mArm.*rArm.*rLegMCD.*t3.*t10.*t13.*t30.*t36+mArm.*rArmMCD.*rLegMCD.*t3.*t10.*t13.*t30.*t36-mBody.*rArm.*rLegMCD.*t2.*t10.*t13.*t29.*t37-mBody.*rArm.*rLegMCD.*t2.*t10.*t14.*t29.*t36-mBody.*rArm.*rLegMCD.*t2.*t10.*t14.*t29.*t37+mArm.*rBody.*rLegMCD.*t10.*t11.*t17.*t26.*t29+mArm.*rBody.*rLegMCD.*t10.*t11.*t16.*t27.*t30+mBody.*rBody.*rLegMCD.*t10.*t11.*t16.*t26.*t29+mBody.*rBody.*rLegMCD.*t10.*t11.*t16.*t27.*t30-mBody.*rBodyMCD.*rLegMCD.*t10.*t11.*t16.*t26.*t29-mBody.*rBodyMCD.*rLegMCD.*t10.*t11.*t16.*t27.*t30-mLeg.*rArm.*rLegMCD.*t2.*t9.*t14.*t29.*t36+mLeg.*rBody.*rLegMCD.*t9.*t11.*t16.*t26.*t29-mLeg.*rBody.*rLegMCD.*t8.*t12.*t17.*t26.*t29+mLeg.*rBody.*rLegMCD.*t9.*t11.*t16.*t27.*t30-mLeg.*rBody.*rLegMCD.*t8.*t12.*t17.*t27.*t30-mLeg.*rBodyMCD.*rLegMCD.*t9.*t11.*t16.*t26.*t29-mLeg.*rBodyMCD.*rLegMCD.*t9.*t11.*t16.*t27.*t30-mPB.*rArm.*rLegMCD.*t2.*t10.*t13.*t29.*t37-mPB.*rArm.*rLegMCD.*t3.*t10.*t13.*t30.*t36+mPB.*rBody.*rLegMCD.*t10.*t11.*t17.*t26.*t29+mPB.*rBody.*rLegMCD.*t10.*t11.*t16.*t27.*t30-mArm.*mBody.*mLeg.*rArm.*rLegMCD.*t2.*t14.*t29.*t36-mArm.*mBody.*mLeg.*rArm.*rLegMCD.*t2.*t14.*t29.*t37-mArm.*mBody.*mLeg.*rArm.*rLegMCD.*t3.*t14.*t30.*t36-mArm.*mBody.*mLeg.*rArm.*rLegMCD.*t3.*t14.*t30.*t37+mArm.*mBody.*mLeg.*rArmMCD.*rLegMCD.*t3.*t14.*t30.*t36+mArm.*mBody.*mLeg.*rArmMCD.*rLegMCD.*t3.*t14.*t30.*t37+mArm.*mBody.*mLeg.*rBody.*rLegMCD.*t11.*t16.*t26.*t29+mArm.*mBody.*mLeg.*rBody.*rLegMCD.*t11.*t17.*t26.*t29+mArm.*mBody.*mLeg.*rBody.*rLegMCD.*t11.*t16.*t27.*t30+mArm.*mBody.*mLeg.*rBody.*rLegMCD.*t11.*t17.*t27.*t30-mArm.*mBody.*mLeg.*rBodyMCD.*rLegMCD.*t11.*t16.*t26.*t29-mArm.*mBody.*mLeg.*rBodyMCD.*rLegMCD.*t11.*t17.*t27.*t30-mBody.*mLeg.*mPB.*rArm.*rLegMCD.*t2.*t14.*t29.*t36-mBody.*mLeg.*mPB.*rArm.*rLegMCD.*t2.*t14.*t29.*t37-mBody.*mLeg.*mPB.*rArm.*rLegMCD.*t3.*t14.*t30.*t36-mBody.*mLeg.*mPB.*rArm.*rLegMCD.*t3.*t14.*t30.*t37+mBody.*mLeg.*mPB.*rBody.*rLegMCD.*t11.*t16.*t26.*t29+mBody.*mLeg.*mPB.*rBody.*rLegMCD.*t11.*t17.*t26.*t29+mBody.*mLeg.*mPB.*rBody.*rLegMCD.*t11.*t16.*t27.*t30+mBody.*mLeg.*mPB.*rBody.*rLegMCD.*t11.*t17.*t27.*t30-mBody.*mLeg.*mPB.*rBodyMCD.*rLegMCD.*t11.*t16.*t26.*t29-mBody.*mLeg.*mPB.*rBodyMCD.*rLegMCD.*t11.*t17.*t27.*t30-mArm.*rArm.*rArmMCD.*rBody.*rLegMCD.*t10.*t17.*t26.*t29.*2.0+mBody.*rArm.*rBody.*rBodyMCD.*rLegMCD.*t2.*t10.*t29.*t36+mBody.*rArm.*rBody.*rBodyMCD.*rLegMCD.*t2.*t10.*t29.*t37.*2.0+mLeg.*rArm.*rBody.*rBodyMCD.*rLegMCD.*t2.*t9.*t29.*t36+mArm.*rArm.*rLegMCD.*t2.*t10.*t13.*t26.*t27.*t30+mArm.*rArm.*rLegMCD.*t3.*t10.*t13.*t26.*t27.*t29-mArm.*rArmMCD.*rLegMCD.*t3.*t10.*t13.*t26.*t27.*t29-mArm.*rBody.*rLegMCD.*t2.*t3.*t10.*t11.*t26.*t30-mArm.*rBody.*rLegMCD.*t2.*t3.*t10.*t11.*t27.*t29+mBody.*rArm.*rLegMCD.*t2.*t10.*t13.*t26.*t27.*t30-mLeg.*rArm.*rLegMCD.*t2.*t9.*t14.*t26.*t27.*t30+mPB.*rArm.*rLegMCD.*t2.*t10.*t13.*t26.*t27.*t30+mPB.*rArm.*rLegMCD.*t3.*t10.*t13.*t26.*t27.*t29-mPB.*rBody.*rLegMCD.*t2.*t3.*t10.*t11.*t26.*t30-mPB.*rBody.*rLegMCD.*t2.*t3.*t10.*t11.*t27.*t29-mArm.*mBody.*mLeg.*rArm.*rArmMCD.*rBody.*rLegMCD.*t17.*t26.*t29.*2.0-mArm.*mBody.*mLeg.*rArm.*rArmMCD.*rBody.*rLegMCD.*t17.*t27.*t30.*2.0+mArm.*mBody.*mLeg.*rArm.*rArmMCD.*rBodyMCD.*rLegMCD.*t17.*t27.*t30.*2.0+mArm.*mBody.*mLeg.*rArm.*rBody.*rBodyMCD.*rLegMCD.*t2.*t29.*t36+mArm.*mBody.*mLeg.*rArm.*rBody.*rBodyMCD.*rLegMCD.*t3.*t30.*t37-mArm.*mBody.*mLeg.*rArmMCD.*rBody.*rBodyMCD.*rLegMCD.*t3.*t30.*t37+mBody.*mLeg.*mPB.*rArm.*rBody.*rBodyMCD.*rLegMCD.*t2.*t29.*t36+mBody.*mLeg.*mPB.*rArm.*rBody.*rBodyMCD.*rLegMCD.*t3.*t30.*t37-mArm.*mBody.*mLeg.*rBodyMCD.*rLegMCD.*t2.*t3.*t11.*t26.*t30-mArm.*mBody.*mLeg.*rBodyMCD.*rLegMCD.*t2.*t3.*t11.*t27.*t29-mBody.*mLeg.*mPB.*rBodyMCD.*rLegMCD.*t2.*t3.*t11.*t26.*t30-mBody.*mLeg.*mPB.*rBodyMCD.*rLegMCD.*t2.*t3.*t11.*t27.*t29+mArm.*rArm.*rArmMCD.*rBody.*rLegMCD.*t2.*t3.*t10.*t26.*t30+mArm.*rArm.*rArmMCD.*rBody.*rLegMCD.*t2.*t3.*t10.*t27.*t29-mBody.*rArm.*rBody.*rBodyMCD.*rLegMCD.*t2.*t10.*t26.*t27.*t30+mLeg.*rArm.*rBody.*rBodyMCD.*rLegMCD.*t2.*t9.*t26.*t27.*t30+mArm.*mBody.*mLeg.*rArm.*rArmMCD.*rBodyMCD.*rLegMCD.*t2.*t3.*t26.*t30+mArm.*mBody.*mLeg.*rArm.*rArmMCD.*rBodyMCD.*rLegMCD.*t2.*t3.*t27.*t29+mArm.*mBody.*mLeg.*rArm.*rBody.*rBodyMCD.*rLegMCD.*t2.*t26.*t27.*t30+mArm.*mBody.*mLeg.*rArm.*rBody.*rBodyMCD.*rLegMCD.*t3.*t26.*t27.*t29-mArm.*mBody.*mLeg.*rArmMCD.*rBody.*rBodyMCD.*rLegMCD.*t3.*t26.*t27.*t29+mBody.*mLeg.*mPB.*rArm.*rBody.*rBodyMCD.*rLegMCD.*t2.*t26.*t27.*t30+mBody.*mLeg.*mPB.*rArm.*rBody.*rBodyMCD.*rLegMCD.*t3.*t26.*t27.*t29)+t587.*(-MthHand+t92+t93+t119+t162+t164+t166+t168+t169+t187+g.*mArm.*rArmMCD.*t48+g.*mBody.*rArm.*t48+g.*mLeg.*rArm.*t48-mBody.*rArm.*rBodyMCD.*t2.*t7.*t27+mBody.*rArm.*rBodyMCD.*t3.*t7.*t26-mLeg.*rArm.*rBody.*t2.*t7.*t27+mLeg.*rArm.*rBody.*t3.*t7.*t26-mLeg.*rArm.*rLegMCD.*t2.*t6.*t30+mLeg.*rArm.*rLegMCD.*t3.*t6.*t29-mLeg.*rArm.*rLegMCD.*t2.*t7.*t30+mLeg.*rArm.*rLegMCD.*t3.*t7.*t29-dthHand.*dthShoulder.*mBody.*rArm.*rBodyMCD.*t2.*t27.*2.0+dthHand.*dthShoulder.*mBody.*rArm.*rBodyMCD.*t3.*t26.*2.0-dthHand.*dthShoulder.*mLeg.*rArm.*rBody.*t2.*t27.*2.0+dthHand.*dthShoulder.*mLeg.*rArm.*rBody.*t3.*t26.*2.0-dthHand.*dthWaist.*mLeg.*rArm.*rLegMCD.*t2.*t30.*2.0+dthHand.*dthWaist.*mLeg.*rArm.*rLegMCD.*t3.*t29.*2.0-dthHand.*dthShoulder.*mLeg.*rArm.*rLegMCD.*t2.*t30.*2.0+dthHand.*dthShoulder.*mLeg.*rArm.*rLegMCD.*t3.*t29.*2.0-dthWaist.*dthShoulder.*mLeg.*rArm.*rLegMCD.*t2.*t30.*2.0+dthWaist.*dthShoulder.*mLeg.*rArm.*rLegMCD.*t3.*t29.*2.0).*(t19+t21+t23+t25+t64+t66+t68+t69+t84+t85+t86+t87+t88+t89+t94+t95+t96+t97+t98+t99+t100+t101+t102+t103+t104+t105+t111+t112+t115+t116+t117+t118+t122+t138+t140+t142+t144+t146+t148+t158+t257+t258+t262+t263+t265+t267+t268+t270+t314+t315+t318+t319+t320+t321+t323+t325+t329+t330+t333+t334+t335+t336+t341+t342+t354+t355+t358+t359+t362+t363+t364+t365+t366+t367+t368+t369+t389+t394+t397+t399+t431+t432+t433+t434+t435+t438+t450+t451+t452)-t587.*(-MthShoulder+t92+t93+t119-t120+t121+t162+t164+t166+t168+t169+t187+mBody.*rArm.*rBodyMCD.*t2.*t5.*t27-mBody.*rArm.*rBodyMCD.*t3.*t5.*t26+mLeg.*rArm.*rBody.*t2.*t5.*t27-mLeg.*rArm.*rBody.*t3.*t5.*t26).*(t18+t19+t20+t21+t22+t23+t24+t25+t38+t39+t40+t44+t54+t55+t56+t57+t58+t59+t60+t61+t64.*2.0-t65.*2.0+t66.*2.0-t67.*2.0+t68.*2.0+t69.*2.0+t70+t71+t72+t74+t75+t84.*2.0+t85.*2.0+t86.*2.0+t87.*2.0+t88.*2.0+t89.*2.0+t94+t95+t96+t97+t98+t99+t100+t101+t102+t103+t104+t105+t111.*2.0+t112.*2.0+t117+t118+t122+t123+t137+t138+t139+t140+t141+t142+t143+t144+t145+t146+t147+t148+t157+t158+t179+t180+t181+t182+t194+t195+t197+t202+t203+t208+t209+t210+t211+t212+t213+t236+t237+t239+t240+t241+t242+t249+t250+t257.*2.0+t258.*2.0+t262.*2.0+t263.*2.0+t265.*2.0-t266.*2.0+t267.*2.0+t268.*2.0-t269.*2.0+t270.*2.0+t300+t301+t304+t314.*2.0+t315.*2.0+t318.*2.0+t319.*2.0+t320.*2.0+t321.*2.0+t323.*2.0-t324.*2.0+t325.*2.0+t329+t330+t333+t334+t335+t336+t341+t342+t343+t344+t358+t359+t362+t363+t364+t365+t366+t367+t368+t369+t388+t394-t395.*2.0-t396.*2.0+t397.*2.0-t398.*2.0+t399.*2.0-t400.*2.0-t401.*2.0+t414+t415+t438+t450+t451+t452)-t587.*(MrPB-g.*mArm-g.*mBody-g.*mLeg-g.*mPB-kPB.*rPB+mArm.*rArmMCD.*t2.*t5+mBody.*rArm.*t2.*t5+mBody.*rBodyMCD.*t5.*t26+mBody.*rBodyMCD.*t7.*t26+mLeg.*rArm.*t2.*t5+mLeg.*rBody.*t5.*t26+mLeg.*rBody.*t7.*t26+mLeg.*rLegMCD.*t5.*t29+mLeg.*rLegMCD.*t6.*t29+mLeg.*rLegMCD.*t7.*t29+dthHand.*dthShoulder.*mBody.*rBodyMCD.*t26.*2.0+dthHand.*dthShoulder.*mLeg.*rBody.*t26.*2.0+dthHand.*dthWaist.*mLeg.*rLegMCD.*t29.*2.0+dthHand.*dthShoulder.*mLeg.*rLegMCD.*t29.*2.0+dthWaist.*dthShoulder.*mLeg.*rLegMCD.*t29.*2.0).*(rArm.*t3.*t21+rArm.*t3.*t23+rArm.*t3.*t96+rArm.*t3.*t97+rArm.*t3.*t102+rArm.*t3.*t103+rArm.*t3.*t117+rArm.*t3.*t118+rArm.*t3.*t140+rArm.*t3.*t146+rArm.*t3.*t158+rArmMCD.*t3.*t19+rArmMCD.*t3.*t84+rArmMCD.*t3.*t85+rArmMCD.*t3.*t94+rArmMCD.*t3.*t95+rArmMCD.*t3.*t100+rArmMCD.*t3.*t101+rArmMCD.*t3.*t138+rArmMCD.*t3.*t144+rArm.*t3.*t358+rArm.*t3.*t359+rArm.*t3.*t364+rArm.*t3.*t365+rArm.*t3.*t366+rArm.*t3.*t367+rArm.*t3.*t438+rArmMCD.*t3.*t257+rArmMCD.*t3.*t262+rArmMCD.*t3.*t318+rArmMCD.*t3.*t329+rArmMCD.*t3.*t333+rArmMCD.*t3.*t334+rArmMCD.*t3.*t341+rArmMCD.*t3.*t362+rArmMCD.*t3.*t363+rArmMCD.*t3.*t432-rBody.*t22.*t27-rBody.*t27.*t39-rBody.*t27.*t71-rBody.*t27.*t157-rBody.*t27.*t194-rBodyMCD.*t20.*t27-rBodyMCD.*t27.*t38-rBodyMCD.*t27.*t70-rBodyMCD.*t27.*t86.*2.0-rBody.*t27.*t300-rBody.*t27.*t314-rBodyMCD.*t27.*t139-rBodyMCD.*t27.*t145-rBodyMCD.*t27.*t179-rBodyMCD.*t27.*t181-rBodyMCD.*t27.*t239-rBodyMCD.*t27.*t240-rBodyMCD.*t27.*t301-rBodyMCD.*t27.*t319-InertiaLeg.*mBody.*mLeg.*rBody.*t11.*t16.*t27-InertiaLeg.*mBody.*mLeg.*rBodyMCD.*t11.*t16.*t27-InertiaLeg.*rArm.*t2.*t9.*t14.*t26.*t27-InertiaLeg.*rArm.*t2.*t10.*t13.*t26.*t27-InertiaBody.*rArm.*t2.*t10.*t15.*t29.*t30+InertiaLeg.*rBody.*t2.*t3.*t10.*t11.*t26+InertiaArm.*rBody.*t10.*t15.*t26.*t29.*t30+InertiaLeg.*rBodyMCD.*t2.*t3.*t9.*t11.*t26+InertiaLeg.*mArm.*mBody.*rArm.*rArmMCD.*rBodyMCD.*t17.*t27+InertiaLeg.*mArm.*mLeg.*rArm.*rArmMCD.*rBody.*t17.*t27-InertiaLeg.*mBody.*mLeg.*rArm.*rBody.*rBodyMCD.*t3.*t37.*2.0+InertiaLeg.*mBody.*mLeg.*rBody.*t2.*t3.*t11.*t26+InertiaLeg.*mBody.*mLeg.*rBodyMCD.*t2.*t3.*t11.*t26+mArm.*rBody.*t10.*t12.*t15.*t26.*t29.*t30+mArm.*rArm.*rArmMCD.*rBody.*t10.*t15.*t17.*t27.*t41-mBody.*rArm.*rBody.*rBodyMCD.*t3.*t10.*t15.*t37.*t41.*2.0-mBody.*rArm.*t2.*t10.*t14.*t15.*t29.*t30.*t36-mBody.*rArm.*t2.*t10.*t14.*t15.*t29.*t30.*t37+mBody.*rBody.*t2.*t3.*t10.*t11.*t15.*t26.*t43+mBody.*rBody.*t10.*t11.*t15.*t16.*t26.*t29.*t30+mBody.*rBodyMCD.*t2.*t3.*t10.*t11.*t15.*t26.*t41-mBody.*rBodyMCD.*t10.*t11.*t15.*t16.*t26.*t29.*t30-mLeg.*rArm.*t2.*t9.*t14.*t15.*t26.*t27.*t41-mLeg.*rArm.*t2.*t9.*t14.*t15.*t26.*t27.*t43+mLeg.*rBodyMCD.*t2.*t3.*t9.*t11.*t15.*t26.*t41+mLeg.*rBodyMCD.*t2.*t3.*t9.*t11.*t15.*t26.*t43+mArm.*mBody.*mLeg.*rArm.*rArmMCD.*rBodyMCD.*t15.*t17.*t27.*t41+mArm.*mBody.*mLeg.*rArm.*rArmMCD.*rBodyMCD.*t15.*t17.*t27.*t43-mArm.*rArm.*rArmMCD.*rBody.*t10.*t15.*t17.*t26.*t29.*t30+mBody.*rArm.*rBody.*rBodyMCD.*t2.*t10.*t15.*t29.*t30.*t36+mBody.*rArm.*rBody.*rBodyMCD.*t2.*t10.*t15.*t29.*t30.*t37-mArm.*rArmMCD.*t3.*t10.*t13.*t15.*t26.*t27.*t29.*t30.*2.0-mBody.*rArm.*t3.*t10.*t13.*t15.*t26.*t27.*t29.*t30.*2.0-mBody.*rBody.*t2.*t3.*t10.*t11.*t15.*t27.*t29.*t30+mBody.*rBodyMCD.*t2.*t3.*t10.*t11.*t15.*t27.*t29.*t30);
