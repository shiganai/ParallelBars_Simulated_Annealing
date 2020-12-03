/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * find_ddrPB_ddthHand_ddthShoulder_ddthWaist.c
 *
 * Code generation for function 'find_ddrPB_ddthHand_ddthShoulder_ddthWaist'
 *
 */

/* Include files */
#include "find_ddrPB_ddthHand_ddthShoulder_ddthWaist.h"
#include "mwmathutil.h"
#include "rt_nonfinite.h"

/* Function Definitions */
void find_ddrPB_ddthHand_ddthShoulder_ddthWaist(const emlrtStack *sp, real_T
  InertiaLeg, real_T InertiaArm, real_T InertiaBody, real_T MrPB, real_T MthHand,
  real_T MthWaist, real_T MthShoulder, real_T dthHand, real_T dthWaist, real_T
  dthShoulder, real_T g, real_T mArm, real_T mBody, real_T mLeg, real_T mPB,
  real_T rArm, real_T rArmMCD, real_T rBody, real_T rBodyMCD, real_T rLegMCD,
  real_T thHand, real_T thShoulder, real_T thWaist, real_T *ddrPB, real_T
  *ddthHand, real_T *ddthShoulder, real_T *ddthWaist)
{
  real_T t2;
  real_T t3;
  real_T t4;
  real_T t6;
  real_T t7;
  real_T t8;
  real_T t9;
  real_T t10;
  real_T t11;
  real_T t12;
  real_T t13;
  real_T t14;
  real_T t15;
  real_T t16;
  real_T t17_tmp;
  real_T t17;
  real_T t39;
  real_T t18;
  real_T t19;
  real_T t20;
  real_T t21;
  real_T t22;
  real_T t23;
  real_T t24;
  real_T t37;
  real_T t38;
  real_T t40;
  real_T t41;
  real_T t43;
  real_T t44;
  real_T t63_tmp;
  real_T t63;
  real_T t64_tmp;
  real_T t64;
  real_T t45;
  real_T t46;
  real_T t47;
  real_T t48;
  real_T t54;
  real_T t55;
  real_T t59;
  real_T t60;
  real_T t65_tmp;
  real_T t65;
  real_T t66;
  real_T t67_tmp;
  real_T t67;
  real_T t68;
  real_T t697;
  real_T t1086;
  real_T t70_tmp;
  real_T t70;
  real_T t81_tmp_tmp;
  real_T t81_tmp;
  real_T t81;
  real_T t82_tmp;
  real_T t82;
  real_T t83_tmp;
  real_T b_t83_tmp;
  real_T t83;
  real_T t84_tmp;
  real_T t84;
  real_T t85_tmp;
  real_T t85;
  real_T t86_tmp_tmp;
  real_T t305;
  real_T t86_tmp;
  real_T t86;
  real_T t307;
  real_T t87_tmp;
  real_T t87;
  real_T t89;
  real_T t90;
  real_T t91;
  real_T t92;
  real_T t93;
  real_T t94;
  real_T t95;
  real_T t96;
  real_T t97;
  real_T t111;
  real_T t317;
  real_T t112_tmp;
  real_T t112;
  real_T t684;
  real_T t113_tmp;
  real_T t113;
  real_T t114;
  real_T t179;
  real_T t180;
  real_T t181;
  real_T t182;
  real_T t183;
  real_T t184;
  real_T t185;
  real_T t186;
  real_T t187;
  real_T t188;
  real_T t189;
  real_T t190;
  real_T t197;
  real_T t198;
  real_T t243;
  real_T t244;
  real_T t278;
  real_T t280;
  real_T t398;
  real_T t399;
  real_T t478;
  real_T t479;
  real_T t529;
  real_T t530;
  real_T t49;
  real_T t50;
  real_T t61;
  real_T t75_tmp;
  real_T t75;
  real_T t76;
  real_T t77;
  real_T t98;
  real_T t99;
  real_T t100;
  real_T t101;
  real_T t102;
  real_T t103;
  real_T t104;
  real_T t105;
  real_T t106;
  real_T t107;
  real_T t108;
  real_T t109;
  real_T t110_tmp;
  real_T t110;
  real_T t133;
  real_T t134;
  real_T t194_tmp_tmp;
  real_T t194_tmp;
  real_T b_t194_tmp_tmp;
  real_T b_t194_tmp;
  real_T t194;
  real_T t212_tmp;
  real_T t212;
  real_T t224_tmp_tmp_tmp;
  real_T t224_tmp_tmp;
  real_T t224;
  real_T t225_tmp_tmp;
  real_T t225_tmp;
  real_T b_t225_tmp_tmp;
  real_T t225;
  real_T t226;
  real_T t227_tmp_tmp;
  real_T t227;
  real_T t230;
  real_T t231;
  real_T t232;
  real_T t245;
  real_T t249;
  real_T t253_tmp_tmp;
  real_T t253;
  real_T t257_tmp_tmp;
  real_T t257;
  real_T t268_tmp;
  real_T t268;
  real_T t270_tmp;
  real_T t270;
  real_T t274;
  real_T t276;
  real_T t283;
  real_T t285;
  real_T t289;
  real_T t291;
  real_T t330_tmp;
  real_T t330;
  real_T t331;
  real_T t548_tmp_tmp;
  real_T t548_tmp;
  real_T b_t548_tmp;
  real_T t1089;
  real_T c_t548_tmp;
  real_T t548;
  real_T t550_tmp;
  real_T t550;
  real_T t560_tmp_tmp;
  real_T t560;
  real_T t563;
  real_T t564;
  real_T t567;
  real_T t568_tmp_tmp_tmp_tmp;
  real_T t568_tmp_tmp_tmp;
  real_T t568;
  real_T t569_tmp_tmp;
  real_T t569_tmp;
  real_T t569_tmp_tmp_tmp;
  real_T t569;
  real_T t572;
  real_T t573;
  real_T t574;
  real_T t577;
  real_T t580;
  real_T t581;
  real_T t582;
  real_T t587;
  real_T t589_tmp_tmp;
  real_T t589;
  real_T t590;
  real_T t591;
  real_T t592;
  real_T t595;
  real_T t597;
  real_T t598;
  real_T t599;
  real_T t600;
  real_T t601;
  real_T t604;
  real_T t609_tmp_tmp_tmp;
  real_T t609;
  real_T t612;
  real_T t688;
  real_T t613;
  real_T t614;
  real_T t615;
  real_T t616_tmp_tmp;
  real_T t616;
  real_T t619_tmp_tmp;
  real_T t619;
  real_T t621_tmp_tmp;
  real_T t621;
  real_T t622;
  real_T t623;
  real_T t630;
  real_T t633;
  real_T t634;
  real_T t635;
  real_T t636;
  real_T t639;
  real_T t642;
  real_T t700_tmp_tmp;
  real_T b_t700_tmp_tmp;
  real_T c_t700_tmp_tmp;
  real_T t700;
  real_T t701;
  real_T t727;
  real_T t728;
  real_T t729;
  real_T t730;
  real_T t731_tmp_tmp;
  real_T b_t731_tmp_tmp;
  real_T t731;
  real_T t732;
  real_T t750;
  real_T t751;
  real_T t752;
  real_T t753;
  real_T t777;
  real_T t791_tmp;
  real_T t791;
  real_T t792_tmp;
  real_T t792;
  real_T t793_tmp_tmp;
  real_T t793_tmp;
  real_T t793;
  real_T t794_tmp;
  real_T t794;
  real_T t795_tmp_tmp;
  real_T t795_tmp;
  real_T t795;
  real_T t796_tmp_tmp;
  real_T t796_tmp;
  real_T t796;
  real_T t797_tmp;
  real_T t797;
  real_T t812_tmp_tmp;
  real_T t893;
  real_T t812;
  real_T t846;
  real_T t847_tmp_tmp;
  real_T t847;
  real_T t917_tmp_tmp;
  real_T b_t917_tmp_tmp;
  real_T t689;
  real_T t917;
  real_T t938_tmp;
  real_T t938;
  real_T t939_tmp_tmp;
  real_T b_t939_tmp_tmp;
  real_T t939;
  real_T t940;
  real_T t896;
  real_T t951;
  real_T t667;
  real_T t692;
  real_T t952;
  real_T t664;
  real_T t953;
  real_T t956;
  real_T t958;
  real_T t959;
  real_T t961;
  real_T t999;
  real_T t1000_tmp;
  real_T t1000;
  real_T t149;
  real_T t150;
  real_T t151;
  real_T t152_tmp_tmp_tmp;
  real_T t152_tmp_tmp;
  real_T t152;
  real_T t153;
  real_T t154_tmp_tmp_tmp;
  real_T t154_tmp_tmp;
  real_T t154;
  real_T t155;
  real_T t156;
  real_T t157;
  real_T t158;
  real_T t159;
  real_T t160;
  real_T t170_tmp;
  real_T t170;
  real_T t171_tmp;
  real_T t171;
  real_T t213_tmp;
  real_T t213;
  real_T t248;
  real_T t374_tmp_tmp;
  real_T t374;
  real_T t375_tmp_tmp;
  real_T t375;
  real_T t376_tmp_tmp;
  real_T t376;
  real_T t377_tmp_tmp_tmp;
  real_T t377;
  real_T t380;
  real_T t381;
  real_T t382;
  real_T t383;
  real_T t384;
  real_T t385;
  real_T t386;
  real_T t387;
  real_T t388;
  real_T t389;
  real_T t390;
  real_T t391;
  real_T t392;
  real_T t393;
  real_T t414;
  real_T t415;
  real_T t416;
  real_T t417;
  real_T t418;
  real_T t419;
  real_T t420;
  real_T t421;
  real_T t461;
  real_T t462;
  real_T t463_tmp_tmp;
  real_T t463;
  real_T t464_tmp_tmp;
  real_T t464;
  real_T t465_tmp_tmp;
  real_T t465;
  real_T t466_tmp_tmp;
  real_T t466;
  real_T t467;
  real_T t468;
  real_T t471;
  real_T t472;
  real_T t473;
  real_T t474;
  real_T t476;
  real_T t497;
  real_T t498;
  real_T t499;
  real_T t500;
  real_T t501;
  real_T t502;
  real_T t503;
  real_T t504;
  real_T t505;
  real_T t506;
  real_T t507;
  real_T t561;
  real_T t565;
  real_T t570;
  real_T t575;
  real_T t578;
  real_T t583;
  real_T t588;
  real_T t593;
  real_T t596;
  real_T t602;
  real_T t607;
  real_T t610;
  real_T t617;
  real_T t620;
  real_T t624;
  real_T t627;
  real_T t628;
  real_T t637;
  real_T t640;
  real_T t890;
  real_T t894;
  real_T t946;
  real_T t949;
  real_T t1081;
  real_T t709;
  real_T t712;
  real_T t714;
  real_T t716;
  real_T t721;
  real_T t789;
  real_T t798;
  real_T t821;
  real_T t1080;
  real_T t1082;
  real_T t1083;
  real_T d;
  real_T d1;
  real_T d2;
  (void)sp;

  /* FIND_DDRPB_DDTHHAND_DDTHSHOULDER_DDTHWAIST */
  /*     [DDRPB,DDTHHAND,DDTHSHOULDER,DDTHWAIST] = FIND_DDRPB_DDTHHAND_DDTHSHOULDER_DDTHWAIST(INERTIALEG,INERTIAARM,INERTIABODY,MRPB,MTHHAND,MTHWAIST,MTHSHOULDER,DTHHAND,DTHWAIST,DTHSHOULDER,G,MARM,MBODY,MLEG,MPB,RARM,RARMMCD,RBODY,RBODYMCD,RLEGMCD,THHAND,THSHOULDER,THWAIST) */
  /*     This function was generated by the Symbolic Math Toolbox version 8.5. */
  /*     19-Jul-2020 21:49:27 */
  t2 = g * mArm;
  t3 = g * mBody;
  t4 = g * mLeg;
  t6 = dthHand * dthHand;
  t7 = dthWaist * dthWaist;
  t8 = dthShoulder * dthShoulder;
  t9 = mArm * mArm;
  t10 = mBody * mBody;
  t11 = mLeg * mLeg;
  t12 = rArm * rArm;
  t13 = rArmMCD * rArmMCD;
  t14 = rBody * rBody;
  t15 = rBodyMCD * rBodyMCD;
  t16 = rLegMCD * rLegMCD;
  t17_tmp = InertiaLeg * InertiaArm;
  t17 = t17_tmp * mArm;
  t39 = InertiaLeg * InertiaBody;
  t18 = t39 * mArm;
  t19 = t17_tmp * mBody;
  t20 = t39 * mBody;
  t21 = t17_tmp * mLeg;
  t22 = t39 * mLeg;
  t23 = t17_tmp * mPB;
  t24 = t39 * mPB;
  t37 = muDoubleScalarCos(thHand + 1.5707963267948966);
  t38 = muDoubleScalarSin(thHand + 1.5707963267948966);
  t39 = (thHand + 1.5707963267948966) + thShoulder;
  t40 = muDoubleScalarCos(t39);
  t41 = muDoubleScalarSin(t39);
  t39 += thWaist;
  t43 = t37 * t37;
  t44 = t38 * t38;
  t63_tmp = mBody * rArm;
  t63 = t63_tmp * t6 * t38;
  t64_tmp = mLeg * rArm;
  t64 = t64_tmp * t6 * t38;
  t45 = muDoubleScalarCos(t39);
  t46 = muDoubleScalarSin(t39);
  t47 = t40 * t40;
  t48 = t41 * t41;
  t54 = rBodyMCD * t3 * t40;
  t55 = rBody * t4 * t40;
  t59 = rBodyMCD * t19 * t40;
  t60 = rBody * t21 * t40;
  t65_tmp = mBody * rBodyMCD;
  t65 = t65_tmp * t6 * t41;
  t66 = t65_tmp * t8 * t41;
  t67_tmp = mLeg * rBody;
  t67 = t67_tmp * t6 * t41;
  t68 = t67_tmp * t8 * t41;
  t697 = dthHand * dthShoulder;
  t1086 = t697 * mLeg;
  t70_tmp = t1086 * rBody;
  t70 = t70_tmp * t41 * 2.0;
  t81_tmp_tmp = InertiaLeg * mArm;
  t81_tmp = t81_tmp_tmp * mBody;
  t39 = t81_tmp * t12;
  t81 = t39 * t43;
  t82_tmp = t81_tmp * t13;
  t82 = t82_tmp * t43;
  t83_tmp = t81_tmp_tmp * mLeg;
  b_t83_tmp = t83_tmp * t12;
  t83 = b_t83_tmp * t43;
  t84_tmp = t83_tmp * t13;
  t84 = t84_tmp * t43;
  t85_tmp = t81_tmp_tmp * mPB * t13;
  t85 = t85_tmp * t43;
  t86_tmp_tmp = InertiaLeg * mBody;
  t305 = t86_tmp_tmp * mPB;
  t86_tmp = t305 * t12;
  t86 = t86_tmp * t43;
  t307 = InertiaLeg * mLeg * mPB;
  t87_tmp = t307 * t12;
  t87 = t87_tmp * t43;
  t89 = t39 * t44;
  t90 = t82_tmp * t44;
  t91 = b_t83_tmp * t44;
  t92 = t84_tmp * t44;
  t93 = t85_tmp * t44;
  t94 = t86_tmp * t44;
  t95 = t87_tmp * t44;
  t39 = t81_tmp * rArm;
  t85_tmp = t39 * rArmMCD;
  t96 = t85_tmp * t43 * 2.0;
  t82_tmp = t83_tmp * rArm;
  t86_tmp = t82_tmp * rArmMCD;
  t97 = t86_tmp * t43 * 2.0;
  t111 = InertiaLeg * t9 * t13 * t44;
  t317 = InertiaLeg * t10;
  t112_tmp = t317 * t12;
  t112 = t112_tmp * t44;
  t684 = InertiaLeg * t11;
  t113_tmp = t684 * t12;
  t113 = t113_tmp * t44;
  t87_tmp = t86_tmp_tmp * mLeg;
  t114 = t87_tmp * t12 * t44 * 2.0;
  t39 *= rBodyMCD;
  t179 = t39 * t37 * t40;
  t180 = t81_tmp * rArmMCD * rBodyMCD * t37 * t40;
  t82_tmp *= rBody;
  t181 = t82_tmp * t37 * t40;
  t182 = t83_tmp * rArmMCD * rBody * t37 * t40;
  b_t83_tmp = t305 * rArm * rBodyMCD;
  t183 = b_t83_tmp * t37 * t40;
  t84_tmp = t307 * rArm * rBody;
  t184 = t84_tmp * t37 * t40;
  t185 = t39 * t38 * t41;
  t186 = t82_tmp * t38 * t41;
  t39 = t87_tmp * rArm;
  t187 = t39 * rBody * t38 * t41;
  t188 = t39 * rBodyMCD * t38 * t41;
  t189 = b_t83_tmp * t38 * t41;
  t190 = t84_tmp * t38 * t41;
  b_t83_tmp = InertiaLeg * rArm;
  t197 = b_t83_tmp * rBodyMCD * t10 * t38 * t41;
  t198 = b_t83_tmp * rBody * t11 * t38 * t41;
  t243 = t85_tmp * rBodyMCD * t40 * t43;
  t244 = t86_tmp * rBody * t40 * t43;
  t86_tmp_tmp = t87_tmp * rBody;
  t39 = t86_tmp_tmp * t12;
  t278 = t39 * t40 * t44;
  t82_tmp = t87_tmp * rBodyMCD * t12;
  t280 = t82_tmp * t40 * t44;
  t398 = t39 * t37 * t38 * t41;
  t399 = t82_tmp * t37 * t38 * t41;
  t478 = InertiaLeg * rBodyMCD * t10 * t12 * t37 * t38 * t41;
  t479 = InertiaLeg * rBody * t11 * t12 * t37 * t38 * t41;
  t529 = b_t83_tmp * t10 * t15 * t38 * t40 * t41;
  t530 = b_t83_tmp * t11 * t14 * t38 * t40 * t41;
  t49 = t45 * t45;
  t50 = t46 * t46;
  t61 = rLegMCD * t4 * t45;
  t75_tmp = mLeg * rLegMCD;
  t75 = t75_tmp * t6 * t46;
  t76 = t75_tmp * t7 * t46;
  t77 = t75_tmp * t8 * t46;
  t39 = t81_tmp * t15;
  t98 = t39 * t47;
  t82_tmp = t83_tmp * t14;
  t99 = t82_tmp * t47;
  b_t83_tmp = t87_tmp * t14;
  t100 = b_t83_tmp * t47;
  t84_tmp = t87_tmp * t15;
  t101 = t84_tmp * t47;
  t85_tmp = t305 * t15;
  t102 = t85_tmp * t47;
  t86_tmp = t307 * t14;
  t103 = t86_tmp * t47;
  t104 = t39 * t48;
  t105 = t82_tmp * t48;
  t106 = b_t83_tmp * t48;
  t107 = t84_tmp * t48;
  t108 = t85_tmp * t48;
  t109 = t86_tmp * t48;
  t110_tmp = t86_tmp_tmp * rBodyMCD;
  t110 = t110_tmp * t47 * 2.0;
  t133 = t317 * t15 * t48;
  t134 = t684 * t14 * t48;
  t194_tmp_tmp = InertiaBody * mArm;
  t194_tmp = t194_tmp_tmp * mLeg;
  b_t194_tmp_tmp = t194_tmp * rArm;
  b_t194_tmp = b_t194_tmp_tmp * rLegMCD;
  t194 = b_t194_tmp * t38 * t46;
  t212_tmp = rLegMCD * t45;
  t212 = t212_tmp * t64;
  t224_tmp_tmp_tmp = InertiaArm * mArm;
  t224_tmp_tmp = t224_tmp_tmp_tmp * mLeg;
  t39 = t224_tmp_tmp * rBody * rLegMCD;
  t224 = t39 * t40 * t45;
  t225_tmp_tmp = InertiaArm * mBody;
  t225_tmp = t225_tmp_tmp * mLeg;
  b_t225_tmp_tmp = t225_tmp * rBody;
  t82_tmp = b_t225_tmp_tmp * rLegMCD;
  t225 = t82_tmp * t40 * t45;
  t226 = t225_tmp * rBodyMCD * rLegMCD * t40 * t45;
  t227_tmp_tmp = InertiaArm * mLeg * mPB;
  b_t83_tmp = t227_tmp_tmp * rBody * rLegMCD;
  t227 = b_t83_tmp * t40 * t45;
  t230 = t39 * t41 * t46;
  t231 = t82_tmp * t41 * t46;
  t232 = b_t83_tmp * t41 * t46;
  t84_tmp = InertiaArm * rBody;
  t245 = t84_tmp * rLegMCD * t11 * t41 * t46;
  t307 = t67_tmp * rLegMCD;
  t249 = t307 * t7 * t41 * t45;
  t253_tmp_tmp = dthHand * dthWaist * mLeg;
  t39 = t253_tmp_tmp * rBody * rLegMCD;
  t253 = t39 * t41 * t45 * 2.0;
  t257_tmp_tmp = dthWaist * dthShoulder * mLeg;
  t82_tmp = t257_tmp_tmp * rBody * rLegMCD;
  t257 = t82_tmp * t41 * t45 * 2.0;
  t268_tmp = rBodyMCD * t40;
  t268 = t268_tmp * t82;
  t270_tmp = rBody * t40;
  t270 = t270_tmp * t84;
  t274 = t268_tmp * t90;
  t276 = t270_tmp * t92;
  t283 = t39 * t40 * t46 * -2.0;
  t285 = t82_tmp * t40 * t46 * -2.0;
  t289 = t268_tmp * t112;
  t291 = t270_tmp * t113;
  t330_tmp = rArmMCD * t37;
  t330 = t330_tmp * t185;
  t331 = t330_tmp * t186;
  t548_tmp_tmp = mArm * mBody;
  t548_tmp = t548_tmp_tmp * mLeg;
  b_t548_tmp = t548_tmp * rArm;
  t1089 = b_t548_tmp * rBody * rBodyMCD * rLegMCD;
  c_t548_tmp = t1089 * t38;
  t548 = c_t548_tmp * t46 * t48;
  t550_tmp = InertiaBody * rArm;
  t550 = t550_tmp * t11 * t16 * t38 * t45 * t46;
  t560_tmp_tmp = t548_tmp * rBody;
  t39 = t560_tmp_tmp * rLegMCD;
  t87_tmp = t39 * t12;
  b_t83_tmp = t87_tmp * t40;
  t560 = b_t83_tmp * t43 * t45;
  t82_tmp = t548_tmp * rBodyMCD * rLegMCD;
  t317 = t82_tmp * t12;
  t563 = t317 * t40 * t43 * t45;
  t86_tmp_tmp = t39 * t13;
  t39 = t86_tmp_tmp * t40;
  t564 = t39 * t43 * t45;
  t82_tmp = t82_tmp * t13 * t40;
  t567 = t82_tmp * t43 * t45;
  t568_tmp_tmp_tmp_tmp = mArm * mLeg;
  t568_tmp_tmp_tmp = t568_tmp_tmp_tmp_tmp * mPB;
  t83_tmp = t568_tmp_tmp_tmp * rBody * rLegMCD * t13;
  t85_tmp = t83_tmp * t40;
  t568 = t85_tmp * t43 * t45;
  t569_tmp_tmp = mBody * mLeg;
  t569_tmp = t569_tmp_tmp * mPB;
  t569_tmp_tmp_tmp = t569_tmp * rBody;
  t305 = t569_tmp_tmp_tmp * rLegMCD * t12;
  t86_tmp = t305 * t40;
  t569 = t86_tmp * t43 * t45;
  t684 = t569_tmp * rBodyMCD * rLegMCD * t12;
  t572 = t684 * t40 * t43 * t45;
  t573 = t84_tmp * t11 * t16 * t41 * t45 * t46;
  t574 = b_t83_tmp * t44 * t45;
  t577 = t39 * t44 * t45;
  t580 = t82_tmp * t44 * t45;
  t581 = t85_tmp * t44 * t45;
  t582 = t86_tmp * t44 * t45;
  t39 = t87_tmp * t41;
  t587 = t39 * t43 * t46;
  t589_tmp_tmp = b_t548_tmp * rLegMCD * t15;
  t82_tmp = t589_tmp_tmp * t38 * t46;
  t589 = t82_tmp * t47;
  b_t83_tmp = t86_tmp_tmp * t41;
  t590 = b_t83_tmp * t43 * t46;
  t84_tmp = t83_tmp * t41;
  t591 = t84_tmp * t43 * t46;
  t85_tmp = t305 * t41;
  t592 = t85_tmp * t43 * t46;
  t595 = t39 * t44 * t46;
  t597 = t82_tmp * t48;
  t598 = t317 * t41 * t44 * t46;
  t599 = b_t83_tmp * t44 * t46;
  t600 = t84_tmp * t44 * t46;
  t601 = t85_tmp * t44 * t46;
  t604 = t684 * t41 * t44 * t46;
  t609_tmp_tmp_tmp = mArm * rBody;
  t39 = t609_tmp_tmp_tmp * rLegMCD * t11;
  t87_tmp = t39 * t12;
  t609 = t87_tmp * t40 * t44 * t45;
  t82_tmp = t307 * t9 * t13;
  t612 = t82_tmp * t40 * t44 * t45;
  t688 = mBody * rBody;
  b_t83_tmp = t688 * rLegMCD * t11 * t12;
  t613 = b_t83_tmp * t40 * t44 * t45;
  t84_tmp = t307 * t10 * t12;
  t614 = t84_tmp * t40 * t44 * t45;
  t85_tmp = t65_tmp * rLegMCD * t11 * t12;
  t615 = t85_tmp * t40 * t44 * t45;
  t616_tmp_tmp = mLeg * rBodyMCD;
  t86_tmp = t616_tmp_tmp * rLegMCD * t10 * t12;
  t616 = t86_tmp * t40 * t44 * t45;
  t619_tmp_tmp = mPB * rBody;
  t86_tmp_tmp = t619_tmp_tmp * rLegMCD * t11 * t12;
  t619 = t86_tmp_tmp * t40 * t44 * t45;
  t305 = mArm * rArm;
  t621_tmp_tmp = t305 * rLegMCD * t11 * t14;
  t83_tmp = t621_tmp_tmp * t38;
  t621 = t83_tmp * t46 * t47;
  t622 = t87_tmp * t41 * t43 * t46;
  t39 = t39 * t13 * t41;
  t623 = t39 * t43 * t46;
  t630 = t86_tmp_tmp * t41 * t43 * t46;
  t633 = t39 * t44 * t46;
  t634 = t82_tmp * t41 * t44 * t46;
  t635 = b_t83_tmp * t41 * t44 * t46;
  t636 = t84_tmp * t41 * t44 * t46;
  t639 = t85_tmp * t41 * t44 * t46;
  t642 = t86_tmp * t41 * t44 * t46;
  t700_tmp_tmp = b_t548_tmp * rArmMCD;
  b_t700_tmp_tmp = t700_tmp_tmp * rBodyMCD;
  c_t700_tmp_tmp = b_t700_tmp_tmp * rLegMCD;
  t39 = c_t700_tmp_tmp * t37 * t38;
  t700 = t39 * t40 * t46;
  t701 = t39 * t41 * t45;
  t39 = t317 * t37 * t38;
  t727 = t39 * t40 * t46;
  t728 = t39 * t41 * t45;
  t39 = t684 * t37 * t38;
  t729 = t39 * t40 * t46;
  t730 = t39 * t41 * t45;
  t731_tmp_tmp = t305 * rArmMCD;
  b_t83_tmp = t731_tmp_tmp * rBody;
  b_t731_tmp_tmp = b_t83_tmp * rLegMCD * t11;
  t39 = b_t731_tmp_tmp * t37 * t38;
  t731 = t39 * t40 * t46;
  t732 = t39 * t41 * t45;
  t39 = t87_tmp * t37 * t38;
  t750 = t39 * t40 * t46;
  t751 = t39 * t41 * t45;
  t39 = t86_tmp_tmp * t37 * t38;
  t752 = t39 * t40 * t46;
  t753 = t39 * t41 * t45;
  t777 = t83_tmp * t40 * t41 * t45;
  t39 = t305 * rBody * t11 * t16;
  t791_tmp = t39 * t38;
  t791 = t791_tmp * t40 * t45 * t46;
  t792_tmp = t39 * t37;
  t792 = t792_tmp * t41 * t45 * t46;
  t793_tmp_tmp = mArm * rArmMCD;
  t793_tmp = t793_tmp_tmp * rBody * t11 * t16 * t37;
  t793 = t793_tmp * t41 * t45 * t46;
  t82_tmp = t63_tmp * rBody;
  t794_tmp = t82_tmp * t11 * t16 * t38;
  t794 = t794_tmp * t40 * t45 * t46;
  t795_tmp_tmp = t63_tmp * rBodyMCD;
  t795_tmp = t795_tmp_tmp * t11 * t16 * t38;
  t795 = t795_tmp * t40 * t45 * t46;
  t796_tmp_tmp = mPB * rArm;
  t39 = t796_tmp_tmp * rBody * t11 * t16;
  t796_tmp = t39 * t38;
  t796 = t796_tmp * t40 * t45 * t46;
  t797_tmp = t39 * t37;
  t797 = t797_tmp * t41 * t45 * t46;
  t812_tmp_tmp = t731_tmp_tmp * t11;
  t893 = t812_tmp_tmp * t16;
  t812 = t893 * t37 * t38 * t45 * t46 * 2.0;
  t317 = mArm * t11;
  t307 = t317 * t12 * t16;
  t846 = t307 * t37 * t38 * t45 * t46 * 2.0;
  t84_tmp = mPB * t11;
  t847_tmp_tmp = t84_tmp * t12;
  t684 = t847_tmp_tmp * t16;
  t847 = t684 * t37 * t38 * t45 * t46 * 2.0;
  t917_tmp_tmp = t688 * rBodyMCD;
  b_t917_tmp_tmp = t917_tmp_tmp * t11;
  t689 = b_t917_tmp_tmp * t16;
  t917 = t689 * t40 * t41 * t45 * t46 * 2.0;
  t938_tmp = b_t83_tmp * t11 * t16;
  t938 = t938_tmp * t41 * t43 * t45 * t46;
  t939_tmp_tmp = t82_tmp * rBodyMCD;
  b_t939_tmp_tmp = t939_tmp_tmp * t11 * t16;
  t39 = b_t939_tmp_tmp * t38 * t45 * t46;
  t939 = t39 * t47;
  t940 = t39 * t48;
  t896 = t317 * t14 * t16;
  t951 = t896 * t40 * t41 * t45 * t46 * 2.0;
  t667 = mBody * t11;
  t692 = t667 * t14 * t16;
  t952 = t692 * t40 * t41 * t45 * t46 * 2.0;
  t664 = t84_tmp * t14 * t16;
  t953 = t664 * t40 * t41 * t45 * t46 * 2.0;
  t39 = t609_tmp_tmp_tmp * t11 * t13 * t16 * t41;
  t956 = t39 * t43 * t45 * t46;
  t958 = t39 * t44 * t45 * t46;
  t39 = t688 * t11 * t12 * t16;
  t959 = t39 * t41 * t44 * t45 * t46;
  t82_tmp = t65_tmp * t11 * t12 * t16;
  t961 = t82_tmp * t41 * t44 * t45 * t46;
  t688 = t39 * t37 * t38;
  t999 = t688 * t40 * t45 * t46;
  t1000_tmp = t82_tmp * t37 * t38;
  t1000 = t1000_tmp * t40 * t45 * t46;
  t39 = t224_tmp_tmp * t16;
  t149 = t39 * t49;
  t82_tmp = t194_tmp * t16;
  t150 = t82_tmp * t49;
  b_t83_tmp = t225_tmp * t16;
  t151 = b_t83_tmp * t49;
  t152_tmp_tmp_tmp = InertiaBody * mBody;
  t152_tmp_tmp = t152_tmp_tmp_tmp * mLeg;
  t84_tmp = t152_tmp_tmp * t16;
  t152 = t84_tmp * t49;
  t85_tmp = t227_tmp_tmp * t16;
  t153 = t85_tmp * t49;
  t154_tmp_tmp_tmp = InertiaBody * mLeg;
  t154_tmp_tmp = t154_tmp_tmp_tmp * mPB;
  t86_tmp = t154_tmp_tmp * t16;
  t154 = t86_tmp * t49;
  t155 = t39 * t50;
  t156 = t82_tmp * t50;
  t157 = b_t83_tmp * t50;
  t158 = t84_tmp * t50;
  t159 = t85_tmp * t50;
  t160 = t86_tmp * t50;
  t170_tmp = InertiaArm * t11;
  t170 = t170_tmp * t16 * t50;
  t171_tmp = InertiaBody * t11;
  t171 = t171_tmp * t16 * t50;
  t213_tmp = rArm * t37;
  t213 = t213_tmp * t75;
  t248 = t270_tmp * t76;
  t374_tmp_tmp = t548_tmp * t12;
  t39 = t374_tmp_tmp * t16;
  t82_tmp = t39 * t43;
  t374 = t82_tmp * t49;
  t375_tmp_tmp = t548_tmp * t13;
  b_t83_tmp = t375_tmp_tmp * t16;
  t84_tmp = b_t83_tmp * t43;
  t375 = t84_tmp * t49;
  t376_tmp_tmp = t568_tmp_tmp_tmp * t13;
  t85_tmp = t376_tmp_tmp * t16;
  t86_tmp = t85_tmp * t43;
  t376 = t86_tmp * t49;
  t377_tmp_tmp_tmp = t569_tmp * t12;
  t87_tmp = t377_tmp_tmp_tmp * t16;
  t86_tmp_tmp = t87_tmp * t43;
  t377 = t86_tmp_tmp * t49;
  t305 = t39 * t44;
  t380 = t305 * t49;
  t381 = t82_tmp * t50;
  t83_tmp = b_t83_tmp * t44;
  t382 = t83_tmp * t49;
  t383 = t84_tmp * t50;
  b_t83_tmp = t85_tmp * t44;
  t384 = b_t83_tmp * t49;
  t385 = t86_tmp * t50;
  t39 = t87_tmp * t44;
  t386 = t39 * t49;
  t387 = t86_tmp_tmp * t50;
  t82_tmp = t700_tmp_tmp * t16 * t43;
  t388 = t82_tmp * t49 * 2.0;
  t389 = t305 * t50;
  t390 = t83_tmp * t50;
  t391 = b_t83_tmp * t50;
  t392 = t39 * t50;
  t393 = t82_tmp * t50 * 2.0;
  t82_tmp = t548_tmp * t15 * t16;
  t39 = t82_tmp * t47;
  t414 = t39 * t49;
  t84_tmp = t569_tmp * t15 * t16;
  b_t83_tmp = t84_tmp * t47;
  t415 = b_t83_tmp * t49;
  t416 = t39 * t50;
  t82_tmp *= t48;
  t417 = t82_tmp * t49;
  t418 = b_t83_tmp * t50;
  t39 = t84_tmp * t48;
  t419 = t39 * t49;
  t420 = t82_tmp * t50;
  t421 = t39 * t50;
  t461 = t307 * t44 * t49;
  t462 = t307 * t43 * t50;
  t463_tmp_tmp = t317 * t13;
  t39 = t463_tmp_tmp * t16;
  t463 = t39 * t43 * t50;
  t464_tmp_tmp = mLeg * t9 * t13;
  t82_tmp = t464_tmp_tmp * t16 * t44;
  t464 = t82_tmp * t49;
  t465_tmp_tmp = t667 * t12;
  b_t83_tmp = t465_tmp_tmp * t16 * t44;
  t465 = b_t83_tmp * t49;
  t85_tmp = mLeg * t10;
  t466_tmp_tmp = t85_tmp * t12;
  t84_tmp = t466_tmp_tmp * t16 * t44;
  t466 = t84_tmp * t49;
  t467 = t684 * t44 * t49;
  t468 = t684 * t43 * t50;
  t471 = t39 * t44 * t50;
  t472 = t82_tmp * t50;
  t473 = b_t83_tmp * t50;
  t474 = t84_tmp * t50;
  t476 = t893 * t43 * t50 * 2.0;
  t497 = t896 * t47 * t50;
  t498 = t896 * t48 * t49;
  t499 = t692 * t47 * t50;
  t500 = t692 * t48 * t49;
  t39 = t667 * t15 * t16;
  t501 = t39 * t47 * t50;
  t82_tmp = t85_tmp * t15 * t16 * t48;
  t502 = t82_tmp * t49;
  t503 = t664 * t47 * t50;
  t504 = t664 * t48 * t49;
  t505 = t39 * t48 * t50;
  t506 = t82_tmp * t50;
  t507 = t689 * t47 * t50 * 2.0;
  t84_tmp = b_t548_tmp * rBodyMCD * t16;
  t39 = t84_tmp * t37 * t40;
  t561 = t39 * t49;
  t87_tmp = t548_tmp * rArmMCD;
  t82_tmp = t87_tmp * rBodyMCD * t16 * t37 * t40;
  t565 = t82_tmp * t49;
  t83_tmp = t569_tmp * rArm;
  t85_tmp = t83_tmp * rBodyMCD * t16;
  b_t83_tmp = t85_tmp * t37 * t40;
  t570 = b_t83_tmp * t49;
  t575 = t39 * t50;
  t578 = t82_tmp * t50;
  t583 = b_t83_tmp * t50;
  t39 = t84_tmp * t38 * t41;
  t588 = t39 * t49;
  t82_tmp = t85_tmp * t38 * t41;
  t593 = t82_tmp * t49;
  t596 = t39 * t50;
  t602 = t82_tmp * t50;
  t607 = t792_tmp * t40 * t50;
  t610 = t793_tmp * t40 * t50;
  t617 = t797_tmp * t40 * t50;
  t620 = t791_tmp * t41 * t49;
  t624 = t794_tmp * t41 * t49;
  t39 = t64_tmp * rBodyMCD * t10 * t16 * t38 * t41;
  t627 = t39 * t49;
  t628 = t796_tmp * t41 * t49;
  t637 = t795_tmp * t41 * t50;
  t640 = t39 * t50;
  t39 = b_t700_tmp_tmp * t16 * t40 * t43;
  t664 = t39 * t49;
  t667 = t39 * t50;
  t692 = t938_tmp * t40 * t43 * t50;
  t890 = t688 * t41 * t49;
  t39 = t616_tmp_tmp * t10 * t12 * t16 * t37 * t38 * t41;
  t893 = t39 * t49;
  t894 = t1000_tmp * t41 * t50;
  t896 = t39 * t50;
  t39 = t64_tmp * t10 * t15 * t16 * t38 * t40 * t41;
  t946 = t39 * t49;
  t949 = t39 * t50;
  t39 = t697 * mBody;
  t1081 = ((((((((((((((((((MrPB + -t2) + -t3) + -t4) + -(g * mPB)) +
                        t793_tmp_tmp * t6 * t38) + t63) + t64) + t65) + t66) +
                   t67) + t68) + t39 * rBodyMCD * t41 * 2.0) + t70) + t75) + t76)
             + t77) + t253_tmp_tmp * rLegMCD * t46 * 2.0) + t1086 * rLegMCD *
           t46 * 2.0) + t257_tmp_tmp * rLegMCD * t46 * 2.0;
  t305 = t268_tmp * t151;
  t307 = t268_tmp * t157;
  t317 = t270_tmp * t170;
  t684 = t268_tmp * t375;
  t688 = t268_tmp * t382;
  t689 = t268_tmp * t383;
  t697 = t268_tmp * t390;
  t6 = t270_tmp * t463;
  t709 = t268_tmp * t465;
  t712 = t268_tmp * t466;
  t714 = t270_tmp * t471;
  t716 = t270_tmp * t473;
  t721 = t268_tmp * t474;
  t789 = t330_tmp * t588;
  t798 = t330_tmp * t596;
  t821 = t330_tmp * t620;
  t1080 = ((((((((MthWaist + rLegMCD * -t4 * t45) + t212) + t212_tmp * t67) +
               t212_tmp * t68) + t212_tmp * t70) + -t213) + t70_tmp * rLegMCD *
            t40 * t46 * -2.0) + -(t270_tmp * t75)) + -(t270_tmp * t77);
  t1082 = ((((((((((((((-MthShoulder + t54) + t55) + t61) + t213_tmp * t65) +
                    t213_tmp * t67) + t213) + t249) + t253) + t257) + -(t268_tmp
    * t63)) + -(t270_tmp * t64)) + -t212) + t283) + t285) + -t248;
  t86_tmp_tmp = t64_tmp * rLegMCD;
  t85_tmp = t1086 * rArm;
  b_t83_tmp = t39 * rArm * rBodyMCD;
  t84_tmp = t85_tmp * rBody;
  t82_tmp = t253_tmp_tmp * rArm * rLegMCD;
  t85_tmp *= rLegMCD;
  t39 = t257_tmp_tmp * rArm * rLegMCD;
  t86_tmp = t64_tmp * rBody;
  t1083 = (((((((((((((((((((((((((((((-MthHand + rArmMCD * t2 * t37) + rArm *
    t3 * t37) + rArm * t4 * t37) + t54) + t55) + t61) + t795_tmp_tmp * t8 * t38 *
    t40) + t86_tmp * t8 * t38 * t40) + b_t83_tmp * t38 * t40 * 2.0) + t84_tmp *
    t38 * t40 * 2.0) + t86_tmp_tmp * t7 * t38 * t45) + t86_tmp_tmp * t8 * t38 *
    t45) + t82_tmp * t38 * t45 * 2.0) + t85_tmp * t38 * t45 * 2.0) + t39 * t38 *
    t45 * 2.0) + b_t83_tmp * t37 * t41 * -2.0) + t84_tmp * t37 * t41 * -2.0) +
                      t82_tmp * t37 * t46 * -2.0) + t85_tmp * t37 * t46 * -2.0)
                    + t39 * t37 * t46 * -2.0) + t249) + t253) + t257) +
                -(t213_tmp * t66)) + -(t213_tmp * t68)) + -(t213_tmp * t76)) +
             -(t213_tmp * t77)) + t283) + t285) + -t248;
  t54 = ((((((((((((((((((((((((t18 + t20) + t22) + t24) + t98) + t99) + t100) +
    t101) + t102) + t103) + t104) + t105) + t106) + t107) + t108) + t109) + t133)
                + t134) + -t110) + t150) + t152) + t154) + t156) + t158) + t160)
    + t171;
  t55 = ((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((t54 + t179)
    + t181) + t183) + t184) + t185) + t186) + t187) + t188) + t189) + t190) +
    t197) + t198) + -t180) + -t182) + t414) + t415) + t416) + t417) + t418) +
    t419) + t420) + t421) + t497) + t498) + t499) + t500) + t501) + t502) + t503)
    + t504) + t505) + t506) + -t507) + t561) + t570) + t575) + t583) + t588) +
    t593) + t596) + t602) + t607) + t617) + t620) + t624) + t627) + t628) + t637)
                      + t640) + -t565) + -t578) + -t610) + t793) + t795) + -t791)
               + -t792) + -t794) + -t796) + -t797) + t917) + -t951) + -t952) +
    -t953;
  d = t154_tmp_tmp * rArm * rLegMCD;
  d1 = t83_tmp * rBody * rBodyMCD * rLegMCD;
  d2 = t87_tmp * rLegMCD * t15 * t37 * t45;
  t8 = t939_tmp_tmp * rLegMCD * t11;
  t4 = t1089 * t37;
  t7 = d1 * t38;
  d1 *= t37;
  t2 = t86_tmp * rBodyMCD * rLegMCD * t10 * t38;
  t66 = t8 * t38;
  t3 = t793_tmp_tmp * rLegMCD * t11 * t14 * t37;
  t68 = t87_tmp * rBody * rBodyMCD * rLegMCD * t37;
  t87_tmp = t63_tmp * rLegMCD * t11;
  t85_tmp = t796_tmp_tmp * rLegMCD * t11 * t14;
  t86_tmp = t87_tmp * t15 * t38 * t46;
  b_t83_tmp = t621_tmp_tmp * t37;
  t87_tmp = t87_tmp * t14 * t38;
  t84_tmp = t85_tmp * t38;
  t85_tmp *= t37;
  t39 = t86_tmp_tmp * t10 * t15 * t38;
  t82_tmp = mBody * mLeg * mPB * rArm * rLegMCD * t15 * t38 * t46;
  t1086 =
    (((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
    (((((((((t179 + t181) + t183) + t184) + t185) + t186) + t187) + t188) + t189)
    + t190) + t194_tmp * rArmMCD * rLegMCD * t37 * t45) + t197) + t198) + -t180)
    + -t182) + -(b_t194_tmp * t37 * t45)) + -(d * t37 * t45)) + -t194) +
    -(t152_tmp_tmp * rArm * rLegMCD * t38 * t46)) + -(d * t38 * t46)) +
    -(t550_tmp * rLegMCD * t11 * t38 * t46)) + t548) + t7 * t46 * t48) + t4 *
    t45 * t47) + d1 * t45 * t47) + t66 * t46 * t48) + t2 * t46 * t48) + t561) +
    d2 * t47) + t570) + t575) + d2 * t48) + t583) + t588) + t593) + t596) + t602)
    + t607) + t3 * t45 * t48) + t617) + t620) + t624) + t627) + t628) + -(t68 *
    t45 * t47)) + t637) + t640) + t8 * t38 * t46 * t47 * 2.0) + -(t589_tmp_tmp *
    t37 * t45 * t47)) + -t565) + -(t83_tmp * rLegMCD * t15 * t37 * t45 * t47)) +
    -(t548_tmp * rArm * rLegMCD * t15 * t37 * t45 * t48)) + -t578) +
    -(t569_tmp_tmp * mPB * rArm * rLegMCD * t15 * t37 * t45 * t48)) + -t589) +
    -(t82_tmp * t47)) + -t597) + -(t82_tmp * t48)) + -(b_t83_tmp * t45 * t48)) +
    -t610) + -(t85_tmp * t45 * t48)) + -t621) + -(t87_tmp * t46 * t47)) +
    -(t86_tmp * t47)) + -(t84_tmp * t46 * t47)) + -(t86_tmp * t48)) + -(t39 *
    t46 * t48)) + c_t548_tmp * t40 * t41 * t45) + t4 * t40 * t41 * t46) + t7 *
                      t40 * t41 * t45) + d1 * t40 * t41 * t46) + t2 * t40 * t41 *
                    t45) + t777) + b_t83_tmp * t40 * t41 * t46) + t87_tmp * t40 *
                 t41 * t45) + t84_tmp * t40 * t41 * t45) + t85_tmp * t40 * t41 *
               t46) + -(t68 * t40 * t41 * t46)) + t793) + t795) + -(t66 * t40 *
            t41 * t45)) + -(t3 * t40 * t41 * t46)) + -(t39 * t40 * t41 * t45)) +
        -t791) + -t792) + -t794) + -t796) + -t797;
  t39 = t63_tmp * t11;
  t82_tmp = t39 * t15 * t16 * t38 * t45 * t46;
  t76 = (((((((((((((((((((((((((((((((((((((((((((((rArmMCD * t18 * t37 + rArm *
    t20 * t37) + rArm * t22 * t37) + t330_tmp * t98) + t330_tmp * t99) +
    t213_tmp * t100) + t213_tmp * t101) + t330_tmp * t104) + t330_tmp * t105) +
    t213_tmp * t106) + t213_tmp * t107) + t213_tmp * t133) + t213_tmp * t134) +
    InertiaLeg * mBody * mLeg * rArm * rBody * rBodyMCD * t37 * t47 * -2.0) +
    t330_tmp * t150) + t213_tmp * t152) + t330_tmp * t156) + t213_tmp * t158) +
    t213_tmp * t171) + -(t268_tmp * t187 * 2.0)) + -t529) + -t530) + -t550) +
    t330_tmp * t414) + t330_tmp * t416) + t330_tmp * t417) + t330_tmp * t420) +
    t330_tmp * t497) + t330_tmp * t498) + t213_tmp * t499) + t213_tmp * t500) +
                       t213_tmp * t501) + t213_tmp * t502) + t213_tmp * t505) +
                    t213_tmp * t506) + b_t939_tmp_tmp * t37 * t47 * t50 * -2.0)
                  + t939) + t940) + -(t268_tmp * t624)) + -(t270_tmp * t637)) +
              -t946) + -t949) + -(t82_tmp * t47)) + -(t82_tmp * t48)) + t213_tmp
          * t917) + t793_tmp_tmp * t11 * t14 * t16 * t37 * t40 * t41 * t45 * t46
         * -2.0) + t39 * t14 * t16 * t37 * t40 * t41 * t45 * t46 * -2.0;
  d = InertiaArm * InertiaBody;
  d1 = d * mLeg;
  d2 = b_t194_tmp_tmp * rArmMCD;
  t8 = b_t225_tmp_tmp * rBodyMCD;
  t4 = InertiaBody * rLegMCD * t11 * t12;
  t7 = InertiaArm * rLegMCD * t11 * t14;
  t2 = t700_tmp_tmp * rLegMCD * t15 * t43 * t45;
  t66 = t560_tmp_tmp * rBodyMCD;
  t3 = t66 * rLegMCD * t13;
  t68 = t917_tmp_tmp * rLegMCD * t11 * t12;
  t67 = t68 * t44 * t45;
  t63 = t548_tmp * rLegMCD * t13 * t15;
  t64 = t63 * t43 * t45;
  t63 = t63 * t44 * t45;
  t77 = t67_tmp * rBodyMCD;
  t70_tmp = t77 * rLegMCD * t10 * t12;
  t70 = t731_tmp_tmp * rLegMCD * t11 * t14;
  t560_tmp_tmp = t700_tmp_tmp * rBody;
  b_t194_tmp_tmp = t560_tmp_tmp * rBodyMCD;
  b_t225_tmp_tmp = mArm * rLegMCD * t11 * t13 * t14;
  t65 = mBody * rLegMCD;
  b_t194_tmp = t65 * t11 * t12;
  t550_tmp = t75_tmp * t10 * t12 * t15;
  c_t548_tmp = b_t194_tmp * t14;
  t82_tmp = t68 * t37 * t38;
  b_t83_tmp = t82_tmp * t46;
  t84_tmp = b_t225_tmp_tmp * t40 * t41;
  t85_tmp = t550_tmp * t37 * t38;
  t86_tmp = t70_tmp * t37 * t38;
  t87_tmp = t194_tmp * rLegMCD * t13;
  t86_tmp_tmp = t225_tmp * rLegMCD * t15 * t45;
  t39 = b_t194_tmp * t15 * t44 * t45;
  t61 =
    (((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
    ((((((((((((((((((((((((((((((((t59 + t60) + -(d1 * rLegMCD * t45)) + t268)
    + t270) + t274) + t276) + t278) + t280) + d2 * rLegMCD * t43 * t45) + t8 *
    rLegMCD * t45 * t47) + t289) + t291) + -t243) + -t244) + t305) + t307) +
    t317) + -(t87_tmp * t43 * t45)) + -(t87_tmp * t44 * t45)) + -(t152_tmp_tmp *
    rLegMCD * t12 * t44 * t45)) + -(t86_tmp_tmp * t47)) + -(t86_tmp_tmp * t48))
    + -(t4 * t44 * t45)) + -(t7 * t45 * t48)) + t330_tmp * t194) + -t330) +
    -t331) + InertiaBody * mBody * mLeg * rLegMCD * t12 * t37 * t38 * t46) +
    -t398) + -t399) + t4 * t37 * t38 * t46) + t268_tmp * t231) + -t478) + -t479)
    + t7 * t40 * t41 * t46) + -t573) + t2 * t47) + t3 * t43 * t45 * t47) + t2 *
    t48) + t3 * t44 * t45 * t47) + t684) + t688) + t689) + t70 * t43 * t45 * t48)
    + t67 * t47) + t70_tmp * t44 * t45 * t47) + t697) + -(b_t194_tmp_tmp *
    rLegMCD * t43 * t45 * t47)) + t6) + t709) + t712) + t714) + t716) + t721) +
    -t664) + -t667) + t67 * t48 * 2.0) + -(t64 * t47)) + -(t63 * t47)) + -(t64 *
    t48)) + -t692) + -(t63 * t48)) + -(b_t225_tmp_tmp * t43 * t45 * t48)) +
    -(t39 * t47)) + -(t550_tmp * t44 * t45 * t47)) + -(b_t225_tmp_tmp * t44 *
    t45 * t48)) + -(c_t548_tmp * t44 * t45 * t48)) + -(t39 * t48)) + t330_tmp *
    t589) + t330_tmp * t597) + t330_tmp * t621) + -(t330_tmp * t548)) + t268_tmp
    * t590) + t268_tmp * t599) + t65 * t11 * t12 * t14 * t37 * t38 * t46 * t47)
    + t65 * t11 * t12 * t15 * t37 * t38 * t46 * t47) + mBody * rLegMCD * t11 *
    t12 * t15 * t37 * t38 * t46 * t48) + t85_tmp * t46 * t48) + -t789) + -t798)
    + t268_tmp * t636) + -(t548_tmp_tmp * mLeg * rArm * rArmMCD * rBody *
    rBodyMCD * rLegMCD * t40 * t41 * t43 * t46)) + t938) + -t821) + -(b_t83_tmp *
    t47 * 2.0)) + -(b_t83_tmp * t48)) + -(t86_tmp * t46 * t48)) + t84_tmp * t43 *
    t46) + t84_tmp * t44 * t46) + c_t548_tmp * t40 * t41 * t44 * t46) + t961) +
                      -t890) + -t893) + -t894) + -t896) + -(t70 * t40 * t41 *
    t43 * t46)) + -(t268_tmp * t635)) + -(t550_tmp * t40 * t41 * t44 * t46)) +
               -t956) + -t958) + -t959) + t82_tmp * t40 * t41 * t45) +
           -(t270_tmp * t701)) + t85_tmp * t40 * t41 * t45) + t330_tmp * t791) +
        -(t330_tmp * t777)) + -(t86_tmp * t40 * t41 * t45)) + t999) +
     -(c_t548_tmp * t37 * t38 * t40 * t41 * t45)) + -t1000;
  t4 = c_t700_tmp_tmp * t40 * t43 * t45;
  t7 = t560_tmp_tmp * rLegMCD;
  t75 = b_t731_tmp_tmp * t41 * t43 * t46;
  t777 = (((((((((((((((((((((((((((((t17 + t19) + t21) + t23) + t81) + t82) +
    t83) + t84) + t85) + t86) + t87) + t89) + t90) + t91) + t92) + t93) + t94) +
                      t95) + t111) + t112) + t113) + t114) + -t96) + -t97) +
               t149) + t151) + t153) + t155) + t157) + t159) + t170;
  t589_tmp_tmp = t7 * t41 * t43 * t46;
  t1089 =
    (((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
    (((((((((((((((((((t777 + t224) + t225) + t227) + t230) + t231) + t232) +
    t245) + -t226) + t374) + t375) + t376) + t377) + t380) + t381) + t382) +
    t383) + t384) + t385) + t386) + t387) + t389) + t390) + t391) + t392) + t461)
    + t462) + t463) + t464) + t465) + t466) + t467) + t468) + t471) + t472) +
    t473) + t474) + -t388) + -t393) + -t476) + t560) + t564) + t568) + t569) +
    t574) + t577) + t581) + t582) + t4 * 2.0) + t587) + t590) + t591) + t592) +
    t595) + t599) + t600) + t601) + -(t589_tmp_tmp * 2.0)) + t609) + t612) +
    t613) + t614) + t619) + t622) + t623) + t630) + -(t548_tmp * rArm * rArmMCD *
    rBody * rLegMCD * t40 * t43 * t45 * 2.0)) + t633) + t634) + t635) + t636) +
    -t563) + -t567) + -t572) + -t580) + -(t75 * 2.0)) + -t598) + -t604) + -t615)
                      + -t616) + -t639) + -t642) + t700) + t701) + t731) + t732)
               + -t727) + -t728) + -t729) + -t730) + -t750) + -t751) + -t752) +
        -t753) + t812) + -t846) + -t847) + t1086;
  t248 = (((((((((((((((((((((((((((((((((((((((((((((((((-t59 + -t60) + t243) +
    t244) + -t268) + -t270) + -t274) + -t276) + -t278) + -t280) + -t289) + -t291)
    + -t305) + -t307) + t330) + t331) + -t317) + t398) + t399) + t478) + t479) +
    t573) + t664) + t667) + t692) + -t684) + -t688) + -t689) + -t697) + -t6) +
    -t709) + -t712) + -t714) + -t716) + -t721) + t789) + t798) + t821) + t890) +
                    t893) + t894) + t896) + t956) + t958) + t959) + -t938) +
             -t961) + t1000) + t330_tmp * -t791) + -t999) + t76;
  t2 = mBody * t13;
  t3 = t2 * t18;
  t68 = mBody * t12;
  t67 = mLeg * t12;
  t63 = t67 * t18;
  t64 = mLeg * t13 * t18;
  t70_tmp = mPB * t13;
  t70 = t70_tmp * t18;
  t560_tmp_tmp = mPB * t12;
  b_t225_tmp_tmp = mLeg * t14;
  t65 = mBody * t15;
  b_t194_tmp = t65 * t17;
  t550_tmp = b_t225_tmp_tmp * t17;
  c_t548_tmp = b_t225_tmp_tmp * t19;
  t999 = mLeg * t15;
  t1000 = t999 * t19;
  t249 = mPB * t15;
  t253 = t249 * t19;
  t257 = mPB * t14;
  t621_tmp_tmp = t257 * t21;
  t253_tmp_tmp = b_t225_tmp_tmp * t47;
  t257_tmp_tmp = t999 * t47;
  t285 = t249 * t47;
  t283 = t257 * t47;
  t212 = t63_tmp * rArmMCD;
  t616_tmp_tmp = t64_tmp * rArmMCD;
  b_t225_tmp_tmp *= t48;
  t999 *= t48;
  t249 *= t48;
  t257 *= t48;
  t795_tmp_tmp = t68 * t43;
  t939_tmp_tmp = t2 * t43;
  t213_tmp = t70_tmp * t43;
  t796_tmp_tmp = t560_tmp_tmp * t43;
  b_t939_tmp_tmp = t68 * t44;
  t2 *= t44;
  t70_tmp *= t44;
  t213 = t560_tmp_tmp * t44;
  t212_tmp = mArm * t12;
  t938_tmp = t212_tmp * t43;
  b_t548_tmp = mArm * t13;
  t697 = b_t548_tmp * t43;
  t6 = t65 * t47;
  t692 = mBody * t14;
  t709 = t692 * t47;
  t712 = mArm * t15 * t47;
  b_t548_tmp *= t44;
  t65 *= t48;
  t714 = t77 * t47;
  t716 = t212 * t43;
  t721 = t616_tmp_tmp * t43;
  t789 = t77 * t48;
  t798 = t731_tmp_tmp * t43;
  t569_tmp = t917_tmp_tmp * t47;
  t1000_tmp = t917_tmp_tmp * t48;
  t667 = t793_tmp_tmp * t37;
  t664 = InertiaLeg * mPB;
  t689 = mArm * rBodyMCD * t40;
  t792_tmp = mPB * rBodyMCD * t40;
  t793_tmp = t9 * t11 * t13 * t14 * t16;
  t797_tmp = t793_tmp * t44;
  t791_tmp = t10 * t11 * t12;
  t794_tmp = t791_tmp * t14 * t16;
  t796_tmp = t794_tmp * t44;
  t791_tmp = t791_tmp * t15 * t16;
  t795_tmp = t791_tmp * t44;
  t896 = t65_tmp * t40;
  b_t700_tmp_tmp = rBody * rBodyMCD;
  t893 = b_t700_tmp_tmp * t10 * t11 * t12 * t16;
  t688 = t893 * t44;
  t305 = t568_tmp_tmp_tmp_tmp * t10 * t12 * t15 * t16 * t37 * t38 * t40 * t41;
  t307 = mLeg * mPB * t10 * t12 * t15 * t16 * t37 * t38 * t40 * t41;
  t82_tmp = t548_tmp_tmp * t11;
  t39 = t82_tmp * t12;
  t317 = t39 * t15 * t16 * t37 * t38 * t45 * t46;
  b_t83_tmp = mBody * mPB * t11 * t12;
  t684 = b_t83_tmp * t15 * t16 * t37 * t38 * t45 * t46;
  t83_tmp = t39 * t14 * t16 * t40 * t41;
  t87_tmp = t82_tmp * t13 * t14 * t16 * t40 * t41;
  t86_tmp_tmp = mArm * mPB * t11 * t13 * t14 * t16 * t40 * t41;
  t85_tmp = b_t83_tmp * t14 * t16 * t40 * t41;
  t86_tmp = t560_tmp_tmp * t20;
  b_t83_tmp = t560_tmp_tmp * t22;
  t84_tmp = mArm * t14 * t47;
  t39 = t692 * t48;
  t82_tmp = t548_tmp_tmp * rArm * rArmMCD;
  t689 = 1.0 /
    (((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
    (((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
    (((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
    ((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((InertiaBody
    * t17 + InertiaBody * t19) + InertiaBody * t21) + InertiaBody * t23) + t68 *
    t18 * t43) + t3 * t43) + t63 * t43) + t64 * t43) + t70 * t43) + t86_tmp *
    t43) + b_t83_tmp * t43) + mBody * t12 * t18 * t44) + t3 * t44) + t63 * t44)
    + t64 * t44) + t70 * t44) + t86_tmp * t44) + b_t83_tmp * t44) + b_t194_tmp *
    t47) + t550_tmp * t47) + c_t548_tmp * t47) + t1000 * t47) + t253 * t47) +
    t621_tmp_tmp * t47) + b_t194_tmp * t48) + t550_tmp * t48) + c_t548_tmp * t48)
    + t1000 * t48) + t253 * t48) + t621_tmp_tmp * t48) + InertiaBody * t111) +
    InertiaBody * t112) + InertiaBody * t113) + t67 * t20 * t44 * 2.0) + -(t212 *
    t18 * t43 * 2.0)) + -(t616_tmp_tmp * t18 * t43 * 2.0)) + InertiaArm * t133)
    + InertiaArm * t134) + -(t77 * t19 * t47 * 2.0)) + InertiaBody * t149) +
    InertiaBody * t151) + InertiaBody * t153) + InertiaBody * t155) +
    InertiaBody * t157) + InertiaBody * t159) + InertiaBody * t170) + t81_tmp *
    mLeg * rArm * rArmMCD * rBody * rBodyMCD * t43 * t47 * 4.0) + t253_tmp_tmp *
    t81) + t257_tmp_tmp * t81) + t253_tmp_tmp * t82) + t257_tmp_tmp * t82) +
    t285 * t82) + t283 * t84) + t253_tmp_tmp * t86) + t257_tmp_tmp * t86) +
    t253_tmp_tmp * t89) + b_t225_tmp_tmp * t81) + t257_tmp_tmp * t89) + t999 *
    t81) + t253_tmp_tmp * t90) + b_t225_tmp_tmp * t82) + t257_tmp_tmp * t90) +
    t999 * t82) + t285 * t90) + t249 * t82) + t283 * t92) + t257 * t84) +
    t253_tmp_tmp * t94) + b_t225_tmp_tmp * t86) + t257_tmp_tmp * t94) + t999 *
    t86) + b_t225_tmp_tmp * t89) + t999 * t89) + b_t225_tmp_tmp * t90) + t999 *
    t90) + t249 * t90) + t257 * t92) + b_t225_tmp_tmp * t94) + t999 * t94) +
    t795_tmp_tmp * t150) + t939_tmp_tmp * t150) + t213_tmp * t150) +
    t796_tmp_tmp * t152) + b_t939_tmp_tmp * t150) + t795_tmp_tmp * t156) + t2 *
    t150) + t939_tmp_tmp * t156) + t70_tmp * t150) + t213_tmp * t156) + t213 *
    t152) + t796_tmp_tmp * t158) + b_t939_tmp_tmp * t156) + t2 * t156) + t70_tmp
    * t156) + t213 * t158) + t712 * t112) + t938_tmp * t133) + t697 * t133) + t6
    * t111) + t84_tmp * t113) + t938_tmp * t134) + t697 * t134) + t253_tmp_tmp *
    t111) + t709 * t113) + t253_tmp_tmp * t112) + t6 * t113) + t257_tmp_tmp *
    t112) + t285 * t112) + t796_tmp_tmp * t133) + t283 * t113) + mPB * t12 * t43
    * t134) + b_t548_tmp * t133) + t65 * t111) + b_t548_tmp * t134) +
    b_t225_tmp_tmp * t111) + t39 * t113) + b_t225_tmp_tmp * t112) + t65 * t113)
    + t999 * t112) + t716 * t99 * -2.0) + t721 * t98 * -2.0) + -(t714 * t81 *
    2.0)) + -(t714 * t82 * 2.0)) + -(t714 * t86 * 2.0)) + t716 * t105 * -2.0) +
    t721 * t104 * -2.0) + -(t714 * t90 * 2.0)) + -(t789 * t89 * 2.0)) + -(t789 *
    t94 * 2.0)) + InertiaBody * t461) + t938_tmp * t171) + t697 * t171) +
    InertiaBody * t464) + InertiaBody * t465) + InertiaBody * t466) +
    InertiaBody * t467) + t796_tmp_tmp * t171) + b_t548_tmp * t171) +
    InertiaBody * t472) + b_t939_tmp_tmp * t171) + InertiaBody * t474) + -(t716 *
    t150 * 2.0)) + -(t716 * t156 * 2.0)) + t6 * t149) + t285 * t151) + t6 * t155)
    + t65 * t149) + t285 * t157) + t249 * t151) + t65 * t155) + t249 * t157) +
    -(t798 * t133 * 2.0)) + -(t798 * t134 * 2.0)) + -(t569_tmp * t113 * 2.0)) +
    -(t714 * t112 * 2.0)) + -(t1000_tmp * t113 * 2.0)) + -(t789 * t112 * 2.0)) +
    -(t798 * t171 * 2.0)) + t84_tmp * t170) + InertiaArm * t498) + t709 * t170)
    + InertiaArm * t500) + t6 * t170) + InertiaArm * t502) + t283 * t170) +
    InertiaArm * t504) + t65 * t170) + InertiaArm * t506) + -(t569_tmp * t170 *
    2.0)) + mLeg * rArmMCD * rBody * t38 * t41 * t179 * 4.0) + t667 * t529 * 2.0)
    + t667 * t530 * 2.0) + -(t689 * t398 * 4.0)) + -(t792_tmp * t398 * 4.0)) +
    t285 * t375) + t285 * t382) + t285 * t383) + t249 * t375) + t285 * t390) +
    t249 * t382) + t249 * t383) + t82_tmp * rBody * rBodyMCD * t11 * t16 * t43 *
    t47 * t50 * 4.0) + t249 * t390) + t667 * t550 * 2.0) + -(t81_tmp_tmp * t10 *
    t12 * t15 * t37 * t38 * t40 * t41 * 2.0)) + -(t81_tmp_tmp * t11 * t12 * t14 *
    t37 * t38 * t40 * t41 * 2.0)) + -(t664 * t10 * t12 * t15 * t37 * t38 * t40 *
    t41 * 2.0)) + -(t664 * t11 * t12 * t14 * t37 * t38 * t40 * t41 * 2.0)) +
    t709 * t462) + t795_tmp_tmp * t498) + t6 * t461) + t6 * t462) + t709 * t463)
    + t939_tmp_tmp * t498) + t712 * t466) + t938_tmp * t502) + t6 * t463) + t697
    * t502) + t6 * t464) + t283 * t463) + t213_tmp * t498) + t709 * t468) +
    t796_tmp_tmp * t500) + t285 * t465) + t6 * t468) + t285 * t466) +
    t796_tmp_tmp * t502) + t84_tmp * t473) + t39 * t461) + mBody * t15 * t48 *
    t461) + t65 * t462) + t709 * t471) + t2 * t498) + t712 * t474) + t938_tmp *
    t506) + t6 * t471) + t65 * t463) + b_t548_tmp * t502) + t697 * t506) + t6 *
    t472) + t65 * t464) + t283 * t471) + t70_tmp * t498) + t283 * t473) + t257 *
    t465) + t249 * t465) + t65 * t468) + t285 * t474) + t796_tmp_tmp * t506) +
    t65 * t471) + b_t548_tmp * t506) + t65 * t472) + t797_tmp * t47 * t50) +
    t797_tmp * t48 * t49) + t796_tmp * t47 * t50) + t796_tmp * t48 * t49) +
    t795_tmp * t47 * t50) + t795_tmp * t48 * t49) + t716 * t497 * -2.0) + -(t716
    * t498 * 2.0)) + t798 * t501 * -2.0) + -(t798 * t502 * 2.0)) + -(t569_tmp *
    t462 * 2.0)) + -(t569_tmp * t463 * 2.0)) + -(t569_tmp * t468 * 2.0)) + t798 *
    t505 * -2.0) + -(t798 * t506 * 2.0)) + -(t1000_tmp * t461 * 2.0)) +
    -(t569_tmp * t471 * 2.0)) + -(t619_tmp_tmp * rBodyMCD * t48 * t465 * 2.0)) +
    t896 * t573 * 2.0) + t194_tmp_tmp * t11 * t12 * t16 * t37 * t38 * t45 * t46 *
    -2.0) + InertiaBody * mPB * t11 * t12 * t16 * t37 * t38 * t45 * t46 * -2.0)
    + -(t688 * t47 * t50 * 2.0)) + -(t688 * t48 * t49 * 2.0)) + t224_tmp_tmp_tmp
    * t11 * t14 * t16 * t40 * t41 * t45 * t46 * -2.0) + t225_tmp_tmp * t11 * t14
    * t16 * t40 * t41 * t45 * t46 * -2.0) + InertiaArm * mPB * t11 * t14 * t16 *
    t40 * t41 * t45 * t46 * -2.0) + t896 * t821 * 2.0) + mBody * rArmMCD *
    rBodyMCD * t38 * t41 * t607 * 2.0) + t667 * t946 * 2.0) + t667 * t949 * 2.0)
    + -(t689 * t890 * 2.0)) + -(t792_tmp * t890 * 2.0)) + -(t609_tmp_tmp_tmp *
    t40 * t894 * 2.0)) + -(t619_tmp_tmp * t40 * t894 * 2.0)) + t6 * t812) +
    t569_tmp * t846) + t569_tmp * t847) + t65 * t812) + t1000_tmp * t846) +
    t1000_tmp * t847) + t667 * t939 * -2.0) + t667 * t940 * -2.0) + t82_tmp *
    t11 * t14 * t16 * t40 * t41 * t43 * t45 * t46 * 4.0) + t938_tmp * t917) +
    t697 * t917) + t796_tmp_tmp * t917) + -(t305 * t49 * 2.0)) + -(t307 * t49 *
    2.0)) + t212_tmp * t44 * t917) + b_t548_tmp * t917) + t213 * t917) + -(t896 *
    t938 * 4.0)) + -(t305 * t50 * 2.0)) + -(t307 * t50 * 2.0)) + t893 * t40 *
                    t41 * t44 * t45 * t46 * 4.0) + t317 * t47 * -2.0) + t684 *
                  t47 * -2.0) + t317 * t48 * -2.0) + t684 * t48 * -2.0) +
               t83_tmp * t43 * t45 * t46 * -2.0) + t87_tmp * t43 * t45 * t46 *
              -2.0) + t86_tmp_tmp * t43 * t45 * t46 * -2.0) + t85_tmp * t43 *
            t45 * t46 * -2.0) + t83_tmp * t44 * t45 * t46 * -2.0) + t87_tmp *
          t44 * t45 * t46 * -2.0) + t86_tmp_tmp * t44 * t45 * t46 * -2.0) +
        t85_tmp * t44 * t45 * t46 * -2.0) + -(t793_tmp * t40 * t41 * t44 * t45 *
        t46 * 2.0)) + -(t794_tmp * t40 * t41 * t44 * t45 * t46 * 2.0)) +
     -(t791_tmp * t40 * t41 * t44 * t45 * t46 * 2.0));
  t2 = t13 * t18;
  t3 = t12 * t20;
  t68 = t12 * t22;
  t67 = t15 * t19;
  t63 = t14 * t21;
  t64 = t15 * t47;
  t70_tmp = t14 * t47;
  t70 = t15 * t48;
  t560_tmp_tmp = t14 * t48;
  b_t225_tmp_tmp = t12 * t43;
  t65 = t12 * t44;
  b_t194_tmp = t13 * t43;
  t550_tmp = t13 * t44;
  t305 = d1 * t16;
  t83_tmp = t110_tmp * t12;
  t664 = t170_tmp * t14;
  t86_tmp_tmp = t664 * t16;
  t667 = t171_tmp * t12;
  t87_tmp = t667 * t16;
  t692 = t463_tmp_tmp * t14;
  t85_tmp = t692 * t16 * t40 * t41;
  t317 = t465_tmp_tmp * t15;
  t86_tmp = t317 * t16 * t37 * t38 * t45 * t46;
  t307 = t465_tmp_tmp * t14;
  b_t83_tmp = t307 * t16 * t40 * t41;
  t684 = t466_tmp_tmp * t15;
  t84_tmp = t684 * t16 * t37 * t38 * t40 * t41;
  t688 = b_t917_tmp_tmp * t12;
  t39 = t688 * t16;
  t82_tmp = t39 * t37 * t38 * t45 * t46;
  *ddrPB = ((t1083 * t76 * t689 + t1080 * t61 * t689) - t1082 * t248 * t689) +
    t1081 * t689 *
    (((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
    ((((((((((((((((((t17_tmp * InertiaBody - t268_tmp * t398 * 4.0) - t270_tmp *
    t894 * 2.0) - t268_tmp * t890 * 2.0) + t2 * t43) + t3 * t43) + t2 * t44) +
    t3 * t44) + t68 * t43) + t68 * t44) + t67 * t47) + t63 * t47) + t67 * t48) +
    t63 * t48) + t64 * t82) + t70_tmp * t84) + t70 * t82) + t560_tmp_tmp * t84)
    + t64 * t90) + t70_tmp * t92) + t70 * t90) + t560_tmp_tmp * t92) +
    b_t225_tmp_tmp * t100) + b_t225_tmp_tmp * t101) + t65 * t100) + t65 * t101)
    + b_t225_tmp_tmp * t106) + b_t225_tmp_tmp * t107) + t65 * t106) + t65 * t107)
    + t70_tmp * t113) + t64 * t112) + b_t225_tmp_tmp * t133) + b_t225_tmp_tmp *
    t134) + b_t194_tmp * t150) + b_t225_tmp_tmp * t152) + t550_tmp * t150) + t65
    * t152) + b_t194_tmp * t156) + b_t225_tmp_tmp * t158) + t550_tmp * t156) +
    t64 * t151) + t65 * t158) + t70 * t151) + t64 * t157) + t70 * t157) +
    b_t225_tmp_tmp * t171) + t70_tmp * t170) + t64 * t375) + t70 * t375) + t64 *
    t382) + t64 * t383) + t70 * t382) + t70 * t383) + t64 * t390) + t70 * t390)
    + t70_tmp * t463) + t560_tmp_tmp * t465) + t64 * t465) + t64 * t466) + t70 *
    t465) + t70_tmp * t471) + t70_tmp * t473) + t64 * t474) + b_t225_tmp_tmp *
    t499) + b_t194_tmp * t498) + b_t225_tmp_tmp * t500) + t550_tmp * t498) +
    b_t225_tmp_tmp * t501) + b_t225_tmp_tmp * t502) + b_t225_tmp_tmp * t505) +
    b_t225_tmp_tmp * t506) + b_t225_tmp_tmp * t917) + t65 * t917) -
    b_t700_tmp_tmp * t48 * t465 * 2.0) + t305 * t49) + t305 * t50) + t86_tmp_tmp
                       * t48 * t49) + t87_tmp * t44 * t49) - t83_tmp * t43 * t47
                     * 2.0) - t83_tmp * t44 * t48 * 2.0) - t112_tmp * t15 * t37 *
                   t38 * t40 * t41 * 2.0) - t113_tmp * t14 * t37 * t38 * t40 *
                  t41 * 2.0) - t86_tmp_tmp * t40 * t41 * t45 * t46 * 2.0) -
                t87_tmp * t37 * t38 * t45 * t46 * 2.0) - t39 * t43 * t47 * t50 *
               2.0) - t85_tmp * t43 * t45 * t46 * 2.0) - t85_tmp * t44 * t45 *
             t46 * 2.0) - t86_tmp * t47 * 2.0) - b_t83_tmp * t43 * t45 * t46 *
           2.0) - t86_tmp * t48 * 2.0) - b_t83_tmp * t44 * t45 * t46 * 2.0) -
        t84_tmp * t49 * 2.0) - t84_tmp * t50 * 2.0) + t82_tmp * t47 * 2.0) +
     t82_tmp * t48 * 2.0);
  *ddthHand = ((-t1081 * t76 * t689 + t1080 * t1086 * t689) + t1082 * t55 * t689)
    - t1083 * t689 * (((((((((((((((((((((((t54 + t414) + t415) + t416) + t417)
    + t418) + t419) + t420) + t421) + t497) + t498) + t499) + t500) + t501) +
    t502) + t503) + t504) + t505) + t506) + -t507) + t917) + -t951) + -t952) +
                      -t953);
  *ddthShoulder = ((-t1082 * t689 *
                    (((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
    (((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
    (((((((((((((((t17 + t18) + t19) + t20) + t21) + t22) + t23) + t24) + t81) +
    t82) + t83) + t84) + t85) + t86) + t87) + t89) + t90) + t91) + t92) + t93) +
    t94) + t95) + t98) + t99) + t100) + t101) + t102) + t103) + t104) + t105) +
    t106) + t107) + t108) + t109) + t111) + t112) + t113) + t114) + -t96) + -t97)
    + t133) + t134) + -t110) + t149) + t150) + t151) + t152) + t153) + t154) +
    t155) + t156) + t157) + t158) + t159) + t160) + t170) + t171) + t179 * 2.0)
    - t180 * 2.0) + t181 * 2.0) - t182 * 2.0) + t183 * 2.0) + t184 * 2.0) + t185
    * 2.0) + t186 * 2.0) + t187 * 2.0) + t188 * 2.0) + t189 * 2.0) + t190 * 2.0)
    + t197 * 2.0) + t198 * 2.0) + t374) + t375) + t376) + t377) + t380) + t381)
    + t382) + t383) + t384) + t385) + t386) + t387) + t389) + t390) + t391) +
    t392) + t414) + t415) + t416) + t417) + t418) + t419) + t420) + t421) + t461)
    + t462) + t463) + t464) + t465) + t466) + t467) + t468) + t471) + t472) +
    t473) + t474) + -t388) + -t393) + t497) + t498) + t499) + t500) + t501) +
    t502) + t503) + t504) + t505) + t506) + -t476) + -t507) + t561 * 2.0) - t565
    * 2.0) + t570 * 2.0) + t575 * 2.0) - t578 * 2.0) + t583 * 2.0) + t588 * 2.0)
    + t593 * 2.0) + t596 * 2.0) + t602 * 2.0) + t607 * 2.0) - t610 * 2.0) + t617
    * 2.0) + t620 * 2.0) + t624 * 2.0) + t627 * 2.0) + t628 * 2.0) + t637 * 2.0)
    + t640 * 2.0) - t791 * 2.0) - t792 * 2.0) + t793 * 2.0) - t794 * 2.0) + t795
    * 2.0) - t796 * 2.0) - t797 * 2.0) + t812) + t917) + -t846) + -t847) + -t951)
                      + -t952) + -t953) + t1081 * t248 * t689) + t1083 * t55 *
                   t689) - t1080 * t1089 * t689;
  t2 = t224_tmp_tmp_tmp * mBody * t15;
  t3 = t194_tmp_tmp * mBody;
  t68 = t3 * t12;
  t67 = t3 * t13;
  t63 = t224_tmp_tmp * t14;
  t64 = t194_tmp * t12;
  t70_tmp = t194_tmp * t13;
  t70 = t225_tmp * t14;
  t560_tmp_tmp = t225_tmp * t15;
  b_t225_tmp_tmp = t194_tmp_tmp * mPB * t13;
  t65 = t225_tmp_tmp * mPB * t15;
  b_t194_tmp = t152_tmp_tmp_tmp * mPB * t12;
  t550_tmp = mArm * t10;
  c_t548_tmp = t550_tmp * t13 * t15;
  t999 = mBody * t9 * t13 * t15 * t44;
  t1000 = t307 * t44;
  t249 = t317 * t44;
  t253 = t464_tmp_tmp * t14 * t44;
  t257 = t466_tmp_tmp * t14 * t44;
  t621_tmp_tmp = t684 * t44;
  t253_tmp_tmp = mPB * t10 * t12 * t15;
  t257_tmp_tmp = t847_tmp_tmp * t14;
  t285 = t374_tmp_tmp * t14;
  t283 = t285 * t43;
  t285 *= t44;
  t212 = t374_tmp_tmp * t15;
  t616_tmp_tmp = t212 * t43;
  t795_tmp_tmp = t375_tmp_tmp * t14;
  t939_tmp_tmp = t795_tmp_tmp * t43;
  t212 *= t44;
  t795_tmp_tmp *= t44;
  t213_tmp = t375_tmp_tmp * t15;
  t796_tmp_tmp = t213_tmp * t43;
  t213_tmp *= t44;
  b_t939_tmp_tmp = mArm * t11 * t12 * t14;
  t213 = t548_tmp_tmp * mPB * t13 * t15;
  t212_tmp = t213 * t43;
  t896 = t377_tmp_tmp_tmp * t15;
  t893 = t896 * t44;
  t688 *= t44;
  t317 = t77 * t10 * t12 * t44;
  t684 = t700_tmp_tmp * t14 * t43;
  t305 = t700_tmp_tmp * t15 * t43;
  t307 = t66 * t12;
  t83_tmp = t66 * t13;
  t86_tmp_tmp = t569_tmp_tmp_tmp * rBodyMCD * t12;
  t87_tmp = t731_tmp_tmp * t10 * t15;
  t86_tmp = t812_tmp_tmp * t14;
  t85_tmp = t227_tmp_tmp * t14;
  t84_tmp = t550_tmp * t12 * t15;
  b_t83_tmp = t213 * t44;
  t39 = t376_tmp_tmp * t14;
  t82_tmp = t39 * t43;
  *ddthWaist = ((t1081 * t61 * t689 - t1083 * t1086 * t689) + t1082 * t1089 *
                t689) + t1080 * t689 *
    (((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
    (((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
    (((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((t777 + t224 *
    2.0) + t225 * 2.0) - t226 * 2.0) + t227 * 2.0) + t230 * 2.0) + t231 * 2.0) +
    t232 * 2.0) + t245 * 2.0) + t374) + t375) + t376) + t377) + t380) + t381) +
    t382) + t383) + t384) + t385) + t386) + t387) + t389) + t390) + t391) + t392)
    + t461) + t462) + t463) + t464) + t465) + t466) + t467) + t468) + t471) +
    t472) + t473) + t474) + -t388) + -t393) + -t476) + t560 * 2.0) - t563 * 2.0)
    + t564 * 2.0) - t567 * 2.0) + t568 * 2.0) + t569 * 2.0) - t572 * 2.0) + t574
    * 2.0) + t577 * 2.0) - t580 * 2.0) + t581 * 2.0) + t582 * 2.0) + t587 * 2.0)
    + t590 * 2.0) + t591 * 2.0) + t592 * 2.0) + t595 * 2.0) - t598 * 2.0) + t599
    * 2.0) + t600 * 2.0) + t601 * 2.0) - t604 * 2.0) + t609 * 2.0) + t612 * 2.0)
    + t613 * 2.0) + t614 * 2.0) - t615 * 2.0) - t616 * 2.0) + t619 * 2.0) + t622
    * 2.0) + t623 * 2.0) + t630 * 2.0) + t633 * 2.0) + t634 * 2.0) + t635 * 2.0)
    + t636 * 2.0) - t639 * 2.0) - t642 * 2.0) + t700 * 2.0) + t701 * 2.0) - t727
    * 2.0) - t728 * 2.0) - t729 * 2.0) - t730 * 2.0) + t731 * 2.0) + t732 * 2.0)
    - t750 * 2.0) - t751 * 2.0) - t752 * 2.0) - t753 * 2.0) + t812) + -t846) +
    -t847) + d * mArm) + d * mBody) + d1) + d * mPB) + InertiaArm * t10 * t15 *
    t48) + t664 * t48) + InertiaBody * t9 * t13 * t44) + InertiaBody * t10 * t12
    * t44) + t667 * t44) + t2 * t47) + t2 * t48) + t68 * t43) + t68 * t44) + t67
    * t43) + t67 * t44) + t63 * t47) + t63 * t48) + t64 * t43) + t64 * t44) +
    t70_tmp * t43) + t70_tmp * t44) + t70 * t47) + t70 * t48) + t560_tmp_tmp *
    t47) + t560_tmp_tmp * t48) + t152_tmp_tmp * t12 * t44 * 2.0) +
    b_t225_tmp_tmp * t43) + b_t225_tmp_tmp * t44) + t65 * t47) + t65 * t48) +
    b_t194_tmp * t43) + b_t194_tmp * t44) + t85_tmp * t47) + t85_tmp * t48) +
    t154_tmp_tmp * t12 * t43) + t154_tmp_tmp_tmp * mPB * t12 * t44) + t84_tmp *
    t43 * t48) + t84_tmp * t44 * t47) + b_t939_tmp_tmp * t43 * t48) +
    b_t939_tmp_tmp * t44 * t47) + c_t548_tmp * t43 * t48) + t692 * t43 * t48) +
    c_t548_tmp * t44 * t48) + t692 * t44 * t48) + t999 * t47) + t1000 * t47) +
    t999 * t48) + t1000 * t48) + t249 * t47) + t249 * t48) + t253 * t47) + t257 *
    t47) + t253 * t48) + t257 * t48) + t621_tmp_tmp * t47) + t621_tmp_tmp * t48)
    + t253_tmp_tmp * t43 * t48) + t253_tmp_tmp * t44 * t47) + t257_tmp_tmp * t43
    * t48) + t257_tmp_tmp * t44 * t47) - t3 * rArm * rArmMCD * t43 * 2.0) - d2 *
    t43 * 2.0) - t8 * t47 * 2.0) + t283 * t47) + t283 * t48) + t285 * t47) +
    t616_tmp_tmp * t47) + t939_tmp_tmp * t47) + t285 * t48) + t616_tmp_tmp * t48)
    + t212 * t47) + t939_tmp_tmp * t48) + t795_tmp_tmp * t47) + t796_tmp_tmp *
    t47) + t212 * t48) + t795_tmp_tmp * t48) + t796_tmp_tmp * t48) + t213_tmp *
    t47) + t213_tmp * t48) + t212_tmp * t47) + t212_tmp * t48) + b_t83_tmp * t47)
    + b_t83_tmp * t48) + t82_tmp * t47) + t82_tmp * t48) + t39 * t44 * t47) +
    t568_tmp_tmp_tmp * t13 * t14 * t44 * t48) + t377_tmp_tmp_tmp * t14 * t43 *
    t47) + t569_tmp_tmp * mPB * t12 * t14 * t43 * t48) + t569_tmp_tmp * mPB *
    t12 * t14 * t44 * t47) + mBody * mLeg * mPB * t12 * t15 * t43 * t47) + mBody
    * mLeg * mPB * t12 * t14 * t44 * t48) + t896 * t43 * t48) + t893 * t47) +
    t893 * t48) - t87_tmp * t43 * t48 * 2.0) - t86_tmp * t43 * t48 * 2.0) - t688
    * t47 * 2.0) - t688 * t48 * 2.0) - t317 * t47 * 2.0) - t317 * t48 * 2.0) -
    t684 * t47 * 2.0) - t684 * t48 * 2.0) - t305 * t47 * 2.0) - t305 * t48 * 2.0)
    - t307 * t43 * t47 * 2.0) - t83_tmp * t43 * t47 * 2.0) - t307 * t44 * t48 *
                      2.0) - t83_tmp * t44 * t47 * 2.0) - t86_tmp_tmp * t43 *
                    t47 * 2.0) - t86_tmp_tmp * t44 * t48 * 2.0) - mArm * t10 *
                  t12 * t15 * t37 * t38 * t40 * t41 * 2.0) - b_t939_tmp_tmp *
                 t37 * t38 * t40 * t41 * 2.0) - t253_tmp_tmp * t37 * t38 * t40 *
                t41 * 2.0) - t257_tmp_tmp * t37 * t38 * t40 * t41 * 2.0) +
              b_t194_tmp_tmp * t43 * t47 * 4.0) - t75 * 4.0) + t87_tmp * t37 *
            t38 * t40 * t41 * 2.0) + t86_tmp * t37 * t38 * t40 * t41 * 2.0) - t7
          * t40 * t43 * t45 * 4.0) - t589_tmp_tmp * 4.0) + t4 * 4.0) - t307 *
       t37 * t38 * t40 * t41 * 4.0) - t86_tmp_tmp * t37 * t38 * t40 * t41 * 4.0)
     + b_t194_tmp_tmp * t37 * t38 * t40 * t41 * 4.0);
}

/* End of code generation (find_ddrPB_ddthHand_ddthShoulder_ddthWaist.c) */
