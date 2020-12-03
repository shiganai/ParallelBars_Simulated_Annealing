function [ddrPB,ddthHand,ddthWaist] = find_ddrPB_ddthHand_ddthWaist(constants,MrPB,MthHand,MthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,rPB,thHand,thShoulder,thWaist)
%FIND_DDRPB_DDTHHAND_DDTHWAIST
%    [DDRPB,DDTHHAND,DDTHWAIST] = FIND_DDRPB_DDTHHAND_DDTHWAIST(MRPB,MTHHAND,MTHWAIST,DDTHSHOULDER,DTHHAND,DTHWAIST,DTHSHOULDER,G,KPB,MARM,MBODY,MLEG,MPB,RARM,RBODY,RLEG,RPB,THHAND,THSHOULDER,THWAIST)

%    This function was generated by the Symbolic Math Toolbox version 8.4.
%    22-Apr-2020 22:15:39

g = constants.g;
kPB = constants.kPB;
cPB = constants.cPB;
mAll = constants.mAll;
mPB = constants.mPB;
rAll = constants.rAll;

mArm = constants.mArm;
mBody = constants.mBody;
mLeg = constants.mLeg;

rArm = constants.rArm;
rBody = constants.rBody;
rLeg = constants.rLeg;

InertiaModel = constants.InertiaModel;

rArmMCD = constants.rArmMCD;
rBodyMCD = constants.rBodyMCD;
rLegMCD = constants.rLegMCD;

InertiaArm = constants.InertiaArm;
InertiaBody = constants.InertiaBody;
InertiaLeg = constants.InertiaLeg;

inertiaG = constants.inertiaG;

t2 = cos(thHand);
t3 = sin(thHand);
t4 = g.*mArm;
t5 = g.*mBody;
t6 = g.*mLeg;
t7 = g.*mPB;
t8 = kPB.*rPB;
t9 = mArm.*rLeg;
t10 = mBody.*rLeg;
t11 = mLeg.*rLeg;
t12 = mPB.*rLeg;
t13 = thHand+thShoulder;
t14 = dthHand.^2;
t15 = dthWaist.^2;
t16 = dthShoulder.^2;
t17 = mArm.^2;
t18 = mBody.^2;
t19 = mLeg.^2;
t20 = mLeg.^3;
t21 = rArm.^2;
t22 = rBody.^2;
t23 = rLeg.^2;
t27 = -MthHand;
t28 = -MthWaist;
t39 = pi./2.0;
t24 = t2.^2;
t25 = t3.^2;
t26 = cos(t13);
t29 = sin(t13);
t30 = t13+thWaist;
t32 = mArm.*rArm.*t3;
t34 = -t4;
t35 = -t5;
t36 = -t6;
t37 = -t7;
t38 = -t8;
t41 = mArm.*mBody.*t22;
t42 = mBody.*mLeg.*t22;
t43 = mBody.*mPB.*t22;
t45 = mBody.*rArm.*t3.*2.0;
t46 = mLeg.*rArm.*t3.*2.0;
t47 = rArm.*t3.*t9;
t48 = mArm.*mBody.*t21.*4.0;
t49 = mArm.*mLeg.*t21.*4.0;
t50 = mArm.*mPB.*t21.*4.0;
t51 = mBody.*t9.*t22;
t52 = mLeg.*t10.*t22;
t53 = mPB.*t10.*t22;
t55 = t39+thHand;
t57 = rArm.*t3.*t10.*2.0;
t58 = rArm.*t3.*t11.*2.0;
t60 = t18.*t22;
t63 = mBody.*t10.*t22;
t64 = mBody.*t9.*t21.*4.0;
t65 = mLeg.*t9.*t21.*4.0;
t66 = mPB.*t9.*t21.*4.0;
t67 = mBody.*rArm.*t2.*t14;
t68 = mLeg.*rArm.*t2.*t14;
t70 = t13+t39;
t72 = t17.*t21.*4.0;
t76 = mArm.*t9.*t21.*4.0;
t78 = (ddthShoulder.*mBody.*t22)./1.2e+1;
t79 = (ddthShoulder.*rLeg.*t11)./1.2e+1;
t105 = (mArm.*rArm.*t2.*t14)./2.0;
t31 = cos(t30);
t33 = sin(t30);
t40 = t26.^2;
t44 = t29.^2;
t59 = mBody.*rBody.*t29;
t61 = ddthShoulder.*mLeg.*rBody.*t29;
t62 = rBody.*t10.*t29;
t69 = cos(t55);
t71 = mLeg.*rBody.*t29.*2.0;
t73 = cos(t70);
t74 = t30+t39;
t75 = rBody.*t11.*t29.*2.0;
t77 = dthHand.*dthShoulder.*mBody.*rBody.*t26;
t83 = mLeg.*rBody.*t14.*t26;
t84 = mLeg.*rBody.*t16.*t26;
t85 = dthHand.*dthShoulder.*mLeg.*rBody.*t26.*2.0;
t95 = ddthShoulder.*mLeg.*rArm.*rBody.*t2.*t26;
t110 = mArm.*mBody.*t21.*t24.*1.2e+1;
t111 = mArm.*mLeg.*t21.*t24.*1.2e+1;
t112 = mBody.*mLeg.*t21.*t24.*2.4e+1;
t113 = mBody.*mPB.*t21.*t24.*1.2e+1;
t114 = mLeg.*mPB.*t21.*t24.*1.2e+1;
t115 = t17.*t21.*t25.*3.0;
t116 = mBody.*mPB.*t21.*t25.*1.2e+1;
t117 = mLeg.*mPB.*t21.*t25.*1.2e+1;
t126 = mLeg.*rArm.*rBody.*t2.*t16.*t29;
t131 = dthHand.*dthShoulder.*rBody.*t26.*t46;
t142 = t18.*t21.*t24.*1.2e+1;
t143 = t19.*t21.*t24.*1.2e+1;
t151 = mArm.*mBody.*rArm.*rBody.*t2.*t26.*1.2e+1;
t152 = mArm.*mLeg.*rArm.*rBody.*t2.*t26.*2.4e+1;
t153 = mBody.*mLeg.*rArm.*rBody.*t2.*t26.*3.6e+1;
t154 = mBody.*mPB.*rArm.*rBody.*t2.*t26.*1.2e+1;
t155 = mLeg.*mPB.*rArm.*rBody.*t2.*t26.*2.4e+1;
t159 = (mBody.*rBody.*t14.*t26)./2.0;
t160 = (mBody.*rBody.*t16.*t26)./2.0;
t161 = mBody.*t9.*t21.*t24.*1.2e+1;
t162 = mLeg.*t9.*t21.*t24.*1.2e+1;
t163 = mLeg.*t10.*t21.*t24.*2.4e+1;
t164 = mPB.*t10.*t21.*t24.*1.2e+1;
t165 = mPB.*t11.*t21.*t24.*1.2e+1;
t168 = mArm.*t9.*t21.*t25.*3.0;
t169 = mLeg.*rBody.*t29.*t32.*1.2e+1;
t171 = mLeg.*mPB.*rArm.*rBody.*t3.*t29.*2.4e+1;
t172 = mPB.*t10.*t21.*t25.*1.2e+1;
t173 = mPB.*t11.*t21.*t25.*1.2e+1;
t177 = dthHand.*dthShoulder.*mLeg.*rArm.*rBody.*t2.*t29.*-2.0;
t178 = mBody.*rArm.*rBody.*t2.*t9.*t26.*1.2e+1;
t179 = mLeg.*rArm.*rBody.*t2.*t9.*t26.*2.4e+1;
t180 = mLeg.*rArm.*rBody.*t2.*t10.*t26.*3.6e+1;
t181 = mPB.*rArm.*rBody.*t2.*t10.*t26.*1.2e+1;
t182 = mPB.*rArm.*rBody.*t2.*t11.*t26.*2.4e+1;
t196 = mLeg.*rBody.*t29.*t47.*1.2e+1;
t198 = mPB.*rArm.*rBody.*t3.*t11.*t29.*2.4e+1;
t204 = rArm.*rBody.*t2.*t18.*t26.*1.2e+1;
t205 = rArm.*rBody.*t2.*t19.*t26.*2.4e+1;
t209 = (ddthShoulder.*mBody.*rArm.*rBody.*t2.*t26)./2.0;
t212 = mBody.*t10.*t21.*t24.*1.2e+1;
t213 = mLeg.*t11.*t21.*t24.*1.2e+1;
t217 = mBody.*rArm.*rBody.*t2.*t10.*t26.*1.2e+1;
t218 = mLeg.*rArm.*rBody.*t2.*t11.*t26.*2.4e+1;
t54 = t31.^2;
t56 = t33.^2;
t80 = dthHand.*dthWaist.*t11.*t31;
t81 = dthHand.*dthShoulder.*t11.*t31;
t82 = dthWaist.*dthShoulder.*t11.*t31;
t86 = mBody.*t22.*t33;
t87 = cos(t74);
t88 = mArm.*rArm.*t2.*t31.*6.0;
t89 = mBody.*rArm.*t2.*t31.*6.0;
t90 = mLeg.*rArm.*t2.*t31.*6.0;
t91 = mPB.*rArm.*t2.*t31.*6.0;
t92 = t32.*t33.*3.0;
t93 = mPB.*rArm.*t3.*t33.*6.0;
t94 = (ddthShoulder.*t59)./2.0;
t96 = rArm.*t3.*t61;
t101 = mArm.*t21.*t33.*4.0;
t106 = rArm.*t3.*t77;
t107 = dthHand.*dthShoulder.*rArm.*t2.*t59;
t108 = ddthShoulder.*mLeg.*t22.*t40;
t109 = ddthShoulder.*mLeg.*t22.*t44;
t118 = rArm.*t5.*t69;
t119 = rArm.*t6.*t69;
t120 = t32.*t59.*6.0;
t123 = (ddthShoulder.*t11.*t33)./2.0;
t124 = rBody.*t6.*t73;
t125 = rArm.*t3.*t84;
t127 = mArm.*rBody.*t26.*t31.*6.0;
t128 = mBody.*rBody.*t26.*t31.*6.0;
t129 = mLeg.*rBody.*t26.*t31.*6.0;
t130 = mPB.*rBody.*t26.*t31.*6.0;
t132 = dthHand.*dthShoulder.*rArm.*t2.*t71;
t133 = t40.*t41.*3.0;
t134 = t40.*t43.*3.0;
t135 = t41.*t44.*3.0;
t136 = t42.*t44.*3.0;
t137 = t43.*t44.*3.0;
t138 = mArm.*rBody.*t29.*t33.*6.0;
t139 = t33.*t59.*3.0;
t140 = mPB.*rBody.*t29.*t33.*6.0;
t141 = t47.*t59.*6.0;
t144 = -t115;
t146 = dthHand.*dthWaist.*rArm.*t2.*t11.*t33;
t148 = dthHand.*dthShoulder.*rArm.*t2.*t11.*t33;
t150 = dthWaist.*dthShoulder.*rArm.*t2.*t11.*t33;
t170 = mPB.*rArm.*t3.*t59.*1.2e+1;
t174 = ddthShoulder.*rBody.*t11.*t29.*t33;
t175 = t40.*t60.*3.0;
t183 = mArm.*mLeg.*t22.*t40.*1.2e+1;
t184 = t40.*t42.*1.5e+1;
t185 = mLeg.*mPB.*t22.*t40.*1.2e+1;
t189 = (t11.*t14.*t31)./2.0;
t190 = (t11.*t15.*t31)./2.0;
t191 = (t11.*t16.*t31)./2.0;
t192 = mArm.*mLeg.*t22.*t44.*1.2e+1;
t193 = mLeg.*mPB.*t22.*t44.*1.2e+1;
t197 = mPB.*rArm.*t3.*t62.*1.2e+1;
t199 = t40.*t51.*3.0;
t200 = t40.*t53.*3.0;
t206 = t44.*t51.*3.0;
t207 = t44.*t52.*3.0;
t208 = t44.*t53.*3.0;
t214 = -t168;
t216 = ddthShoulder.*rBody.*t11.*t26.*t31;
t219 = -t126;
t220 = t19.*t22.*t40.*1.2e+1;
t223 = (ddthShoulder.*rArm.*t2.*t11.*t31)./2.0;
t224 = (ddthShoulder.*mBody.*t22.*t40)./4.0;
t225 = mArm.*t21.*t25.*t33.*6.0;
t226 = (ddthShoulder.*mBody.*t22.*t44)./4.0;
t229 = dthHand.*dthWaist.*rBody.*t11.*t26.*t33;
t231 = dthHand.*dthShoulder.*rBody.*t11.*t26.*t33;
t233 = dthWaist.*dthShoulder.*rBody.*t11.*t26.*t33;
t236 = t40.*t63.*3.0;
t238 = mArm.*t2.*t3.*t21.*t31.*6.0;
t242 = mLeg.*t9.*t22.*t40.*1.2e+1;
t243 = t40.*t52.*1.5e+1;
t244 = mPB.*t11.*t22.*t40.*1.2e+1;
t249 = (rArm.*t4.*t69)./2.0;
t251 = mLeg.*t9.*t22.*t44.*1.2e+1;
t252 = mPB.*t11.*t22.*t44.*1.2e+1;
t258 = (rBody.*t5.*t73)./2.0;
t259 = mBody.*t21.*t24.*t33.*1.2e+1;
t260 = mLeg.*t21.*t24.*t33.*1.2e+1;
t261 = rArm.*t3.*t160;
t262 = (rArm.*t2.*t16.*t59)./2.0;
t265 = rBody.*t26.*t31.*t32.*6.0;
t266 = rArm.*t2.*t31.*t59.*6.0;
t268 = mLeg.*t11.*t22.*t40.*1.2e+1;
t270 = mBody.*t2.*t3.*t21.*t31.*1.2e+1;
t271 = mLeg.*t2.*t3.*t21.*t31.*1.2e+1;
t273 = rBody.*t29.*t32.*t33.*6.0;
t274 = rArm.*t3.*t33.*t59.*6.0;
t292 = mBody.*rArm.*rBody.*t3.*t26.*t31.*1.2e+1;
t293 = mBody.*rArm.*rBody.*t2.*t26.*t33.*1.2e+1;
t294 = mLeg.*rArm.*rBody.*t3.*t26.*t31.*1.2e+1;
t295 = mLeg.*rArm.*rBody.*t2.*t29.*t31.*1.2e+1;
t296 = mLeg.*rArm.*rBody.*t2.*t26.*t33.*2.4e+1;
t297 = mLeg.*rArm.*t2.*t31.*t33.*-6.0;
t300 = (rArm.*t2.*t11.*t14.*t33)./2.0;
t302 = (rArm.*t2.*t11.*t15.*t33)./2.0;
t304 = (rArm.*t2.*t11.*t16.*t33)./2.0;
t305 = rArm.*t2.*t11.*t31.*t33.*6.0;
t314 = rArm.*t3.*t11.*t14.*t31.*(-1.0./2.0);
t319 = mLeg.*t22.*t33.*t40.*1.2e+1;
t320 = mBody.*t22.*t26.*t29.*t31.*6.0;
t321 = mLeg.*rBody.*t26.*t31.*t33.*-6.0;
t323 = (rBody.*t11.*t14.*t26.*t33)./2.0;
t325 = (rBody.*t11.*t15.*t26.*t33)./2.0;
t327 = (rBody.*t11.*t16.*t26.*t33)./2.0;
t328 = rBody.*t11.*t26.*t31.*t33.*6.0;
t344 = mLeg.*t22.*t26.*t29.*t31.*1.2e+1;
t360 = rBody.*t11.*t14.*t29.*t31.*(-1.0./2.0);
t362 = rBody.*t11.*t16.*t29.*t31.*(-1.0./2.0);
t421 = mArm.*mLeg.*t2.*t3.*t21.*t31.*t33.*3.6e+1;
t434 = mLeg.*rBody.*t26.*t31.*t32.*t33.*3.6e+1;
t435 = mLeg.*rArm.*t2.*t31.*t33.*t59.*3.6e+1;
t438 = mLeg.*mPB.*t2.*t3.*t21.*t31.*t33.*7.2e+1;
t439 = mLeg.*t2.*t3.*t9.*t21.*t31.*t33.*3.6e+1;
t442 = mArm.*mLeg.*rArm.*rBody.*t2.*t29.*t31.*t33.*7.2e+1;
t444 = mLeg.*mPB.*rArm.*rBody.*t3.*t26.*t31.*t33.*7.2e+1;
t445 = mLeg.*mPB.*rArm.*rBody.*t2.*t29.*t31.*t33.*7.2e+1;
t447 = mLeg.*rBody.*t26.*t31.*t33.*t47.*3.6e+1;
t448 = mLeg.*rArm.*t2.*t31.*t33.*t62.*3.6e+1;
t450 = mPB.*t2.*t3.*t11.*t21.*t31.*t33.*7.2e+1;
t455 = mLeg.*rArm.*rBody.*t2.*t9.*t29.*t31.*t33.*7.2e+1;
t457 = mPB.*rArm.*rBody.*t3.*t11.*t26.*t31.*t33.*7.2e+1;
t458 = mPB.*rArm.*rBody.*t2.*t11.*t29.*t31.*t33.*7.2e+1;
t463 = t26.*t29.*t31.*t33.*t42.*3.6e+1;
t464 = t26.*t29.*t31.*t33.*t52.*3.6e+1;
t465 = mArm.*mLeg.*t22.*t26.*t29.*t31.*t33.*7.2e+1;
t467 = mLeg.*mPB.*t22.*t26.*t29.*t31.*t33.*7.2e+1;
t468 = mLeg.*t9.*t22.*t26.*t29.*t31.*t33.*7.2e+1;
t470 = mPB.*t11.*t22.*t26.*t29.*t31.*t33.*7.2e+1;
t97 = t9.*t54.*3.0;
t98 = t10.*t54.*3.0;
t99 = t11.*t54.*3.0;
t100 = t12.*t54.*3.0;
t102 = t9.*t56.*3.0;
t103 = t10.*t56.*3.0;
t104 = t12.*t56.*3.0;
t121 = -t101;
t122 = -t86;
t145 = rArm.*t3.*t80;
t147 = rArm.*t3.*t81;
t149 = rArm.*t3.*t82;
t156 = t32.*t54.*3.0;
t157 = mBody.*rArm.*t3.*t54.*6.0;
t158 = mLeg.*rArm.*t3.*t54.*6.0;
t166 = t32.*t56.*3.0;
t167 = mBody.*rArm.*t3.*t56.*6.0;
t176 = -t107;
t186 = t47.*t54.*3.0;
t187 = rArm.*t3.*t10.*t54.*6.0;
t188 = rArm.*t3.*t11.*t54.*6.0;
t194 = t47.*t56.*3.0;
t195 = rArm.*t3.*t10.*t56.*6.0;
t201 = t41.*t54.*3.0;
t202 = t42.*t54.*3.0;
t203 = t43.*t54.*3.0;
t210 = t41.*t56.*3.0;
t211 = t43.*t56.*3.0;
t215 = rArm.*t3.*t94;
t221 = t51.*t56.*3.0;
t222 = t53.*t56.*3.0;
t227 = rArm.*t3.*t123;
t228 = rBody.*t29.*t80;
t230 = rBody.*t29.*t81;
t232 = rBody.*t29.*t82;
t234 = t54.*t59.*3.0;
t235 = mLeg.*rBody.*t29.*t54.*6.0;
t237 = t54.*t60.*3.0;
t239 = -t146;
t240 = -t148;
t241 = -t150;
t245 = t56.*t59.*3.0;
t246 = mArm.*mBody.*t21.*t54.*1.2e+1;
t247 = mArm.*mLeg.*t21.*t54.*1.2e+1;
t248 = mArm.*mPB.*t21.*t54.*1.2e+1;
t250 = t56.*t60.*3.0;
t253 = mArm.*mBody.*t21.*t56.*1.2e+1;
t254 = mArm.*mPB.*t21.*t56.*1.2e+1;
t255 = t51.*t54.*3.0;
t256 = t52.*t54.*3.0;
t257 = t53.*t54.*3.0;
t263 = mBody.*t9.*t21.*t56.*1.2e+1;
t264 = mPB.*t9.*t21.*t56.*1.2e+1;
t267 = t33.*t90;
t269 = t17.*t21.*t54.*1.2e+1;
t272 = (ddthShoulder.*rLeg.*t11.*t54)./4.0;
t275 = t17.*t21.*t56.*1.2e+1;
t276 = (ddthShoulder.*rLeg.*t11.*t56)./4.0;
t277 = t54.*t62.*3.0;
t278 = rBody.*t11.*t29.*t54.*6.0;
t279 = t54.*t63.*3.0;
t280 = t56.*t62.*3.0;
t281 = mBody.*t9.*t21.*t54.*1.2e+1;
t282 = mLeg.*t9.*t21.*t54.*1.2e+1;
t283 = mPB.*t9.*t21.*t54.*1.2e+1;
t284 = t56.*t63.*3.0;
t285 = rBody.*t29.*t123;
t286 = -t259;
t287 = -t260;
t288 = -t262;
t289 = -t229;
t291 = -t233;
t298 = (rLeg.*t6.*t87)./2.0;
t299 = rArm.*t3.*t189;
t301 = rArm.*t3.*t190;
t303 = rArm.*t3.*t191;
t306 = t40.*t86.*3.0;
t307 = t216./2.0;
t308 = t44.*t86.*3.0;
t309 = mArm.*t9.*t21.*t54.*1.2e+1;
t310 = mArm.*t9.*t21.*t56.*1.2e+1;
t311 = t33.*t129;
t312 = -t293;
t313 = -t296;
t315 = -t302;
t316 = -t304;
t317 = -t305;
t322 = rBody.*t29.*t189;
t324 = rBody.*t29.*t190;
t326 = rBody.*t29.*t191;
t329 = mArm.*mBody.*t21.*t24.*t54.*3.6e+1;
t330 = mBody.*mLeg.*t21.*t24.*t54.*3.6e+1;
t331 = mBody.*mPB.*t21.*t24.*t54.*3.6e+1;
t332 = mArm.*mBody.*t21.*t24.*t56.*3.6e+1;
t333 = mArm.*mLeg.*t21.*t24.*t56.*3.6e+1;
t334 = mBody.*mLeg.*t21.*t24.*t56.*3.6e+1;
t335 = mBody.*mPB.*t21.*t25.*t54.*3.6e+1;
t336 = mBody.*mPB.*t21.*t24.*t56.*3.6e+1;
t337 = mLeg.*mPB.*t21.*t25.*t54.*3.6e+1;
t338 = mLeg.*mPB.*t21.*t24.*t56.*3.6e+1;
t339 = -t319;
t340 = mBody.*mPB.*t21.*t25.*t56.*3.6e+1;
t341 = mArm.*mBody.*rArm.*rBody.*t2.*t26.*t54.*3.6e+1;
t342 = t54.*t153;
t343 = mBody.*mPB.*rArm.*rBody.*t2.*t26.*t54.*3.6e+1;
t345 = mArm.*mBody.*rArm.*rBody.*t2.*t26.*t56.*3.6e+1;
t346 = mBody.*mPB.*rArm.*rBody.*t2.*t26.*t56.*3.6e+1;
t347 = mBody.*t9.*t21.*t24.*t54.*3.6e+1;
t348 = mLeg.*t10.*t21.*t24.*t54.*3.6e+1;
t349 = mPB.*t10.*t21.*t24.*t54.*3.6e+1;
t350 = t32.*t54.*t59.*1.8e+1;
t351 = mLeg.*rBody.*t29.*t32.*t54.*3.6e+1;
t352 = mPB.*rArm.*t3.*t54.*t59.*3.6e+1;
t353 = mBody.*t9.*t21.*t24.*t56.*3.6e+1;
t354 = mLeg.*t9.*t21.*t24.*t56.*3.6e+1;
t355 = mLeg.*t10.*t21.*t24.*t56.*3.6e+1;
t356 = mPB.*t10.*t21.*t25.*t54.*3.6e+1;
t357 = mPB.*t10.*t21.*t24.*t56.*3.6e+1;
t358 = mPB.*t11.*t21.*t25.*t54.*3.6e+1;
t359 = mPB.*t11.*t21.*t24.*t56.*3.6e+1;
t361 = -t325;
t363 = t32.*t56.*t59.*1.8e+1;
t364 = mPB.*rArm.*t3.*t56.*t59.*3.6e+1;
t365 = mPB.*t10.*t21.*t25.*t56.*3.6e+1;
t366 = -t328;
t367 = t18.*t21.*t24.*t54.*3.6e+1;
t368 = t17.*t21.*t25.*t54.*9.0;
t369 = t18.*t21.*t24.*t56.*3.6e+1;
t370 = t17.*t21.*t25.*t56.*9.0;
t371 = rArm.*rBody.*t2.*t18.*t26.*t54.*3.6e+1;
t372 = rArm.*rBody.*t2.*t18.*t26.*t56.*3.6e+1;
t373 = mBody.*t10.*t21.*t24.*t54.*3.6e+1;
t374 = mArm.*mLeg.*rArm.*rBody.*t2.*t26.*t56.*7.2e+1;
t375 = mBody.*mLeg.*rArm.*rBody.*t2.*t26.*t56.*7.2e+1;
t376 = mLeg.*mPB.*rArm.*rBody.*t2.*t26.*t56.*7.2e+1;
t377 = mArm.*t9.*t21.*t25.*t54.*9.0;
t378 = mBody.*t10.*t21.*t24.*t56.*3.6e+1;
t379 = mLeg.*mPB.*rArm.*rBody.*t3.*t29.*t54.*7.2e+1;
t380 = mArm.*t9.*t21.*t25.*t56.*9.0;
t381 = mBody.*rArm.*rBody.*t2.*t9.*t26.*t54.*3.6e+1;
t382 = t54.*t180;
t383 = mPB.*rArm.*rBody.*t2.*t10.*t26.*t54.*3.6e+1;
t384 = t40.*t41.*t54.*9.0;
t385 = t40.*t42.*t54.*9.0;
t386 = t40.*t43.*t54.*9.0;
t387 = mBody.*rArm.*rBody.*t2.*t9.*t26.*t56.*3.6e+1;
t388 = mPB.*rArm.*rBody.*t2.*t10.*t26.*t56.*3.6e+1;
t389 = t41.*t44.*t54.*9.0;
t390 = t40.*t41.*t56.*9.0;
t391 = mArm.*mLeg.*t22.*t44.*t54.*3.6e+1;
t392 = mArm.*mLeg.*t22.*t40.*t56.*3.6e+1;
t393 = t42.*t44.*t54.*9.0;
t394 = t40.*t42.*t56.*3.6e+1;
t395 = t43.*t44.*t54.*9.0;
t396 = t40.*t43.*t56.*9.0;
t397 = mLeg.*mPB.*t22.*t44.*t54.*3.6e+1;
t398 = mLeg.*mPB.*t22.*t40.*t56.*3.6e+1;
t399 = t47.*t54.*t59.*1.8e+1;
t400 = mLeg.*rBody.*t29.*t47.*t54.*3.6e+1;
t401 = mPB.*rArm.*t3.*t54.*t62.*3.6e+1;
t402 = t41.*t44.*t56.*9.0;
t403 = t43.*t44.*t56.*9.0;
t404 = t47.*t56.*t59.*1.8e+1;
t405 = mPB.*rArm.*t3.*t56.*t62.*3.6e+1;
t408 = t40.*t51.*t54.*9.0;
t409 = t40.*t52.*t54.*9.0;
t410 = t40.*t53.*t54.*9.0;
t411 = t44.*t51.*t54.*9.0;
t412 = t40.*t51.*t56.*9.0;
t413 = mLeg.*t9.*t22.*t44.*t54.*3.6e+1;
t414 = mLeg.*t9.*t22.*t40.*t56.*3.6e+1;
t415 = t44.*t52.*t54.*9.0;
t416 = t40.*t52.*t56.*3.6e+1;
t417 = t44.*t53.*t54.*9.0;
t418 = t40.*t53.*t56.*9.0;
t419 = mPB.*t11.*t22.*t44.*t54.*3.6e+1;
t420 = mPB.*t11.*t22.*t40.*t56.*3.6e+1;
t422 = t44.*t51.*t56.*9.0;
t423 = t44.*t53.*t56.*9.0;
t426 = mBody.*rArm.*rBody.*t2.*t10.*t26.*t54.*3.6e+1;
t427 = t40.*t54.*t60.*9.0;
t428 = mBody.*rArm.*rBody.*t2.*t10.*t26.*t56.*3.6e+1;
t429 = t40.*t56.*t60.*9.0;
t430 = mLeg.*rArm.*rBody.*t2.*t9.*t26.*t56.*7.2e+1;
t431 = mLeg.*rArm.*rBody.*t2.*t10.*t26.*t56.*7.2e+1;
t432 = mPB.*rArm.*rBody.*t2.*t11.*t26.*t56.*7.2e+1;
t433 = mPB.*rArm.*rBody.*t3.*t11.*t29.*t54.*7.2e+1;
t436 = t40.*t56.*t63.*9.0;
t437 = -t421;
t440 = t40.*t54.*t63.*9.0;
t441 = -t434;
t443 = -t435;
t446 = -t438;
t449 = -t439;
t451 = -t442;
t452 = -t444;
t453 = -t445;
t454 = -t447;
t456 = -t448;
t459 = -t450;
t460 = -t455;
t461 = -t457;
t462 = -t458;
t466 = -t463;
t469 = -t464;
t471 = -t465;
t472 = -t467;
t473 = -t468;
t474 = -t470;
t476 = MrPB+t34+t35+t36+t37+t38+t61+t67+t68+t77+t80+t81+t82+t83+t84+t85+t94+t105+t123+t159+t160+t189+t190+t191;
t290 = -t230;
t318 = -t306;
t406 = -t368;
t407 = -t370;
t424 = -t377;
t425 = -t380;
t475 = t32+t45+t46+t59+t71+t156+t157+t158+t166+t167+t234+t235+t245+t297+t321;
t478 = t9+t10+t11+t12+t88+t89+t90+t91+t92+t93+t97+t98+t99+t100+t102+t103+t104+t127+t128+t129+t130+t138+t139+t140;
t480 = t27+t78+t79+t95+t96+t106+t108+t109+t118+t119+t124+t125+t131+t145+t147+t149+t174+t176+t177+t209+t215+t216+t219+t223+t224+t226+t227+t228+t232+t239+t240+t241+t249+t258+t261+t272+t276+t288+t289+t291+t298+t301+t303+t315+t316+t324+t361;
t477 = t28+t79+t231+t272+t276+t285+t290+t298+t300+t307+t314+t323+t327+t360+t362;
t479 = t47+t57+t58+t62+t75+t121+t122+t186+t187+t188+t194+t195+t225+t238+t265+t266+t270+t271+t273+t274+t277+t278+t280+t286+t287+t292+t294+t295+t308+t312+t313+t317+t318+t320+t339+t344+t366;
t481 = t41+t42+t43+t48+t49+t50+t60+t72+t110+t111+t112+t113+t114+t116+t117+t120+t133+t134+t135+t136+t137+t142+t143+t144+t151+t152+t153+t154+t155+t169+t170+t171+t175+t183+t184+t185+t192+t193+t201+t202+t203+t204+t205+t210+t211+t220+t237+t246+t247+t248+t250+t253+t254+t269+t275+t329+t330+t331+t332+t333+t334+t335+t336+t337+t338+t340+t341+t342+t343+t345+t346+t350+t351+t352+t363+t364+t367+t369+t371+t372+t374+t375+t376+t379+t384+t385+t386+t389+t390+t391+t392+t393+t394+t395+t396+t397+t398+t402+t403+t406+t407+t427+t429+t437+t441+t443+t446+t451+t452+t453+t466+t471+t472;
t483 = t51+t52+t53+t63+t64+t65+t66+t76+t141+t161+t162+t163+t164+t165+t172+t173+t178+t179+t180+t181+t182+t196+t197+t198+t199+t200+t206+t207+t208+t212+t213+t214+t217+t218+t221+t222+t236+t242+t243+t244+t251+t252+t255+t256+t257+t263+t264+t268+t279+t281+t282+t283+t284+t309+t310+t347+t348+t349+t353+t354+t355+t356+t357+t358+t359+t365+t373+t378+t381+t382+t383+t387+t388+t399+t400+t401+t404+t405+t408+t409+t410+t411+t412+t413+t414+t415+t416+t417+t418+t419+t420+t422+t423+t424+t425+t426+t428+t430+t431+t432+t433+t436+t440+t449+t454+t456+t459+t460+t461+t462+t469+t473+t474;
t482 = 1.0./t481;
t484 = 1.0./t483;
ddrPB = t475.*t480.*t482.*-6.0+t477.*t479.*t484.*6.0+t476.*t482.*(mArm.*t21.*4.0+mBody.*t22+mArm.*t21.*t54.*1.2e+1+mArm.*t21.*t56.*1.2e+1+mBody.*t21.*t24.*1.2e+1+mBody.*t21.*t25.*1.2e+1+mBody.*t22.*t40.*3.0+mBody.*t22.*t44.*3.0+mBody.*t22.*t54.*3.0+mBody.*t22.*t56.*3.0+mLeg.*t21.*t24.*1.2e+1+mLeg.*t21.*t25.*1.2e+1+mLeg.*t22.*t40.*1.2e+1+mLeg.*t22.*t44.*1.2e+1+rArm.*t3.*t59.*1.2e+1+mBody.*t21.*t24.*t54.*3.6e+1+mBody.*t21.*t25.*t54.*3.6e+1+mBody.*t21.*t24.*t56.*3.6e+1+mBody.*t21.*t25.*t56.*3.6e+1+mBody.*t22.*t40.*t54.*9.0+mBody.*t22.*t40.*t56.*9.0+mBody.*t22.*t44.*t54.*9.0+mBody.*t22.*t44.*t56.*9.0+mLeg.*t21.*t25.*t54.*3.6e+1+mLeg.*t21.*t24.*t56.*3.6e+1+mLeg.*t22.*t40.*t56.*3.6e+1+mLeg.*t22.*t44.*t54.*3.6e+1+rArm.*t3.*t54.*t59.*3.6e+1+rArm.*t3.*t56.*t59.*3.6e+1+mBody.*rArm.*rBody.*t2.*t26.*1.2e+1+mLeg.*rArm.*rBody.*t2.*t26.*2.4e+1+mLeg.*rArm.*rBody.*t3.*t29.*2.4e+1+mBody.*rArm.*rBody.*t2.*t26.*t54.*3.6e+1+mBody.*rArm.*rBody.*t2.*t26.*t56.*3.6e+1+mLeg.*rArm.*rBody.*t2.*t26.*t56.*7.2e+1+mLeg.*rArm.*rBody.*t3.*t29.*t54.*7.2e+1-mLeg.*t2.*t3.*t21.*t31.*t33.*7.2e+1-mLeg.*t22.*t26.*t29.*t31.*t33.*7.2e+1-mLeg.*rArm.*rBody.*t3.*t26.*t31.*t33.*7.2e+1-mLeg.*rArm.*rBody.*t2.*t29.*t31.*t33.*7.2e+1);
if nargout > 1
    ddthHand = t480.*t482.*(mArm+mBody+mLeg+mPB+mArm.*t54.*3.0+mArm.*t56.*3.0+mBody.*t54.*3.0+mBody.*t56.*3.0+mLeg.*t54.*3.0+mPB.*t54.*3.0+mPB.*t56.*3.0).*-1.2e+1+t475.*t476.*t482.*6.0+t477.*t478.*t484.*1.2e+1;
end
if nargout > 2
    ddthWaist = (t477.*(t41+t42+t43+t48+t49+t50+t60+t72+t110+t111+t112+t113+t114+t116+t117+t120+t133+t134+t135+t136+t137+t142+t143+t144+t151+t152+t153+t154+t155+t169+t170+t171+t175+t183+t184+t185+t192+t193+t204+t205+t220+t9.*t11+t10.*t11+t11.*t12+t11.*t97+t11.*t98+t11.*t99+t12.*t99+t11.*t102+t11.*t103+t11.*t104+t11.^2+mLeg.*t33.*t47.*6.0+mLeg.*t33.*t62.*6.0+mLeg.*rArm.*t2.*t9.*t31.*1.2e+1+mLeg.*rArm.*t2.*t10.*t31.*1.2e+1+mLeg.*rArm.*t2.*t11.*t31.*1.2e+1+mLeg.*rBody.*t9.*t26.*t31.*1.2e+1+mLeg.*rBody.*t10.*t26.*t31.*1.2e+1+mLeg.*rBody.*t11.*t26.*t31.*1.2e+1+mLeg.*rBody.*t9.*t29.*t33.*1.2e+1+mPB.*rArm.*t2.*t11.*t31.*1.2e+1+mPB.*rArm.*t3.*t11.*t33.*1.2e+1+mPB.*rBody.*t11.*t26.*t31.*1.2e+1+mPB.*rBody.*t11.*t29.*t33.*1.2e+1).*-1.2e+1)./(t9.*t52+t10.*t52+t11.*t52+t11.*t53+t9.*t65+t10.*t65+t11.*t65+t11.*t66+t52.*t97+t52.*t98+t52.*t99+t53.*t99+t52.*t102+t52.*t103+t10.*t162+t11.*t162+t11.*t163+t11.*t164+t11.*t165+t11.*t172+t11.*t173+t11.*t179+t11.*t180+t11.*t181+t11.*t182+t11.*t196+t11.*t197+t11.*t198+t11.*t200+t9.*t207+t11.*t207+t11.*t208+t11.*t213+t11.*t218+t11.*t222+t11.*t242+t11.*t243+t11.*t244+t11.*t251+t11.*t252+t11.*t264+t11.*t268+t9.*t282+t10.*t282+t11.*t282+t11.*t283+t9.*t348+t10.*t348+t11.*t348+t11.*t349+t10.*t354+t10.*t355+t11.*t354+t11.*t355+t11.*t356+t11.*t357+t11.*t358+t11.*t359+t11.*t365+t9.*t382+t10.*t382+t11.*t382+t11.*t383+t11.*t388+t11.*t400+t11.*t401+t11.*t405+t9.*t409+t10.*t409+t11.*t409+t11.*t410+t9.*t415+t11.*t413+t11.*t414+t11.*t415+t11.*t416+t11.*t417+t11.*t418+t11.*t419+t11.*t420+t11.*t423+t11.*t430+t11.*t431+t11.*t432+t11.*t433+mLeg.*t47.*t62.*6.0+t9.*t40.*t52.*3.0+t10.*t40.*t52.*3.0+t9.*t56.*t180+t10.*t56.*t180+mLeg.*t47.*t54.*t62.*1.8e+1+mLeg.*t47.*t56.*t62.*1.8e+1+t9.*t40.*t52.*t56.*9.0+t10.*t40.*t52.*t56.*9.0+t9.*t44.*t52.*t56.*9.0-mLeg.*t9.^2.*t21.*t25.*3.0+mLeg.*t10.^2.*t21.*t24.*1.2e+1+mLeg.*t9.^2.*t21.*t56.*1.2e+1+mLeg.*t9.*t10.*t21.*t56.*1.2e+1-mLeg.*t9.^2.*t21.*t25.*t54.*9.0-mLeg.*t9.^2.*t21.*t25.*t56.*9.0-t11.*t26.*t29.*t31.*t33.*t52.*3.6e+1+mLeg.*rArm.*rBody.*t2.*t10.^2.*t26.*1.2e+1+mLeg.*rArm.*rBody.*t2.*t9.*t10.*t26.*1.2e+1-mLeg.*rArm.*t2.*t11.*t31.*t33.*t62.*3.6e+1-mLeg.*rBody.*t11.*t26.*t31.*t33.*t47.*3.6e+1-mPB.*t2.*t3.*t11.^2.*t21.*t31.*t33.*7.2e+1-mPB.*t11.^2.*t22.*t26.*t29.*t31.*t33.*7.2e+1-mPB.*rArm.*rBody.*t3.*t11.^2.*t26.*t31.*t33.*7.2e+1-mPB.*rArm.*rBody.*t2.*t11.^2.*t29.*t31.*t33.*7.2e+1-mLeg.*t2.*t3.*t9.*t11.*t21.*t31.*t33.*3.6e+1-mLeg.*t9.*t11.*t22.*t26.*t29.*t31.*t33.*7.2e+1-mLeg.*rArm.*rBody.*t2.*t9.*t11.*t29.*t31.*t33.*7.2e+1)-t476.*t479.*t484.*6.0+t478.*t480.*t484.*1.2e+1;
end