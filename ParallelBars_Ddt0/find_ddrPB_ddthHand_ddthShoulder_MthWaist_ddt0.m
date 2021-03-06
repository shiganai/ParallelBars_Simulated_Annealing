function [ddrPB,ddthHand,ddthShoulder,MthWaist] = find_ddrPB_ddthHand_ddthShoulder_MthWaist_ddt0(InertiaLeg,InertiaArm,InertiaBody,MrPB,MthHand,MthShoulder,ddthWaist,dthHand,dthWaist,dthShoulder,g,kPB,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,rPB,thHand,thShoulder,thWaist)
%FIND_DDRPB_DDTHHAND_DDTHSHOULDER_MTHWAIST_DDT0
%    [DDRPB,DDTHHAND,DDTHSHOULDER,MTHWAIST] = FIND_DDRPB_DDTHHAND_DDTHSHOULDER_MTHWAIST_DDT0(INERTIALEG,INERTIAARM,INERTIABODY,MRPB,MTHHAND,MTHSHOULDER,DDTHWAIST,DTHHAND,DTHWAIST,DTHSHOULDER,G,KPB,MARM,MBODY,MLEG,MPB,RARM,RARMMCD,RBODY,RBODYMCD,RLEGMCD,RPB,THHAND,THSHOULDER,THWAIST)

%    This function was generated by the Symbolic Math Toolbox version 8.5.
%    13-Jul-2020 00:22:44

t2 = InertiaLeg.*ddthWaist;
t3 = InertiaLeg.*mArm;
t4 = InertiaBody.*mArm;
t5 = InertiaLeg.*mBody;
t6 = InertiaBody.*mBody;
t7 = InertiaLeg.*mLeg;
t8 = InertiaBody.*mLeg;
t9 = InertiaLeg.*mPB;
t10 = InertiaBody.*mPB;
t11 = g.*mArm;
t12 = g.*mBody;
t13 = g.*mLeg;
t14 = g.*mPB;
t15 = kPB.*rPB;
t16 = dthHand.^2;
t17 = dthWaist.^2;
t18 = dthShoulder.^2;
t19 = mArm.^2;
t20 = mBody.^2;
t21 = mLeg.^2;
t22 = rArm.^2;
t23 = rArmMCD.^2;
t24 = rBody.^2;
t25 = rBodyMCD.^2;
t26 = rLegMCD.^2;
t35 = -MthHand;
t36 = -MthShoulder;
t42 = pi./2.0;
t27 = InertiaArm.*t3;
t28 = InertiaArm.*t4;
t29 = InertiaArm.*t5;
t30 = InertiaArm.*t6;
t31 = InertiaArm.*t7;
t32 = InertiaArm.*t8;
t33 = InertiaArm.*t9;
t34 = InertiaArm.*t10;
t37 = -t11;
t38 = -t12;
t39 = -t13;
t40 = -t14;
t41 = -t15;
t43 = t42+thHand;
t44 = cos(t43);
t45 = sin(t43);
t46 = t43+thShoulder;
t47 = cos(t46);
t48 = sin(t46);
t49 = t46+thWaist;
t50 = t44.^2;
t51 = t45.^2;
t58 = rArmMCD.*t3.*t44;
t59 = rArmMCD.*t4.*t44;
t60 = rArm.*t5.*t44;
t61 = rArm.*t6.*t44;
t62 = rArm.*t7.*t44;
t63 = rArm.*t8.*t44;
t64 = rArmMCD.*t11.*t44;
t65 = rArm.*t12.*t44;
t66 = rArm.*t13.*t44;
t74 = mArm.*rArmMCD.*t16.*t45;
t75 = mBody.*rArm.*t16.*t45;
t76 = mLeg.*rArm.*t16.*t45;
t52 = cos(t49);
t53 = sin(t49);
t54 = t47.^2;
t55 = t48.^2;
t67 = rBodyMCD.*t12.*t47;
t68 = rBody.*t13.*t47;
t69 = InertiaArm.*mBody.*rBodyMCD.*t47;
t70 = InertiaArm.*mLeg.*rBody.*t47;
t77 = mBody.*rBodyMCD.*t16.*t48;
t78 = mBody.*rBodyMCD.*t18.*t48;
t79 = mLeg.*rBody.*t16.*t48;
t80 = mLeg.*rBody.*t18.*t48;
t81 = dthHand.*dthShoulder.*mBody.*rBodyMCD.*t48.*2.0;
t82 = dthHand.*dthShoulder.*mLeg.*rBody.*t48.*2.0;
t93 = mBody.*t3.*t22.*t50;
t94 = mBody.*t4.*t22.*t50;
t95 = mBody.*t3.*t23.*t50;
t96 = mBody.*t4.*t23.*t50;
t97 = mLeg.*t3.*t22.*t50;
t98 = mLeg.*t4.*t22.*t50;
t99 = mLeg.*t3.*t23.*t50;
t100 = mLeg.*t4.*t23.*t50;
t101 = mPB.*t3.*t23.*t50;
t102 = mPB.*t4.*t23.*t50;
t103 = mPB.*t5.*t22.*t50;
t104 = mPB.*t6.*t22.*t50;
t105 = mPB.*t7.*t22.*t50;
t106 = mPB.*t8.*t22.*t50;
t107 = mBody.*t3.*t22.*t51;
t108 = mBody.*t4.*t22.*t51;
t109 = mBody.*t3.*t23.*t51;
t110 = mBody.*t4.*t23.*t51;
t111 = mLeg.*t3.*t22.*t51;
t112 = mLeg.*t4.*t22.*t51;
t113 = mLeg.*t3.*t23.*t51;
t114 = mLeg.*t4.*t23.*t51;
t115 = mPB.*t3.*t23.*t51;
t116 = mPB.*t4.*t23.*t51;
t117 = mPB.*t5.*t22.*t51;
t118 = mPB.*t6.*t22.*t51;
t119 = mPB.*t7.*t22.*t51;
t120 = mPB.*t8.*t22.*t51;
t121 = mBody.*rArm.*rArmMCD.*t3.*t50.*2.0;
t122 = mBody.*rArm.*rArmMCD.*t4.*t50.*2.0;
t123 = mLeg.*rArm.*rArmMCD.*t3.*t50.*2.0;
t124 = mLeg.*rArm.*rArmMCD.*t4.*t50.*2.0;
t159 = mArm.*t3.*t23.*t51;
t160 = mArm.*t4.*t23.*t51;
t161 = mBody.*t5.*t22.*t51;
t162 = mBody.*t6.*t22.*t51;
t163 = mLeg.*t7.*t22.*t51;
t164 = mLeg.*t8.*t22.*t51;
t165 = mLeg.*t5.*t22.*t51.*2.0;
t166 = mLeg.*t6.*t22.*t51.*2.0;
t185 = mArm.*mBody.*rArm.*rBodyMCD.*t44.*t47;
t186 = mArm.*mBody.*rArmMCD.*rBodyMCD.*t44.*t47;
t187 = mArm.*mLeg.*rArm.*rBody.*t44.*t47;
t188 = mArm.*mLeg.*rArmMCD.*rBody.*t44.*t47;
t189 = mBody.*mPB.*rArm.*rBodyMCD.*t44.*t47;
t190 = mLeg.*mPB.*rArm.*rBody.*t44.*t47;
t191 = mArm.*mBody.*rArm.*rBodyMCD.*t45.*t48;
t192 = mArm.*mLeg.*rArm.*rBody.*t45.*t48;
t193 = mBody.*mLeg.*rArm.*rBody.*t45.*t48;
t194 = mBody.*mLeg.*rArm.*rBodyMCD.*t45.*t48;
t195 = mBody.*mPB.*rArm.*rBodyMCD.*t45.*t48;
t196 = mLeg.*mPB.*rArm.*rBody.*t45.*t48;
t197 = rArm.*rBodyMCD.*t20.*t45.*t48;
t198 = rArm.*rBody.*t21.*t45.*t48;
t199 = mBody.*rArm.*rBodyMCD.*t3.*t44.*t47;
t200 = mBody.*rBodyMCD.*t47.*t58;
t201 = mLeg.*rArm.*rBody.*t3.*t44.*t47;
t202 = mLeg.*rBody.*t47.*t58;
t203 = mPB.*rBodyMCD.*t47.*t60;
t204 = mPB.*rBody.*t47.*t62;
t205 = mBody.*rArm.*rBodyMCD.*t3.*t45.*t48;
t206 = mLeg.*rArm.*rBody.*t3.*t45.*t48;
t207 = mLeg.*rArm.*rBody.*t5.*t45.*t48;
t208 = mLeg.*rArm.*rBodyMCD.*t5.*t45.*t48;
t209 = mPB.*rArm.*rBodyMCD.*t5.*t45.*t48;
t210 = mPB.*rArm.*rBody.*t7.*t45.*t48;
t229 = mBody.*rArm.*rBodyMCD.*t5.*t45.*t48;
t230 = mLeg.*rArm.*rBody.*t7.*t45.*t48;
t231 = rBodyMCD.*t47.*t75;
t233 = mBody.*rArm.*rBodyMCD.*t18.*t45.*t47;
t235 = rBody.*t47.*t76;
t237 = mLeg.*rArm.*rBody.*t18.*t45.*t47;
t239 = dthHand.*dthShoulder.*mBody.*rArm.*rBodyMCD.*t45.*t47.*2.0;
t241 = dthHand.*dthShoulder.*mLeg.*rArm.*rBody.*t45.*t47.*2.0;
t245 = mArm.*mBody.*rArm.*rArmMCD.*rBodyMCD.*t47.*t50;
t246 = mArm.*mLeg.*rArm.*rArmMCD.*rBody.*t47.*t50;
t268 = dthHand.*dthShoulder.*mBody.*rArm.*rBodyMCD.*t44.*t48.*-2.0;
t269 = dthHand.*dthShoulder.*mLeg.*rArm.*rBody.*t44.*t48.*-2.0;
t274 = mArm.*mBody.*rBodyMCD.*t23.*t47.*t50;
t276 = mArm.*mLeg.*rBody.*t23.*t47.*t50;
t280 = mArm.*mBody.*rBodyMCD.*t23.*t47.*t51;
t282 = mArm.*mLeg.*rBody.*t23.*t47.*t51;
t284 = mBody.*mLeg.*rBody.*t22.*t47.*t51;
t286 = mBody.*mLeg.*rBodyMCD.*t22.*t47.*t51;
t315 = rBodyMCD.*t20.*t22.*t47.*t51;
t317 = rBody.*t21.*t22.*t47.*t51;
t439 = mBody.*mLeg.*rBody.*t22.*t44.*t45.*t48;
t440 = mBody.*mLeg.*rBodyMCD.*t22.*t44.*t45.*t48;
t463 = rBodyMCD.*t20.*t22.*t44.*t45.*t48;
t464 = rBody.*t21.*t22.*t44.*t45.*t48;
t482 = rArm.*t20.*t25.*t45.*t47.*t48;
t483 = rArm.*t21.*t24.*t45.*t47.*t48;
t662 = mArm.*t20.*t22.*t25.*t44.*t45.*t47.*t48.*2.0;
t663 = mArm.*t21.*t22.*t24.*t44.*t45.*t47.*t48.*2.0;
t664 = mPB.*t20.*t22.*t25.*t44.*t45.*t47.*t48.*2.0;
t665 = mPB.*t21.*t22.*t24.*t44.*t45.*t47.*t48.*2.0;
t56 = t52.^2;
t57 = t53.^2;
t71 = InertiaArm.*mLeg.*rLegMCD.*t52;
t72 = ddthWaist.*mLeg.*rLegMCD.*t52;
t73 = rLegMCD.*t13.*t52;
t83 = -t69;
t84 = -t70;
t87 = mLeg.*rLegMCD.*t16.*t53;
t88 = mLeg.*rLegMCD.*t17.*t53;
t89 = mLeg.*rLegMCD.*t18.*t53;
t90 = dthHand.*dthWaist.*mLeg.*rLegMCD.*t53.*2.0;
t91 = dthHand.*dthShoulder.*mLeg.*rLegMCD.*t53.*2.0;
t92 = dthWaist.*dthShoulder.*mLeg.*rLegMCD.*t53.*2.0;
t125 = mArm.*mBody.*t25.*t54;
t126 = mArm.*mLeg.*t24.*t54;
t127 = mBody.*mLeg.*t24.*t54;
t128 = mBody.*mLeg.*t25.*t54;
t129 = mBody.*mPB.*t25.*t54;
t130 = mLeg.*mPB.*t24.*t54;
t131 = mArm.*mBody.*t25.*t55;
t132 = mArm.*mLeg.*t24.*t55;
t133 = mBody.*mLeg.*t24.*t55;
t134 = mBody.*mLeg.*t25.*t55;
t135 = mBody.*mPB.*t25.*t55;
t136 = mLeg.*mPB.*t24.*t55;
t137 = mBody.*mLeg.*rBody.*rBodyMCD.*t54.*2.0;
t167 = -t121;
t168 = -t122;
t169 = -t123;
t170 = -t124;
t171 = t20.*t25.*t55;
t172 = t21.*t24.*t55;
t176 = InertiaArm.*mBody.*mLeg.*rBody.*rBodyMCD.*t54.*-2.0;
t212 = mArm.*mLeg.*rArm.*rLegMCD.*t44.*t52;
t213 = mArm.*mLeg.*rArmMCD.*rLegMCD.*t44.*t52;
t214 = mLeg.*mPB.*rArm.*rLegMCD.*t44.*t52;
t215 = ddthWaist.*mLeg.*rArm.*rLegMCD.*t45.*t53;
t216 = mArm.*mLeg.*rArm.*rLegMCD.*t45.*t53;
t217 = mBody.*mLeg.*rArm.*rLegMCD.*t45.*t53;
t218 = mLeg.*mPB.*rArm.*rLegMCD.*t45.*t53;
t219 = mLeg.*rArm.*rLegMCD.*t4.*t44.*t52;
t220 = mLeg.*rLegMCD.*t52.*t59;
t221 = mPB.*rLegMCD.*t52.*t63;
t222 = mLeg.*rArm.*rLegMCD.*t4.*t45.*t53;
t223 = mLeg.*rArm.*rLegMCD.*t6.*t45.*t53;
t224 = mPB.*rArm.*rLegMCD.*t8.*t45.*t53;
t226 = ddthWaist.*mLeg.*rBody.*rLegMCD.*t48.*t53;
t227 = -t186;
t228 = -t188;
t232 = rArm.*t44.*t77;
t234 = rArm.*t44.*t78;
t236 = rArm.*t44.*t79;
t238 = rArm.*t44.*t80;
t240 = rArm.*t44.*t81;
t242 = rArm.*t44.*t82;
t243 = rArm.*rLegMCD.*t21.*t45.*t53;
t244 = mLeg.*rArm.*rLegMCD.*t8.*t45.*t53;
t247 = rLegMCD.*t52.*t76;
t249 = mLeg.*rArm.*rLegMCD.*t17.*t45.*t52;
t251 = mLeg.*rArm.*rLegMCD.*t18.*t45.*t52;
t253 = dthHand.*dthWaist.*mLeg.*rArm.*rLegMCD.*t45.*t52.*2.0;
t255 = dthHand.*dthShoulder.*mLeg.*rArm.*rLegMCD.*t45.*t52.*2.0;
t257 = dthWaist.*dthShoulder.*mLeg.*rArm.*rLegMCD.*t45.*t52.*2.0;
t259 = mArm.*mLeg.*rBody.*rLegMCD.*t47.*t52.*2.0;
t260 = mBody.*mLeg.*rBody.*rLegMCD.*t47.*t52.*2.0;
t261 = mBody.*mLeg.*rBodyMCD.*rLegMCD.*t47.*t52.*2.0;
t262 = mLeg.*mPB.*rBody.*rLegMCD.*t47.*t52.*2.0;
t263 = mArm.*mLeg.*rBody.*rLegMCD.*t48.*t53.*2.0;
t264 = mBody.*mLeg.*rBody.*rLegMCD.*t48.*t53.*2.0;
t265 = mLeg.*mPB.*rBody.*rLegMCD.*t48.*t53.*2.0;
t266 = -t200;
t267 = -t202;
t291 = dthHand.*dthWaist.*mLeg.*rArm.*rLegMCD.*t44.*t53.*-2.0;
t292 = dthHand.*dthShoulder.*mLeg.*rArm.*rLegMCD.*t44.*t53.*-2.0;
t293 = dthWaist.*dthShoulder.*mLeg.*rArm.*rLegMCD.*t44.*t53.*-2.0;
t295 = rBody.*rLegMCD.*t21.*t48.*t53.*2.0;
t296 = mArm.*rLegMCD.*t52.*t70.*2.0;
t297 = mBody.*rLegMCD.*t52.*t70.*2.0;
t298 = mLeg.*rLegMCD.*t52.*t69.*2.0;
t299 = mPB.*rLegMCD.*t52.*t70.*2.0;
t300 = mArm.*mLeg.*rArm.*rArmMCD.*rLegMCD.*t50.*t52;
t302 = mLeg.*rBody.*rLegMCD.*t17.*t48.*t52;
t307 = dthHand.*dthWaist.*mLeg.*rBody.*rLegMCD.*t48.*t52.*2.0;
t309 = dthWaist.*dthShoulder.*mLeg.*rBody.*rLegMCD.*t48.*t52.*2.0;
t310 = -t231;
t312 = -t235;
t319 = mBody.*mLeg.*rArm.*rBody.*rBodyMCD.*t44.*t54.*-2.0;
t325 = mArm.*mLeg.*rLegMCD.*t23.*t50.*t52;
t328 = mArm.*mLeg.*rLegMCD.*t23.*t51.*t52;
t330 = mBody.*mLeg.*rLegMCD.*t22.*t51.*t52;
t332 = dthHand.*dthWaist.*mLeg.*rBody.*rLegMCD.*t47.*t53.*-2.0;
t333 = dthWaist.*dthShoulder.*mLeg.*rBody.*rLegMCD.*t47.*t53.*-2.0;
t334 = -t274;
t335 = -t276;
t336 = -t280;
t337 = -t282;
t338 = -t284;
t339 = -t286;
t341 = rLegMCD.*t21.*t22.*t51.*t52;
t343 = -t315;
t344 = -t317;
t348 = mArm.*mBody.*mLeg.*rArm.*rArmMCD.*rBody.*rBodyMCD.*t50.*t54.*4.0;
t390 = mArm.*mBody.*mLeg.*rBody.*rBodyMCD.*t22.*t51.*t55.*2.0;
t391 = mBody.*mLeg.*mPB.*rBody.*rBodyMCD.*t22.*t51.*t55.*2.0;
t392 = rArmMCD.*t44.*t191;
t393 = rArmMCD.*t44.*t192;
t394 = mArm.*t20.*t22.*t25.*t51.*t54;
t397 = mBody.*t19.*t23.*t25.*t51.*t54;
t398 = mArm.*t21.*t22.*t24.*t51.*t54;
t401 = mLeg.*t19.*t23.*t24.*t51.*t54;
t402 = mBody.*t21.*t22.*t24.*t51.*t54;
t403 = mLeg.*t20.*t22.*t24.*t51.*t54;
t404 = mBody.*t21.*t22.*t25.*t51.*t54;
t405 = mLeg.*t20.*t22.*t25.*t51.*t54;
t406 = mPB.*t20.*t22.*t25.*t51.*t54;
t408 = mPB.*t21.*t22.*t24.*t51.*t54;
t412 = mBody.*t19.*t23.*t25.*t51.*t55;
t414 = mLeg.*t19.*t23.*t24.*t51.*t55;
t416 = mLeg.*t20.*t22.*t24.*t51.*t55;
t417 = mBody.*t21.*t22.*t25.*t51.*t55;
t421 = mArm.*mBody.*mLeg.*rBody.*rBodyMCD.*t22.*t50.*t54.*-2.0;
t422 = mArm.*mBody.*mLeg.*rBody.*rBodyMCD.*t23.*t50.*t54.*-2.0;
t423 = mBody.*mLeg.*mPB.*rBody.*rBodyMCD.*t22.*t50.*t54.*-2.0;
t426 = mBody.*rBody.*rBodyMCD.*t21.*t22.*t51.*t54.*2.0;
t427 = mLeg.*rBody.*rBodyMCD.*t20.*t22.*t51.*t54.*2.0;
t430 = mArm.*mBody.*mLeg.*rBody.*rBodyMCD.*t23.*t51.*t54.*-2.0;
t431 = mBody.*rBody.*rBodyMCD.*t21.*t22.*t51.*t55.*2.0;
t432 = mLeg.*rBody.*rBodyMCD.*t20.*t22.*t51.*t55.*2.0;
t455 = mBody.*mLeg.*rLegMCD.*t22.*t44.*t45.*t53;
t456 = rBodyMCD.*t47.*t193.*2.0;
t474 = rLegMCD.*t52.*t194;
t484 = rLegMCD.*t21.*t22.*t44.*t45.*t53;
t486 = rLegMCD.*t52.*t188.*2.0;
t490 = rLegMCD.*t52.*t198;
t494 = mBody.*mLeg.*rArm.*rBodyMCD.*rLegMCD.*t44.*t47.*t52.*-2.0;
t498 = rArm.*t21.*t26.*t45.*t52.*t53;
t499 = -t482;
t500 = -t483;
t508 = mArm.*mBody.*mLeg.*rArm.*rArmMCD.*rBody.*rLegMCD.*t48.*t50.*t53.*4.0;
t510 = mLeg.*rArm.*rBody.*rBodyMCD.*rLegMCD.*t20.*t45.*t53.*t55;
t524 = mBody.*rLegMCD.*t52.*t246.*4.0;
t525 = mLeg.*rLegMCD.*t52.*t245.*4.0;
t571 = mArm.*rArm.*rArmMCD.*rBody.*rLegMCD.*t21.*t48.*t50.*t53.*4.0;
t574 = mArm.*mBody.*mLeg.*rBodyMCD.*rLegMCD.*t22.*t48.*t51.*t53.*2.0;
t578 = mBody.*mLeg.*mPB.*rBodyMCD.*rLegMCD.*t22.*t48.*t51.*t53.*2.0;
t580 = mArm.*mBody.*mLeg.*rBodyMCD.*rLegMCD.*t22.*t47.*t50.*t52.*-2.0;
t582 = mLeg.*rLegMCD.*t52.*t274.*-2.0;
t584 = mBody.*mLeg.*mPB.*rBodyMCD.*rLegMCD.*t22.*t47.*t50.*t52.*-2.0;
t585 = mArm.*rLegMCD.*t52.*t317.*2.0;
t586 = mLeg.*rBody.*rLegMCD.*t19.*t23.*t47.*t51.*t52.*2.0;
t587 = mBody.*rLegMCD.*t52.*t317.*2.0;
t588 = mLeg.*rBody.*rLegMCD.*t20.*t22.*t47.*t51.*t52.*2.0;
t590 = mLeg.*rLegMCD.*t52.*t315.*2.0;
t591 = mPB.*rLegMCD.*t52.*t317.*2.0;
t594 = mLeg.*rLegMCD.*t52.*t280.*-2.0;
t602 = mLeg.*rBody.*rLegMCD.*t19.*t23.*t48.*t51.*t53.*2.0;
t604 = mLeg.*rBody.*rLegMCD.*t20.*t22.*t48.*t51.*t53.*2.0;
t605 = mBody.*rBodyMCD.*rLegMCD.*t21.*t22.*t48.*t51.*t53.*2.0;
t606 = mLeg.*rBodyMCD.*rLegMCD.*t20.*t22.*t48.*t51.*t53.*2.0;
t625 = mLeg.*rArmMCD.*rBody.*t45.*t48.*t185.*4.0;
t626 = mArm.*rBodyMCD.*t47.*t439.*4.0;
t627 = mPB.*rBodyMCD.*t47.*t439.*4.0;
t628 = mLeg.*rArmMCD.*rLegMCD.*t45.*t53.*t185.*2.0;
t630 = mLeg.*rBody.*rLegMCD.*t47.*t52.*t191;
t631 = mLeg.*rBody.*rLegMCD.*t48.*t53.*t185;
t632 = mLeg.*rBody.*rLegMCD.*t48.*t53.*t186;
t633 = mPB.*rBodyMCD.*rLegMCD.*t47.*t52.*t193;
t634 = mLeg.*rBody.*rLegMCD.*t48.*t53.*t189;
t638 = mArm.*rLegMCD.*t52.*t440.*2.0;
t640 = mPB.*rLegMCD.*t52.*t440.*2.0;
t644 = mLeg.*rBody.*rLegMCD.*t47.*t52.*t197;
t645 = mArm.*rArmMCD.*t44.*t482.*2.0;
t646 = mArm.*rArmMCD.*t44.*t483.*2.0;
t648 = mArm.*rLegMCD.*t52.*t464.*2.0;
t650 = mPB.*rLegMCD.*t52.*t464.*2.0;
t655 = mArm.*rLegMCD.*t52.*t483;
t656 = mArm.*rArm.*rLegMCD.*t21.*t24.*t44.*t47.*t48.*t53;
t657 = mArm.*rArmMCD.*rLegMCD.*t21.*t24.*t44.*t47.*t48.*t53;
t658 = mBody.*rLegMCD.*t52.*t483;
t659 = mLeg.*rLegMCD.*t52.*t482;
t660 = mPB.*rLegMCD.*t52.*t483;
t661 = mPB.*rArm.*rLegMCD.*t21.*t24.*t44.*t47.*t48.*t53;
t668 = mArm.*rArm.*rBody.*t21.*t26.*t44.*t48.*t52.*t53;
t669 = mArm.*rArmMCD.*rBody.*t21.*t26.*t44.*t48.*t52.*t53;
t673 = mPB.*rArm.*rBody.*t21.*t26.*t44.*t48.*t52.*t53;
t679 = -t662;
t680 = -t663;
t681 = -t664;
t682 = -t665;
t684 = mArm.*t21.*t22.*t26.*t44.*t45.*t52.*t53.*2.0;
t685 = mPB.*t21.*t22.*t26.*t44.*t45.*t52.*t53.*2.0;
t85 = -t71;
t86 = -t72;
t138 = InertiaArm.*t125;
t139 = InertiaArm.*t126;
t140 = InertiaArm.*t127;
t141 = InertiaArm.*t128;
t142 = InertiaArm.*t129;
t143 = InertiaArm.*t130;
t144 = InertiaArm.*t131;
t145 = InertiaArm.*t132;
t146 = InertiaArm.*t133;
t147 = InertiaArm.*t134;
t148 = InertiaArm.*t135;
t149 = InertiaArm.*t136;
t150 = InertiaArm.*t137;
t151 = ddthWaist.*mLeg.*t26.*t56;
t152 = mArm.*mLeg.*t26.*t56;
t153 = mBody.*mLeg.*t26.*t56;
t154 = mLeg.*mPB.*t26.*t56;
t155 = ddthWaist.*mLeg.*t26.*t57;
t156 = mArm.*mLeg.*t26.*t57;
t157 = mBody.*mLeg.*t26.*t57;
t158 = mLeg.*mPB.*t26.*t57;
t173 = -t137;
t174 = InertiaArm.*t171;
t175 = InertiaArm.*t172;
t177 = t21.*t26.*t57;
t211 = rArm.*t44.*t72;
t225 = rBody.*t47.*t72;
t248 = rArm.*t44.*t87;
t250 = rArm.*t44.*t88;
t252 = rArm.*t44.*t89;
t254 = rArm.*t44.*t90;
t256 = rArm.*t44.*t91;
t258 = rArm.*t44.*t92;
t270 = -t213;
t271 = -t219;
t272 = -t221;
t273 = rArmMCD.*t44.*t125;
t275 = rArmMCD.*t44.*t126;
t277 = rArm.*t44.*t127;
t278 = rArm.*t44.*t128;
t279 = rArmMCD.*t44.*t131;
t281 = rArmMCD.*t44.*t132;
t283 = rArm.*t44.*t133;
t285 = rArm.*t44.*t134;
t287 = rArm.*t44.*t137;
t288 = -t222;
t289 = -t223;
t290 = -t224;
t294 = -t261;
t301 = rBody.*t47.*t88;
t303 = InertiaArm.*t263;
t304 = InertiaArm.*t264;
t305 = InertiaArm.*t265;
t306 = rBody.*t47.*t90;
t308 = rBody.*t47.*t92;
t311 = -t234;
t313 = -t238;
t314 = rArm.*t44.*t171;
t316 = rArm.*t44.*t172;
t318 = -t244;
t320 = -t247;
t323 = -t298;
t331 = InertiaArm.*t295;
t345 = -t325;
t346 = -t328;
t347 = -t330;
t349 = -t341;
t350 = mBody.*t22.*t50.*t126;
t351 = mLeg.*t22.*t50.*t125;
t352 = mBody.*t23.*t50.*t126;
t353 = mLeg.*t23.*t50.*t125;
t354 = mPB.*t23.*t50.*t125;
t355 = mPB.*t23.*t50.*t126;
t356 = mPB.*t22.*t50.*t127;
t357 = mPB.*t22.*t50.*t128;
t358 = mBody.*t22.*t51.*t126;
t359 = mBody.*t22.*t50.*t132;
t360 = mLeg.*t22.*t51.*t125;
t361 = mLeg.*t22.*t50.*t131;
t362 = mBody.*t23.*t51.*t126;
t363 = mBody.*t23.*t50.*t132;
t364 = mLeg.*t23.*t51.*t125;
t365 = mLeg.*t23.*t50.*t131;
t366 = mPB.*t23.*t51.*t125;
t367 = mPB.*t23.*t50.*t131;
t368 = mPB.*t23.*t51.*t126;
t369 = mPB.*t23.*t50.*t132;
t370 = mPB.*t22.*t51.*t127;
t371 = mPB.*t22.*t50.*t133;
t372 = mPB.*t22.*t51.*t128;
t373 = mPB.*t22.*t50.*t134;
t374 = mBody.*rArm.*rArmMCD.*t50.*t126.*2.0;
t375 = mLeg.*rArm.*rArmMCD.*t50.*t125.*2.0;
t376 = mArm.*t22.*t50.*t137;
t377 = mArm.*t23.*t50.*t137;
t378 = mPB.*t22.*t50.*t137;
t379 = mBody.*t22.*t51.*t132;
t380 = mLeg.*t22.*t51.*t131;
t381 = mBody.*t23.*t51.*t132;
t382 = mLeg.*t23.*t51.*t131;
t383 = mPB.*t23.*t51.*t131;
t384 = mPB.*t23.*t51.*t132;
t385 = mPB.*t22.*t51.*t133;
t386 = mPB.*t22.*t51.*t134;
t387 = mBody.*rArm.*rArmMCD.*t50.*t132.*2.0;
t388 = mLeg.*rArm.*rArmMCD.*t50.*t131.*2.0;
t389 = mArm.*t23.*t51.*t137;
t395 = mArm.*t22.*t50.*t171;
t396 = mArm.*t23.*t50.*t171;
t399 = mArm.*t22.*t50.*t172;
t400 = mArm.*t23.*t50.*t172;
t407 = mPB.*t22.*t50.*t171;
t409 = mPB.*t22.*t50.*t172;
t410 = rArmMCD.*t44.*t216;
t411 = mArm.*t23.*t51.*t171;
t413 = mArm.*t23.*t51.*t172;
t415 = mBody.*t22.*t51.*t172;
t418 = mLeg.*t22.*t51.*t171;
t424 = mArm.*rArm.*rArmMCD.*t50.*t171.*2.0;
t425 = mArm.*rArm.*rArmMCD.*t50.*t172.*2.0;
t433 = -t390;
t434 = -t391;
t459 = -t426;
t460 = -t427;
t461 = -t431;
t462 = -t432;
t465 = mArm.*t21.*t22.*t26.*t51.*t56;
t468 = mLeg.*t19.*t23.*t26.*t51.*t56;
t469 = mBody.*t21.*t22.*t26.*t51.*t56;
t470 = mLeg.*t20.*t22.*t26.*t51.*t56;
t471 = mPB.*t21.*t22.*t26.*t51.*t56;
t473 = rBodyMCD.*t47.*t217;
t476 = mLeg.*t19.*t23.*t26.*t51.*t57;
t478 = mLeg.*t20.*t22.*t26.*t51.*t57;
t485 = -t456;
t487 = rArm.*t44.*t260;
t488 = rArm.*t44.*t261;
t489 = rBody.*t47.*t243;
t491 = rArmMCD.*t44.*t263;
t492 = rArm.*t44.*t264;
t495 = rArm.*t44.*t295;
t497 = -t474;
t502 = -t490;
t503 = mBody.*rBody.*rBodyMCD.*t55.*t216;
t504 = mPB.*rBody.*rBodyMCD.*t55.*t217;
t505 = mBody.*rBody.*rBodyMCD.*t54.*t212;
t506 = mBody.*rBody.*rBodyMCD.*t54.*t213;
t507 = mBody.*rBody.*rBodyMCD.*t54.*t214;
t509 = mBody.*rBody.*rBodyMCD.*t55.*t243;
t511 = -t498;
t513 = mLeg.*rArm.*rLegMCD.*t44.*t52.*t125;
t519 = mLeg.*rArm.*rLegMCD.*t44.*t52.*t131;
t527 = mLeg.*rArm.*rLegMCD.*t45.*t53.*t125;
t529 = mPB.*rArm.*rLegMCD.*t45.*t53.*t128;
t531 = mLeg.*rArm.*rLegMCD.*t45.*t53.*t131;
t533 = mPB.*rArm.*rLegMCD.*t45.*t53.*t134;
t534 = -t508;
t535 = mBody.*t22.*t50.*t259;
t536 = mArm.*t22.*t50.*t261;
t537 = mBody.*t23.*t50.*t259;
t538 = mArm.*t23.*t50.*t261;
t539 = mPB.*t23.*t50.*t259;
t540 = mPB.*t22.*t50.*t260;
t541 = mPB.*t22.*t50.*t261;
t545 = mArm.*rArmMCD.*rLegMCD.*t44.*t52.*t172;
t548 = mBody.*t22.*t51.*t259;
t549 = mBody.*t23.*t51.*t259;
t550 = mArm.*t23.*t51.*t261;
t551 = mPB.*t23.*t51.*t259;
t552 = mPB.*t22.*t51.*t260;
t553 = mArm.*t26.*t56.*t198;
t554 = mArm.*t24.*t54.*t243;
t555 = mBody.*t26.*t56.*t198;
t556 = mBody.*t24.*t54.*t243;
t557 = mBody.*t25.*t54.*t243;
t558 = mLeg.*t26.*t56.*t197;
t559 = mPB.*t26.*t56.*t198;
t560 = mPB.*t24.*t54.*t243;
t561 = -t524;
t563 = mBody.*t22.*t50.*t263;
t564 = mBody.*t23.*t50.*t263;
t565 = mPB.*t23.*t50.*t263;
t566 = mPB.*t22.*t50.*t264;
t568 = mBody.*t25.*t55.*t243;
t569 = mLeg.*t26.*t57.*t197;
t570 = mLeg.*rArm.*rLegMCD.*t45.*t53.*t171;
t572 = mBody.*rBody.*rBodyMCD.*t54.*t243.*2.0;
t573 = mBody.*t22.*t51.*t263;
t575 = mBody.*t23.*t51.*t263;
t576 = mPB.*t23.*t51.*t263;
t577 = mPB.*t22.*t51.*t264;
t589 = mBody.*rBodyMCD.*t47.*t341.*2.0;
t596 = mArm.*t22.*t50.*t295;
t597 = mArm.*t23.*t50.*t295;
t598 = mPB.*t22.*t50.*t295;
t601 = mArm.*t23.*t51.*t295;
t603 = mBody.*t22.*t51.*t295;
t607 = -t571;
t609 = -t574;
t611 = -t578;
t615 = -t590;
t623 = -t605;
t624 = -t606;
t629 = mLeg.*rLegMCD.*t52.*t392.*2.0;
t635 = -t626;
t636 = -t627;
t637 = mArm.*rBodyMCD.*t47.*t455.*2.0;
t639 = mPB.*rBodyMCD.*t47.*t455.*2.0;
t642 = mArm.*rArmMCD.*t44.*t490.*2.0;
t643 = mBody.*rBodyMCD.*t47.*t490;
t647 = mArm.*rBody.*t47.*t484.*2.0;
t649 = mPB.*rBody.*t47.*t484.*2.0;
t652 = -t638;
t654 = -t640;
t666 = mLeg.*rBody.*rLegMCD.*t48.*t53.*t227;
t667 = mArm.*rBody.*t47.*t498;
t670 = mBody.*rBody.*t47.*t498;
t671 = mBody.*rBodyMCD.*t47.*t498;
t672 = mPB.*rBody.*t47.*t498;
t675 = -t648;
t677 = -t650;
t678 = mArm.*rArmMCD.*t44.*t498.*2.0;
t686 = -t657;
t687 = mLeg.*rLegMCD.*t52.*t499;
t689 = -t668;
t692 = -t673;
t693 = -t684;
t694 = -t685;
t178 = InertiaArm.*t152;
t179 = InertiaArm.*t153;
t180 = InertiaArm.*t154;
t181 = InertiaArm.*t156;
t182 = InertiaArm.*t157;
t183 = InertiaArm.*t158;
t184 = InertiaArm.*t177;
t321 = -t250;
t322 = -t252;
t324 = rArmMCD.*t44.*t152;
t326 = rArm.*t44.*t153;
t327 = rArmMCD.*t44.*t156;
t329 = rArm.*t44.*t157;
t340 = rArm.*t44.*t177;
t342 = -t301;
t419 = -t374;
t420 = -t375;
t428 = -t387;
t429 = -t388;
t435 = mBody.*t22.*t50.*t152;
t436 = mBody.*t23.*t50.*t152;
t437 = mPB.*t23.*t50.*t152;
t438 = mPB.*t22.*t50.*t153;
t441 = mBody.*t22.*t51.*t152;
t442 = mBody.*t22.*t50.*t156;
t443 = mBody.*t23.*t51.*t152;
t444 = mBody.*t23.*t50.*t156;
t445 = mPB.*t23.*t51.*t152;
t446 = mPB.*t23.*t50.*t156;
t447 = mPB.*t22.*t51.*t153;
t448 = mPB.*t22.*t50.*t157;
t449 = mBody.*rArm.*rArmMCD.*t50.*t152.*2.0;
t450 = mBody.*t22.*t51.*t156;
t451 = mBody.*t23.*t51.*t156;
t452 = mPB.*t23.*t51.*t156;
t453 = mPB.*t22.*t51.*t157;
t454 = mBody.*rArm.*rArmMCD.*t50.*t156.*2.0;
t457 = -t424;
t458 = -t425;
t466 = mArm.*t22.*t50.*t177;
t467 = mArm.*t23.*t50.*t177;
t472 = mPB.*t22.*t50.*t177;
t475 = mArm.*t23.*t51.*t177;
t477 = mBody.*t22.*t51.*t177;
t480 = mArm.*rArm.*rArmMCD.*t50.*t177.*2.0;
t496 = -t473;
t501 = -t489;
t512 = mBody.*rArm.*rBodyMCD.*t44.*t47.*t152;
t515 = mLeg.*rLegMCD.*t52.*t273;
t517 = mPB.*rLegMCD.*t52.*t278;
t518 = mBody.*rArm.*rBodyMCD.*t44.*t47.*t156;
t521 = mLeg.*rLegMCD.*t52.*t279;
t523 = mPB.*rLegMCD.*t52.*t285;
t526 = mBody.*rArm.*rBodyMCD.*t45.*t48.*t152;
t528 = mPB.*rArm.*rBodyMCD.*t45.*t48.*t153;
t530 = mBody.*rArm.*rBodyMCD.*t45.*t48.*t156;
t532 = mPB.*rArm.*rBodyMCD.*t45.*t48.*t157;
t543 = mArm.*rLegMCD.*t52.*t316;
t544 = mArm.*rArmMCD.*rBody.*t44.*t47.*t177;
t547 = mPB.*rLegMCD.*t52.*t316;
t562 = mBody.*rBody.*rBodyMCD.*t54.*t270;
t567 = mBody.*rArm.*rBodyMCD.*t45.*t48.*t177;
t579 = -t513;
t592 = -t519;
t599 = -t527;
t600 = -t529;
t608 = -t531;
t610 = -t533;
t614 = -t589;
t617 = -t554;
t618 = -t556;
t619 = -t557;
t620 = -t560;
t621 = -t568;
t622 = -t570;
t641 = mArm.*rArmMCD.*t44.*t489.*2.0;
t651 = -t637;
t653 = -t639;
t674 = -t647;
t676 = -t649;
t683 = mBody.*rBodyMCD.*t47.*t502;
t688 = mArm.*rBody.*t47.*t511;
t690 = mBody.*rBody.*t47.*t511;
t691 = mPB.*rBody.*t47.*t511;
t695 = MrPB+t37+t38+t39+t40+t41+t74+t75+t76+t77+t78+t79+t80+t81+t82+t86+t87+t88+t89+t90+t91+t92;
t699 = t3+t4+t5+t6+t7+t8+t9+t10+t125+t126+t127+t128+t129+t130+t131+t132+t133+t134+t135+t136+t152+t153+t154+t156+t157+t158+t171+t172+t173+t177+t185+t187+t189+t190+t191+t192+t193+t194+t195+t196+t197+t198+t212+t214+t216+t217+t218+t227+t228+t243+t259+t260+t262+t263+t264+t265+t270+t294+t295;
t479 = -t449;
t481 = -t454;
t493 = -t480;
t514 = mBody.*rBodyMCD.*t47.*t324;
t516 = mPB.*rBodyMCD.*t47.*t326;
t520 = mBody.*rBodyMCD.*t47.*t327;
t522 = mPB.*rBodyMCD.*t47.*t329;
t542 = mArm.*rBody.*t47.*t340;
t546 = mPB.*rBody.*t47.*t340;
t583 = -t517;
t595 = -t523;
t612 = -t543;
t613 = -t544;
t616 = -t547;
t696 = t2+t36+t67+t68+t73+t151+t155+t225+t226+t232+t236+t248+t302+t307+t309+t310+t312+t320+t332+t333+t342;
t697 = t2+t35+t64+t65+t66+t67+t68+t73+t151+t155+t211+t215+t225+t226+t233+t237+t239+t241+t249+t251+t253+t255+t257+t268+t269+t291+t292+t293+t302+t307+t309+t311+t313+t321+t322+t332+t333+t342;
t698 = t58+t59+t60+t61+t62+t63+t273+t275+t277+t278+t279+t281+t283+t285+t314+t316+t319+t324+t326+t327+t329+t340+t485+t486+t487+t491+t492+t494+t495+t496+t497+t499+t500+t501+t502+t511;
t581 = -t514;
t593 = -t520;
t700 = t83+t84+t85+t245+t246+t300+t334+t335+t336+t337+t338+t339+t343+t344+t345+t346+t347+t349+t392+t393+t410+t439+t440+t455+t463+t464+t484+t698;
t701 = t27+t28+t29+t30+t31+t32+t33+t34+t93+t94+t95+t96+t97+t98+t99+t100+t101+t102+t103+t104+t105+t106+t107+t108+t109+t110+t111+t112+t113+t114+t115+t116+t117+t118+t119+t120+t138+t139+t140+t141+t142+t143+t144+t145+t146+t147+t148+t149+t159+t160+t161+t162+t163+t164+t165+t166+t167+t168+t169+t170+t174+t175+t176+t178+t179+t180+t181+t182+t183+t184+t296+t297+t299+t303+t304+t305+t323+t331+t348+t350+t351+t352+t353+t354+t355+t356+t357+t358+t359+t360+t361+t362+t363+t364+t365+t366+t367+t368+t369+t370+t371+t372+t373+t379+t380+t381+t382+t383+t384+t385+t386+t394+t395+t396+t397+t398+t399+t400+t401+t402+t403+t404+t405+t406+t407+t408+t409+t411+t412+t413+t414+t415+t416+t417+t418+t419+t420+t421+t422+t423+t428+t429+t430+t433+t434+t435+t436+t437+t438+t441+t442+t443+t444+t445+t446+t447+t448+t450+t451+t452+t453+t457+t458+t459+t460+t461+t462+t465+t466+t467+t468+t469+t470+t471+t472+t475+t476+t477+t478+t479+t481+t493+t525+t534+t535+t537+t539+t540+t548+t549+t551+t552+t561+t563+t564+t565+t566+t573+t575+t576+t577+t580+t582+t584+t585+t586+t587+t588+t591+t594+t596+t597+t598+t601+t602+t603+t604+t607+t609+t611+t614+t615+t623+t624+t625+t628+t629+t635+t636+t641+t642+t645+t646+t651+t652+t653+t654+t674+t675+t676+t677+t678+t679+t680+t681+t682+t693+t694;
t702 = 1.0./t701;
ddrPB = t697.*t698.*t702-t696.*t700.*t702+t695.*t702.*(InertiaLeg.*InertiaArm+InertiaArm.*InertiaBody-rBody.*t47.*t484.*2.0-rBodyMCD.*t47.*t439.*4.0-rBodyMCD.*t47.*t455.*2.0+rLegMCD.*t52.*t70.*2.0+rLegMCD.*t52.*t317.*2.0-rLegMCD.*t52.*t440.*2.0-rLegMCD.*t52.*t464.*2.0+t3.*t23.*t50+t3.*t23.*t51+t4.*t23.*t50+t5.*t22.*t50+t4.*t23.*t51+t5.*t22.*t51+t6.*t22.*t50+t6.*t22.*t51+t7.*t22.*t50+t7.*t22.*t51+t8.*t22.*t50+t8.*t22.*t51+t23.*t50.*t125+t22.*t50.*t127+t23.*t50.*t126+t23.*t51.*t125+t22.*t50.*t128+t22.*t51.*t127+t23.*t51.*t126+t22.*t51.*t128+t23.*t50.*t131+t22.*t50.*t133+t23.*t50.*t132+t23.*t51.*t131+t22.*t50.*t134+t22.*t51.*t133+t23.*t51.*t132+t22.*t51.*t134+t22.*t50.*t153+t23.*t50.*t152+t22.*t51.*t153+t23.*t51.*t152+t22.*t50.*t157+t23.*t50.*t156+t22.*t51.*t157+t23.*t51.*t156+t22.*t50.*t171+t22.*t50.*t172+t22.*t50.*t177+t22.*t50.*t260+t23.*t50.*t259+t22.*t51.*t260+t23.*t51.*t259+t22.*t50.*t264+t23.*t50.*t263+t22.*t51.*t264+t23.*t51.*t263+t22.*t50.*t295+InertiaArm.*mBody.*t25.*t54+InertiaArm.*mBody.*t25.*t55+InertiaArm.*mLeg.*t24.*t54+InertiaArm.*mLeg.*t24.*t55+InertiaArm.*mLeg.*t26.*t56+InertiaArm.*mLeg.*t26.*t57+t20.*t22.*t25.*t51.*t54+t21.*t22.*t24.*t51.*t54+t21.*t22.*t26.*t51.*t56+InertiaArm.*mLeg.*rBody.*rLegMCD.*t48.*t53.*2.0-mBody.*mLeg.*rBody.*rBodyMCD.*t22.*t50.*t54.*2.0-mBody.*mLeg.*rBody.*rBodyMCD.*t22.*t51.*t55.*2.0-t20.*t22.*t25.*t44.*t45.*t47.*t48.*2.0-t21.*t22.*t24.*t44.*t45.*t47.*t48.*2.0-t21.*t22.*t26.*t44.*t45.*t52.*t53.*2.0-mBody.*mLeg.*rBodyMCD.*rLegMCD.*t22.*t47.*t50.*t52.*2.0-mBody.*mLeg.*rBodyMCD.*rLegMCD.*t22.*t48.*t51.*t53.*2.0);
if nargout > 1
    ddthHand = -t695.*t698.*t702+t696.*t699.*t702-t697.*t702.*(t3+t4+t5+t6+t7+t8+t9+t10+t125+t126+t127+t128+t129+t130+t131+t132+t133+t134+t135+t136+t152+t153+t154+t156+t157+t158+t171+t172+t173+t177+t259+t260+t262+t263+t264+t265+t294+t295);
end
if nargout > 2
    ddthShoulder = t695.*t700.*t702+t697.*t699.*t702-t696.*t702.*(t3+t4+t5+t6+t7+t8+t9+t10+t125+t126+t127+t128+t129+t130+t131+t132+t133+t134+t135+t136+t152+t153+t154+t156+t157+t158+t171+t172+t173+t177+t185.*2.0-t186.*2.0+t187.*2.0-t188.*2.0+t189.*2.0+t190.*2.0+t191.*2.0+t192.*2.0+t193.*2.0+t194.*2.0+t195.*2.0+t196.*2.0+t197.*2.0+t198.*2.0+t212.*2.0-t213.*2.0+t214.*2.0+t216.*2.0+t217.*2.0+t218.*2.0+t243.*2.0+t259+t260+t262+t263+t264+t265+t294+t295+InertiaArm.*mArm+InertiaArm.*mBody+InertiaArm.*mLeg+InertiaArm.*mPB+t19.*t23.*t51+t20.*t22.*t51+t21.*t22.*t51+mArm.*mBody.*t22.*t50+mArm.*mBody.*t22.*t51+mArm.*mBody.*t23.*t50+mArm.*mBody.*t23.*t51+mArm.*mLeg.*t22.*t50+mArm.*mLeg.*t22.*t51+mArm.*mLeg.*t23.*t50+mArm.*mLeg.*t23.*t51+mBody.*mLeg.*t22.*t51.*2.0+mArm.*mPB.*t23.*t50+mArm.*mPB.*t23.*t51+mBody.*mPB.*t22.*t50+mBody.*mPB.*t22.*t51+mLeg.*mPB.*t22.*t50+mLeg.*mPB.*t22.*t51-mArm.*mBody.*rArm.*rArmMCD.*t50.*2.0-mArm.*mLeg.*rArm.*rArmMCD.*t50.*2.0);
end
if nargout > 3
    MthWaist = t2+t73+t151+t155+t248+t320-t696.*t702.*(t27+t29+t31+t33+t93+t95+t97+t99+t101+t103+t105+t107+t109+t111+t113+t115+t117+t119+t159+t161+t163+t165+t167+t169+t178+t179+t180+t181+t182+t183+t184+t199+t201+t203+t204+t205+t206+t207+t208+t209+t210+t220+t229+t230+t266+t267+t271+t272+t288+t289+t290+t318+t435+t436+t437+t438+t441+t442+t443+t444+t445+t446+t447+t448+t450+t451+t452+t453+t465+t466+t467+t468+t469+t470+t471+t472+t475+t476+t477+t478+t479+t481+t493+t503+t504+t505+t507+t509+t510+t512+t515+t516+t518+t521+t522+t526+t528+t530+t532+t542+t545+t546+t553+t555+t558+t559+t562+t567+t569+t572+t579+t581+t583+t592+t593+t595+t599+t600+t608+t610+t612+t613+t616+t617+t618+t619+t620+t621+t622+t630+t631+t633+t634+t644+t655+t656+t658+t660+t661+t666+t669+t671+t678+t683+t686+t687+t688+t689+t690+t691+t692+t693+t694+mArm.*rArmMCD.*t44.*t489+mArm.*rArmMCD.*t44.*t490-mArm.*rBody.*t47.*t484-mArm.*rBodyMCD.*t47.*t455+mBody.*rBodyMCD.*t47.*t349+mArm.*rLegMCD.*t52.*t70+mArm.*rLegMCD.*t52.*t284+mArm.*rLegMCD.*t52.*t317-mArm.*rLegMCD.*t52.*t440-mArm.*rLegMCD.*t52.*t464+mBody.*rLegMCD.*t52.*t70-mBody.*rLegMCD.*t52.*t246.*2.0+mBody.*rLegMCD.*t52.*t276+mBody.*rLegMCD.*t52.*t282+mBody.*rLegMCD.*t52.*t317-mPB.*rBody.*t47.*t484-mPB.*rBodyMCD.*t47.*t455+mLeg.*rLegMCD.*t52.*t83+mLeg.*rLegMCD.*t52.*t245.*2.0+mLeg.*rLegMCD.*t52.*t334+mLeg.*rLegMCD.*t52.*t336+mLeg.*rLegMCD.*t52.*t343+mLeg.*rLegMCD.*t52.*t392+mPB.*rLegMCD.*t52.*t70+mPB.*rLegMCD.*t52.*t276+mPB.*rLegMCD.*t52.*t282+mPB.*rLegMCD.*t52.*t284+mPB.*rLegMCD.*t52.*t317-mPB.*rLegMCD.*t52.*t440-mPB.*rLegMCD.*t52.*t464+mLeg.*rArmMCD.*rLegMCD.*t45.*t53.*t185+InertiaArm.*rBody.*rLegMCD.*t21.*t48.*t53+InertiaArm.*mArm.*mLeg.*rBody.*rLegMCD.*t48.*t53+InertiaArm.*mBody.*mLeg.*rBody.*rLegMCD.*t48.*t53+InertiaArm.*mLeg.*mPB.*rBody.*rLegMCD.*t48.*t53+mArm.*rBody.*rLegMCD.*t21.*t22.*t48.*t50.*t53+mArm.*rBody.*rLegMCD.*t21.*t23.*t48.*t50.*t53+mArm.*rBody.*rLegMCD.*t21.*t23.*t48.*t51.*t53+mBody.*rBody.*rLegMCD.*t21.*t22.*t48.*t51.*t53-mBody.*rBodyMCD.*rLegMCD.*t21.*t22.*t48.*t51.*t53+mLeg.*rBody.*rLegMCD.*t19.*t23.*t47.*t51.*t52+mLeg.*rBody.*rLegMCD.*t20.*t22.*t47.*t51.*t52+mLeg.*rBody.*rLegMCD.*t19.*t23.*t48.*t51.*t53+mLeg.*rBody.*rLegMCD.*t20.*t22.*t48.*t51.*t53-mLeg.*rBodyMCD.*rLegMCD.*t20.*t22.*t48.*t51.*t53+mPB.*rBody.*rLegMCD.*t21.*t22.*t48.*t50.*t53+mArm.*mBody.*mLeg.*rBody.*rLegMCD.*t22.*t47.*t50.*t52+mArm.*mBody.*mLeg.*rBody.*rLegMCD.*t22.*t48.*t50.*t53+mArm.*mBody.*mLeg.*rBody.*rLegMCD.*t22.*t48.*t51.*t53+mArm.*mBody.*mLeg.*rBody.*rLegMCD.*t23.*t48.*t50.*t53+mArm.*mBody.*mLeg.*rBody.*rLegMCD.*t23.*t48.*t51.*t53-mArm.*mBody.*mLeg.*rBodyMCD.*rLegMCD.*t22.*t47.*t50.*t52-mArm.*mBody.*mLeg.*rBodyMCD.*rLegMCD.*t22.*t48.*t51.*t53+mArm.*mLeg.*mPB.*rBody.*rLegMCD.*t23.*t48.*t50.*t53+mArm.*mLeg.*mPB.*rBody.*rLegMCD.*t23.*t48.*t51.*t53+mBody.*mLeg.*mPB.*rBody.*rLegMCD.*t22.*t47.*t50.*t52+mBody.*mLeg.*mPB.*rBody.*rLegMCD.*t22.*t48.*t50.*t53+mBody.*mLeg.*mPB.*rBody.*rLegMCD.*t22.*t48.*t51.*t53-mBody.*mLeg.*mPB.*rBodyMCD.*rLegMCD.*t22.*t47.*t50.*t52-mBody.*mLeg.*mPB.*rBodyMCD.*rLegMCD.*t22.*t48.*t51.*t53-mArm.*rArm.*rArmMCD.*rBody.*rLegMCD.*t21.*t48.*t50.*t53.*2.0-mArm.*mBody.*mLeg.*rArm.*rArmMCD.*rBody.*rLegMCD.*t48.*t50.*t53.*2.0)-t695.*t702.*(-rArmMCD.*t44.*t553+rArmMCD.*t44.*t554+rArmMCD.*t44.*t667+rBody.*t31.*t47+rBody.*t47.*t99+rBody.*t47.*t113+rBody.*t47.*t163+rBody.*t47.*t184+rBodyMCD.*t29.*t47+rBodyMCD.*t47.*t95+rBodyMCD.*t47.*t109+rBodyMCD.*t47.*t161+rBody.*t47.*t467+rBody.*t47.*t475+rBody.*t47.*t477+rBodyMCD.*t47.*t436+rBodyMCD.*t47.*t443+rBodyMCD.*t47.*t444+rBodyMCD.*t47.*t451+rBodyMCD.*t47.*t469-rLegMCD.*t32.*t52-rLegMCD.*t52.*t100-rLegMCD.*t52.*t114-rLegMCD.*t52.*t164-rLegMCD.*t52.*t175-rLegMCD.*t52.*t353-rLegMCD.*t52.*t364-rLegMCD.*t52.*t365-rLegMCD.*t52.*t382-rLegMCD.*t52.*t400-rLegMCD.*t52.*t405-rLegMCD.*t52.*t413-rLegMCD.*t52.*t415+mBody.*t25.*t54.*t85+mBody.*t25.*t55.*t85+mBody.*t25.*t54.*t349+mBody.*t25.*t55.*t349-mBody.*t26.*t56.*t464+mBody.*t24.*t54.*t484+mBody.*t25.*t54.*t484+mBody.*t25.*t55.*t484+mLeg.*t26.*t56.*t69+mLeg.*t26.*t57.*t69+mLeg.*t26.*t56.*t315+mLeg.*t26.*t57.*t315-mLeg.*t26.*t56.*t463-mLeg.*t26.*t57.*t463+mBody.*rBody.*rBodyMCD.*t54.*t71-mBody.*rBody.*rBodyMCD.*t54.*t300+mBody.*rBody.*rBodyMCD.*t54.*t325+mBody.*rBody.*rBodyMCD.*t54.*t328+mBody.*rBody.*rBodyMCD.*t54.*t341+mBody.*rBody.*rBodyMCD.*t55.*t341.*2.0-mBody.*rBody.*rBodyMCD.*t55.*t410-mBody.*rBody.*rBodyMCD.*t54.*t484.*2.0-mBody.*rBody.*rBodyMCD.*t55.*t484-mBody.*rArm.*rBodyMCD.*t45.*t48.*t58-mBody.*rArm.*rBodyMCD.*t45.*t48.*t324-mBody.*rArm.*rBodyMCD.*t45.*t48.*t327+mArm.*rArmMCD.*rLegMCD.*t44.*t52.*t500-mLeg.*rArm.*rBody.*t45.*t48.*t58+mBody.*rBodyMCD.*rLegMCD.*t48.*t53.*t344+mBody.*rBodyMCD.*rLegMCD.*t47.*t52.*t464+mLeg.*rArm.*rLegMCD.*t45.*t53.*t59+mLeg.*rArm.*rLegMCD.*t45.*t53.*t273+mLeg.*rArm.*rLegMCD.*t45.*t53.*t279+mLeg.*rBody.*rLegMCD.*t48.*t53.*t69-mLeg.*rBody.*rLegMCD.*t48.*t53.*t245+mLeg.*rBody.*rLegMCD.*t48.*t53.*t274+mLeg.*rBody.*rLegMCD.*t48.*t53.*t280+mLeg.*rBody.*rLegMCD.*t48.*t53.*t315-mLeg.*rBody.*rLegMCD.*t47.*t52.*t463+mLeg.*rBody.*t5.*t22.*t47.*t51+mLeg.*rBodyMCD.*t5.*t22.*t47.*t51-mLeg.*rLegMCD.*t6.*t22.*t51.*t52-InertiaArm.*rBody.*t21.*t26.*t48.*t52.*t53+InertiaArm.*rLegMCD.*t21.*t24.*t47.*t48.*t53-mArm.*rArm.*rArmMCD.*rBody.*t47.*t50.*t177-mBody.*rArm.*rArmMCD.*rBodyMCD.*t3.*t47.*t50-mBody.*rArm.*rArmMCD.*rBodyMCD.*t47.*t50.*t152-mBody.*rArm.*rArmMCD.*rBodyMCD.*t47.*t50.*t156+mArm.*rArm.*rArmMCD.*rLegMCD.*t50.*t52.*t172-mLeg.*rArm.*rArmMCD.*rBody.*t3.*t47.*t50+mLeg.*rArm.*rArmMCD.*rLegMCD.*t4.*t50.*t52+mLeg.*rArm.*rArmMCD.*rLegMCD.*t50.*t52.*t125+mLeg.*rArm.*rArmMCD.*rLegMCD.*t50.*t52.*t131-mBody.*rBodyMCD.*t5.*t22.*t44.*t45.*t48-mBody.*rBodyMCD.*t22.*t44.*t45.*t48.*t177-mLeg.*rBody.*t5.*t22.*t44.*t45.*t48-mLeg.*rBody.*t7.*t22.*t44.*t45.*t48-mLeg.*rBodyMCD.*t5.*t22.*t44.*t45.*t48+mLeg.*rLegMCD.*t6.*t22.*t44.*t45.*t53+mLeg.*rLegMCD.*t8.*t22.*t44.*t45.*t53+mLeg.*rLegMCD.*t22.*t44.*t45.*t53.*t171-mLeg.*rArmMCD.*rBody.*rLegMCD.*t45.*t48.*t52.*t185+mLeg.*rBody.*rBodyMCD.*rLegMCD.*t20.*t22.*t51.*t52.*t54-mArm.*rBody.*t21.*t23.*t26.*t48.*t50.*t52.*t53-mArm.*rBody.*t21.*t23.*t26.*t48.*t51.*t52.*t53-mBody.*rBody.*t21.*t22.*t26.*t48.*t51.*t52.*t53+mBody.*rBodyMCD.*t21.*t22.*t26.*t48.*t51.*t52.*t53+mArm.*rLegMCD.*t21.*t23.*t24.*t47.*t48.*t50.*t53+mArm.*rLegMCD.*t21.*t23.*t24.*t47.*t48.*t51.*t53+mBody.*rLegMCD.*t21.*t22.*t24.*t47.*t48.*t51.*t53-mLeg.*rLegMCD.*t20.*t22.*t25.*t47.*t48.*t51.*t53+mArm.*rArm.*rArmMCD.*rBody.*t21.*t26.*t48.*t50.*t52.*t53-mArm.*rArm.*rArmMCD.*rLegMCD.*t21.*t24.*t47.*t48.*t50.*t53-mLeg.*rBody.*rBodyMCD.*rLegMCD.*t20.*t22.*t44.*t45.*t53.*t55+mBody.*rBody.*t21.*t22.*t26.*t44.*t45.*t47.*t52.*t53-mBody.*rBodyMCD.*t21.*t22.*t26.*t44.*t45.*t47.*t52.*t53-mBody.*rLegMCD.*t21.*t22.*t24.*t44.*t45.*t47.*t48.*t52+mLeg.*rLegMCD.*t20.*t22.*t25.*t44.*t45.*t47.*t48.*t52)+t697.*t702.*(t199+t201+t203+t204+t205+t206+t207+t208+t209+t210+t220+t229+t230+t266+t267+t271+t272+t288+t289+t290+t318+t503+t504+t505+t507+t509+t510+t512+t515+t516+t518+t521+t522+t526+t528+t530+t532+t542+t545+t546+t553+t555+t558+t559+t562+t567+t569+t572+t579+t581+t583+t592+t593+t595+t599+t600+t608+t610+t612+t613+t616+t617+t618+t619+t620+t621+t622+t630+t631+t633+t634+t644+t655+t656+t658+t660+t661+t666+t669+t671+t683+t686+t687+t688+t689+t690+t691+t692)+rBody.*t47.*t87+rBody.*t47.*t89+rBody.*t47.*t91-rLegMCD.*t52.*t79-rLegMCD.*t52.*t80-dthHand.*dthShoulder.*mLeg.*rBody.*rLegMCD.*t48.*t52.*2.0;
end
