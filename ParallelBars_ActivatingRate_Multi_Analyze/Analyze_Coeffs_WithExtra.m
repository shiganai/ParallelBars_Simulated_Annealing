
%% 正面支持の時間を取得
time_AtBodyUpStraight = interp1(thHand+1/2*pi + thShoulder, time, 3/2*pi);

%% 角運動量の時間微分に含まれる MthHand, MthShoulder, MthWaist, kPB の係数、貢献量の計算

[ddrPB_tmp,ddthHand_tmp,ddthShoulder_tmp,ddthWaist_tmp] = find_ddrPB_ddthHand_ddthShoulder_ddthWaist(InertiaLeg,InertiaArm,InertiaBody,MrPB,MthHand,MthWaist,MthShoulder,dthHand,dthWaist,dthShoulder,g,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
ddxHand_tmp = 0;
ddyHand_tmp = ddrPB_tmp;
dmomentumG_tmp_Before = find_dmomentumG(InertiaLeg,InertiaArm,InertiaBody,ddthHand_tmp,ddthWaist_tmp,ddthShoulder_tmp,ddxHand_tmp,ddyHand_tmp,dthHand,dthWaist,dthShoulder,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist,xHand,yHand);

Mth_StepH = 1e-3;

% MrPB_Coeffs を得る
MrPB_tmp = MrPB + Mth_StepH;
MthHand_tmp = MthHand;
MthShoulder_tmp = MthShoulder;
MthWaist_tmp = MthWaist;
[ddrPB_tmp,ddthHand_tmp,ddthShoulder_tmp,ddthWaist_tmp] = find_ddrPB_ddthHand_ddthShoulder_ddthWaist(InertiaLeg,InertiaArm,InertiaBody,MrPB_tmp,MthHand_tmp,MthWaist_tmp,MthShoulder_tmp,dthHand,dthWaist,dthShoulder,g,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
ddxHand_tmp = 0;
ddyHand_tmp = ddrPB_tmp;
dmomentumG_tmp_After = find_dmomentumG(InertiaLeg,InertiaArm,InertiaBody,ddthHand_tmp,ddthWaist_tmp,ddthShoulder_tmp,ddxHand_tmp,ddyHand_tmp,dthHand,dthWaist,dthShoulder,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist,xHand,yHand);
MrPB_Coeffs_dmomentumG = (dmomentumG_tmp_After - dmomentumG_tmp_Before)/Mth_StepH;
MrPB_Contri_dmomentumG = MrPB_Coeffs_dmomentumG .* MrPB;
MrPB_Contri_dmomentumG_Integral = fnval(fnint(spline(time_onbar, MrPB_Contri_dmomentumG)),time_onbar);

% MthHand_Coeffs を得る
MrPB_tmp = MrPB;
MthHand_tmp = MthHand + Mth_StepH;
MthShoulder_tmp = MthShoulder;
MthWaist_tmp = MthWaist;
[ddrPB_tmp,ddthHand_tmp,ddthShoulder_tmp,ddthWaist_tmp] = find_ddrPB_ddthHand_ddthShoulder_ddthWaist(InertiaLeg,InertiaArm,InertiaBody,MrPB_tmp,MthHand_tmp,MthWaist_tmp,MthShoulder_tmp,dthHand,dthWaist,dthShoulder,g,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
ddxHand_tmp = 0;
ddyHand_tmp = ddrPB_tmp;
dmomentumG_tmp_After = find_dmomentumG(InertiaLeg,InertiaArm,InertiaBody,ddthHand_tmp,ddthWaist_tmp,ddthShoulder_tmp,ddxHand_tmp,ddyHand_tmp,dthHand,dthWaist,dthShoulder,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist,xHand,yHand);
MthHand_Coeffs_dmomentumG = (dmomentumG_tmp_After - dmomentumG_tmp_Before)/Mth_StepH;
MthHand_Contri_dmomentumG = MthHand_Coeffs_dmomentumG .* MthHand;
MthHand_Contri_dmomentumG_Integral = fnval(fnint(spline(time_onbar, MthHand_Contri_dmomentumG)),time_onbar);

% MthShoulder_Coeffs を得る
MrPB_tmp = MrPB;
MthHand_tmp = MthHand;
MthShoulder_tmp = MthShoulder + Mth_StepH;
MthWaist_tmp = MthWaist;
[ddrPB_tmp,ddthHand_tmp,ddthShoulder_tmp,ddthWaist_tmp] = find_ddrPB_ddthHand_ddthShoulder_ddthWaist(InertiaLeg,InertiaArm,InertiaBody,MrPB_tmp,MthHand_tmp,MthWaist_tmp,MthShoulder_tmp,dthHand,dthWaist,dthShoulder,g,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
ddxHand_tmp = 0;
ddyHand_tmp = ddrPB_tmp;
dmomentumG_tmp_After = find_dmomentumG(InertiaLeg,InertiaArm,InertiaBody,ddthHand_tmp,ddthWaist_tmp,ddthShoulder_tmp,ddxHand_tmp,ddyHand_tmp,dthHand,dthWaist,dthShoulder,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist,xHand,yHand);
MthShoulder_Coeffs_dmomentumG = (dmomentumG_tmp_After - dmomentumG_tmp_Before)/Mth_StepH;
MthShoulder_Contri_dmomentumG = MthShoulder_Coeffs_dmomentumG .* MthShoulder;
MthShoulder_Contri_dmomentumG_Integral = fnval(fnint(spline(time_onbar, MthShoulder_Contri_dmomentumG)),time_onbar);

% MthWaist_Coeffs を得る
MrPB_tmp = MrPB;
MthHand_tmp = MthHand;
MthShoulder_tmp = MthShoulder;
MthWaist_tmp = MthWaist + Mth_StepH;
[ddrPB_tmp,ddthHand_tmp,ddthShoulder_tmp,ddthWaist_tmp] = find_ddrPB_ddthHand_ddthShoulder_ddthWaist(InertiaLeg,InertiaArm,InertiaBody,MrPB_tmp,MthHand_tmp,MthWaist_tmp,MthShoulder_tmp,dthHand,dthWaist,dthShoulder,g,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
ddxHand_tmp = 0;
ddyHand_tmp = ddrPB_tmp;
dmomentumG_tmp_After = find_dmomentumG(InertiaLeg,InertiaArm,InertiaBody,ddthHand_tmp,ddthWaist_tmp,ddthShoulder_tmp,ddxHand_tmp,ddyHand_tmp,dthHand,dthWaist,dthShoulder,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist,xHand,yHand);
MthWaist_Coeffs_dmomentumG = (dmomentumG_tmp_After - dmomentumG_tmp_Before)/Mth_StepH;
MthWaist_Contri_dmomentumG = MthWaist_Coeffs_dmomentumG .* MthWaist;
MthWaist_Contri_dmomentumG_Integral = fnval(fnint(spline(time_onbar, MthWaist_Contri_dmomentumG)),time_onbar);

% g_Coeffs を得る
MrPB_tmp = MrPB;
MthHand_tmp = MthHand;
MthShoulder_tmp = MthShoulder;
MthWaist_tmp = MthWaist;
g_tmp = g + Mth_StepH;
[ddrPB_tmp,ddthHand_tmp,ddthShoulder_tmp,ddthWaist_tmp] = find_ddrPB_ddthHand_ddthShoulder_ddthWaist(InertiaLeg,InertiaArm,InertiaBody,MrPB_tmp,MthHand_tmp,MthWaist_tmp,MthShoulder_tmp,dthHand,dthWaist,dthShoulder,g_tmp,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
ddxHand_tmp = 0;
ddyHand_tmp = ddrPB_tmp;
dmomentumG_tmp_After = find_dmomentumG(InertiaLeg,InertiaArm,InertiaBody,ddthHand_tmp,ddthWaist_tmp,ddthShoulder_tmp,ddxHand_tmp,ddyHand_tmp,dthHand,dthWaist,dthShoulder,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist,xHand,yHand);
g_Coeffs_dmomentumG_Mth = (dmomentumG_tmp_After - dmomentumG_tmp_Before)/Mth_StepH;
g_Contri_dmomentumG_Mth = g_Coeffs_dmomentumG_Mth .* g;
g_Contri_dmomentumG_Mth_Integral = fnval(fnint(spline(time_onbar, g_Contri_dmomentumG_Mth)),time_onbar);

% Rest_Coeffs を得る
MrPB_tmp = 0;
MthHand_tmp = 0;
MthShoulder_tmp = 0;
MthWaist_tmp = 0;
g_tmp = 0;
[ddrPB_tmp,ddthHand_tmp,ddthShoulder_tmp,ddthWaist_tmp] = find_ddrPB_ddthHand_ddthShoulder_ddthWaist(InertiaLeg,InertiaArm,InertiaBody,MrPB_tmp,MthHand_tmp,MthWaist_tmp,MthShoulder_tmp,dthHand,dthWaist,dthShoulder,g_tmp,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
ddxHand_tmp = 0;
ddyHand_tmp = ddrPB_tmp;
dmomentumG_tmp_After = find_dmomentumG(InertiaLeg,InertiaArm,InertiaBody,ddthHand_tmp,ddthWaist_tmp,ddthShoulder_tmp,ddxHand_tmp,ddyHand_tmp,dthHand,dthWaist,dthShoulder,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist,xHand,yHand);
Rest_Contri_dmomentumG_Mth = dmomentumG_tmp_After;
% Rest_Contri_dmomentumG_Mth = dmomentumG_tmp_Before - (MthHand_Contri_dmomentumG + MthShoulder_Contri_dmomentumG + MthWaist_Contri_dmomentumG + kPB_Contri_dmomentumG_Mth);
Rest_Contri_dmomentumG_Mth_Integral = fnval(fnint(spline(time_onbar, Rest_Contri_dmomentumG_Mth)),time_onbar);

%% ddrPBに含まれる MthHand, MthShoulder, MthWaist, kPB の係数を計算

ddrPB_tmp_Before = find_ddrPB(InertiaLeg,InertiaArm,InertiaBody,MrPB,MthHand,MthWaist,MthShoulder,dthHand,dthWaist,dthShoulder,g,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);

Mth_StepH = 1e-3;


% MrPB_Coeffs を得る
MrPB_tmp = MrPB + Mth_StepH;
MthHand_tmp = MthHand;
MthShoulder_tmp = MthShoulder;
MthWaist_tmp = MthWaist;

ddrPB_tmp_After = find_ddrPB(InertiaLeg,InertiaArm,InertiaBody,MrPB_tmp,MthHand_tmp,MthWaist_tmp,MthShoulder_tmp,dthHand,dthWaist,dthShoulder,g,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
MrPB_Coeffs_ddrPB = (ddrPB_tmp_After - ddrPB_tmp_Before)/Mth_StepH;
MrPB_Contri_ddrPB = MrPB_Coeffs_ddrPB .* MrPB;
MrPB_Contri_ddrPB_Integral = fnval(fnint(spline(time_onbar, MrPB_Contri_ddrPB)),time_onbar);

% MthHand_Coeffs を得る
MrPB_tmp = MrPB;
MthHand_tmp = MthHand + Mth_StepH;
MthShoulder_tmp = MthShoulder;
MthWaist_tmp = MthWaist;

ddrPB_tmp_After = find_ddrPB(InertiaLeg,InertiaArm,InertiaBody,MrPB_tmp,MthHand_tmp,MthWaist_tmp,MthShoulder_tmp,dthHand,dthWaist,dthShoulder,g,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
MthHand_Coeffs_ddrPB = (ddrPB_tmp_After - ddrPB_tmp_Before)/Mth_StepH;
MthHand_Contri_ddrPB = MthHand_Coeffs_ddrPB .* MthHand;
MthHand_Contri_ddrPB_Integral = fnval(fnint(spline(time_onbar, MthHand_Contri_ddrPB)),time_onbar);

% MthShoulder_Coeffs を得る
MrPB_tmp = MrPB;
MthHand_tmp = MthHand;
MthShoulder_tmp = MthShoulder + Mth_StepH;
MthWaist_tmp = MthWaist;

ddrPB_tmp_After = find_ddrPB(InertiaLeg,InertiaArm,InertiaBody,MrPB_tmp,MthHand_tmp,MthWaist_tmp,MthShoulder_tmp,dthHand,dthWaist,dthShoulder,g,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
MthShoulder_Coeffs_ddrPB = (ddrPB_tmp_After - ddrPB_tmp_Before)/Mth_StepH;
MthShoulder_Contri_ddrPB = MthShoulder_Coeffs_ddrPB .* MthShoulder;
MthShoulder_Contri_ddrPB_Integral = fnval(fnint(spline(time_onbar, MthShoulder_Contri_ddrPB)),time_onbar);

% MthWaist_Coeffs を得る
MrPB_tmp = MrPB;
MthHand_tmp = MthHand;
MthShoulder_tmp = MthShoulder;
MthWaist_tmp = MthWaist + Mth_StepH;

ddrPB_tmp_After = find_ddrPB(InertiaLeg,InertiaArm,InertiaBody,MrPB_tmp,MthHand_tmp,MthWaist_tmp,MthShoulder_tmp,dthHand,dthWaist,dthShoulder,g,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
MthWaist_Coeffs_ddrPB = (ddrPB_tmp_After - ddrPB_tmp_Before)/Mth_StepH;
MthWaist_Contri_ddrPB = MthWaist_Coeffs_ddrPB .* MthWaist;
MthWaist_Contri_ddrPB_Integral = fnval(fnint(spline(time_onbar, MthWaist_Contri_ddrPB)),time_onbar);

% g_Coeffs を得る
MrPB_tmp = MrPB;
MthHand_tmp = MthHand;
MthShoulder_tmp = MthShoulder;
MthWaist_tmp = MthWaist;
g_tmp = g + Mth_StepH;

ddrPB_tmp_After = find_ddrPB(InertiaLeg,InertiaArm,InertiaBody,MrPB_tmp,MthHand_tmp,MthWaist_tmp,MthShoulder_tmp,dthHand,dthWaist,dthShoulder,g_tmp,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
g_Coeffs_ddrPB_Mth = (ddrPB_tmp_After - ddrPB_tmp_Before)/Mth_StepH;
g_Contri_ddrPB_Mth = g_Coeffs_ddrPB_Mth .* g;
g_Contri_ddrPB_Mth_Integral = fnval(fnint(spline(time_onbar, g_Contri_ddrPB_Mth)),time_onbar);

% Rest_Coeffs を得る
MrPB_tmp = 0;
MthHand_tmp = 0;
MthShoulder_tmp = 0;
MthWaist_tmp = 0;
g_tmp = 0;
ddrPB_tmp_After = find_ddrPB(InertiaLeg,InertiaArm,InertiaBody,MrPB_tmp,MthHand_tmp,MthWaist_tmp,MthShoulder_tmp,dthHand,dthWaist,dthShoulder,g_tmp,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
Rest_Contri_ddrPB_Mth = ddrPB_tmp_After;
% Rest_Contri_ddrPB_Mth = ddrPB_tmp_Before - (MthHand_Contri_ddrPB + MthShoulder_Contri_ddrPB + MthWaist_Contri_ddrPB + kPB_Contri_ddrPB_Mth);
Rest_Contri_ddrPB_Mth_Integral = fnval(fnint(spline(time_onbar, Rest_Contri_ddrPB_Mth)),time_onbar);

%% 角運動量の時間微分に含まれる ddthHand, ddthShoulder, ddthWaist, kPB の係数、貢献量の計算

ddxHand_tmp = 0;
ddyHand_tmp = ddrPB_tmp;
ddthHand_tmp = ddthHand;
ddthShoulder_tmp = ddthShoulder;
ddthWaist_tmp = ddthWaist;
dmomentumG_tmp_Before = find_dmomentumG(InertiaLeg,InertiaArm,InertiaBody,ddthHand_tmp,ddthWaist_tmp,ddthShoulder_tmp,ddxHand_tmp,ddyHand_tmp,dthHand,dthWaist,dthShoulder,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist,xHand,yHand);

ddth_StepH = 1e-3;

% ddthHand_Coeffs を得る
ddthHand_tmp = ddthHand + ddth_StepH;
ddthShoulder_tmp = ddthShoulder;
ddthWaist_tmp = ddthWaist;

dmomentumG_tmp_After = find_dmomentumG(InertiaLeg,InertiaArm,InertiaBody,ddthHand_tmp,ddthWaist_tmp,ddthShoulder_tmp,ddxHand_tmp,ddyHand_tmp,dthHand,dthWaist,dthShoulder,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist,xHand,yHand);
ddthHand_Coeffs_dmomentumG = (dmomentumG_tmp_After - dmomentumG_tmp_Before)/ddth_StepH;
ddthHand_Contri_dmomentumG = ddthHand_Coeffs_dmomentumG .* ddthHand;
ddthHand_Contri_dmomentumG_Integral = fnval(fnint(spline(time_onbar, ddthHand_Contri_dmomentumG)),time_onbar);

% ddthShoulder_Coeffs を得る
ddthHand_tmp = ddthHand;
ddthShoulder_tmp = ddthShoulder + ddth_StepH;
ddthWaist_tmp = ddthWaist;

dmomentumG_tmp_After = find_dmomentumG(InertiaLeg,InertiaArm,InertiaBody,ddthHand_tmp,ddthWaist_tmp,ddthShoulder_tmp,ddxHand_tmp,ddyHand_tmp,dthHand,dthWaist,dthShoulder,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist,xHand,yHand);
ddthShoulder_Coeffs_dmomentumG = (dmomentumG_tmp_After - dmomentumG_tmp_Before)/ddth_StepH;
ddthShoulder_Contri_dmomentumG = ddthShoulder_Coeffs_dmomentumG .* ddthShoulder;
ddthShoulder_Contri_dmomentumG_Integral = fnval(fnint(spline(time_onbar, ddthShoulder_Contri_dmomentumG)),time_onbar);

% ddthWaist_Coeffs を得る
ddthHand_tmp = ddthHand;
ddthShoulder_tmp = ddthShoulder;
ddthWaist_tmp = ddthWaist + ddth_StepH;

dmomentumG_tmp_After = find_dmomentumG(InertiaLeg,InertiaArm,InertiaBody,ddthHand_tmp,ddthWaist_tmp,ddthShoulder_tmp,ddxHand_tmp,ddyHand_tmp,dthHand,dthWaist,dthShoulder,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist,xHand,yHand);
ddthWaist_Coeffs_dmomentumG = (dmomentumG_tmp_After - dmomentumG_tmp_Before)/ddth_StepH;
ddthWaist_Contri_dmomentumG = ddthWaist_Coeffs_dmomentumG .* ddthWaist;
ddthWaist_Contri_dmomentumG_Integral = fnval(fnint(spline(time_onbar, ddthWaist_Contri_dmomentumG)),time_onbar);

% Rest_Coeffs を得る
ddthHand_tmp = 0;
ddthShoulder_tmp = 0;
ddthWaist_tmp = 0;

dmomentumG_tmp_After = find_dmomentumG(InertiaLeg,InertiaArm,InertiaBody,ddthHand_tmp,ddthWaist_tmp,ddthShoulder_tmp,ddxHand_tmp,ddyHand_tmp,dthHand,dthWaist,dthShoulder,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist,xHand,yHand);
Rest_Contri_dmomentumG_ddth = dmomentumG_tmp_After;
% Rest_Contri_dmomentumG_ddth = dmomentumG_tmp_Before - (ddthHand_Contri_dmomentumG + ddthShoulder_Contri_dmomentumG + ddthWaist_Contri_dmomentumG + kPB_Contri_dmomentumG_ddth);
Rest_Contri_dmomentumG_ddth_Integral = fnval(fnint(spline(time_onbar, Rest_Contri_dmomentumG_ddth)),time_onbar);

%% ddrPBに含まれる ddthHand, ddthShoulder, ddthWaist, kPB の係数を計算

ddrPB_tmp_Before = find_ddrPB_only(MrPB,ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,g,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);

ddth_StepH = 1e-3;

% MrPB_Coeffs を得る
MrPB_tmp = MrPB + ddth_StepH;
ddthHand_tmp = ddthHand;
ddthShoulder_tmp = ddthShoulder;
ddthWaist_tmp = ddthWaist;

ddrPB_tmp_After = find_ddrPB_only(MrPB_tmp,ddthHand_tmp,ddthWaist_tmp,ddthShoulder_tmp,dthHand,dthWaist,dthShoulder,g,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
MrPB_Coeffs_ddrPB_ddth = (ddrPB_tmp_After - ddrPB_tmp_Before)/ddth_StepH;
MrPB_Contri_ddrPB_ddth = MrPB_Coeffs_ddrPB_ddth .* g;
MrPB_Contri_ddrPB_ddth_Integral = fnval(fnint(spline(time_onbar, MrPB_Contri_ddrPB_ddth)),time_onbar);

% MthHand_Coeffs を得る
ddthHand_tmp = ddthHand + ddth_StepH;
ddthShoulder_tmp = ddthShoulder;
ddthWaist_tmp = ddthWaist;

ddrPB_tmp_After = find_ddrPB_only(MrPB_tmp,ddthHand_tmp,ddthWaist_tmp,ddthShoulder_tmp,dthHand,dthWaist,dthShoulder,g,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
ddthHand_Coeffs_ddrPB = (ddrPB_tmp_After - ddrPB_tmp_Before)/ddth_StepH;
ddthHand_Contri_ddrPB = ddthHand_Coeffs_ddrPB .* ddthHand;
ddthHand_Contri_ddrPB_Integral = fnval(fnint(spline(time_onbar, ddthHand_Contri_ddrPB)),time_onbar);

% MthShoulder_Coeffs を得る

MrPB_tmp = MrPB;
ddthHand_tmp = ddthHand;
ddthShoulder_tmp = ddthShoulder + ddth_StepH;
ddthWaist_tmp = ddthWaist;

ddrPB_tmp_After = find_ddrPB_only(MrPB_tmp,ddthHand_tmp,ddthWaist_tmp,ddthShoulder_tmp,dthHand,dthWaist,dthShoulder,g,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
ddthShoulder_Coeffs_ddrPB = (ddrPB_tmp_After - ddrPB_tmp_Before)/ddth_StepH;
ddthShoulder_Contri_ddrPB = ddthShoulder_Coeffs_ddrPB .* ddthShoulder;
ddthShoulder_Contri_ddrPB_Integral = fnval(fnint(spline(time_onbar, ddthShoulder_Contri_ddrPB)),time_onbar);

% MthWaist_Coeffs を得る

MrPB_tmp = MrPB;
ddthHand_tmp = ddthHand;
ddthShoulder_tmp = ddthShoulder;
ddthWaist_tmp = ddthWaist + ddth_StepH;

ddrPB_tmp_After = find_ddrPB_only(MrPB_tmp,ddthHand_tmp,ddthWaist_tmp,ddthShoulder_tmp,dthHand,dthWaist,dthShoulder,g,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
ddthWaist_Coeffs_ddrPB = (ddrPB_tmp_After - ddrPB_tmp_Before)/ddth_StepH;
ddthWaist_Contri_ddrPB = ddthWaist_Coeffs_ddrPB .* ddthWaist;
ddthWaist_Contri_ddrPB_Integral = fnval(fnint(spline(time_onbar, ddthWaist_Contri_ddrPB)),time_onbar);

% g_Coeffs を得る
MrPB_tmp = MrPB;
ddthHand_tmp = ddthHand;
ddthShoulder_tmp = ddthShoulder;
ddthWaist_tmp = ddthWaist;
g_tmp = g + ddth_StepH;

ddrPB_tmp_After = find_ddrPB_only(MrPB_tmp,ddthHand_tmp,ddthWaist_tmp,ddthShoulder_tmp,dthHand,dthWaist,dthShoulder,g_tmp,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
g_Coeffs_ddrPB_ddth = (ddrPB_tmp_After - ddrPB_tmp_Before)/ddth_StepH;
g_Contri_ddrPB_ddth = g_Coeffs_ddrPB_ddth .* g;
g_Contri_ddrPB_ddth_Integral = fnval(fnint(spline(time_onbar, g_Contri_ddrPB_ddth)),time_onbar);

% Rest_Coeffs を得る
MrPB_tmp = 0;
ddthHand_tmp = 0;
ddthShoulder_tmp = 0;
ddthWaist_tmp = 0;
g_tmp = 0;

ddrPB_tmp_After = find_ddrPB_only(MrPB_tmp,ddthHand_tmp,ddthWaist_tmp,ddthShoulder_tmp,dthHand,dthWaist,dthShoulder,g_tmp,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
Rest_Contri_ddrPB_ddth = ddrPB_tmp_After;
% Rest_Contri_ddrPB_Mth = ddrPB_tmp_Before - (ddthHand_Contri_ddrPB + ddthShoulder_Contri_ddrPB + ddthWaist_Contri_ddrPB + kPB_Contri_ddrPB_ddth);
Rest_Contri_ddrPB_ddth_Integral = fnval(fnint(spline(time_onbar, Rest_Contri_ddrPB_ddth)),time_onbar);

%% 肩関節角度にどれだけ MthWaist が関与するか計算

Mth_StepH = 1e-3;

% MthWaist_Coeffs を得る
MrPB_tmp = MrPB;
MthHand_tmp = MthHand;
MthShoulder_tmp = MthShoulder;
MthWaist_tmp = MthWaist + Mth_StepH;

ddthShoulder_tmp_Before = ddthShoulder;

[ddrPB_tmp_After,ddthHand_tmp_After,ddthShoulder_tmp_After,ddthWaist_tmp_After] = find_ddrPB_ddthHand_ddthShoulder_ddthWaist(InertiaLeg,InertiaArm,InertiaBody,MrPB_tmp,MthHand_tmp,MthWaist_tmp,MthShoulder_tmp,dthHand,dthWaist,dthShoulder,g,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);
% ddthShoulder_tmp_After = ddthShoulder_tmp_After;

MthWaist_Coeffs_ddthShoulder = (ddthShoulder_tmp_After - ddthShoulder_tmp_Before)/Mth_StepH;
MthWaist_Contri_ddthShoulder = MthWaist_Coeffs_ddthShoulder .* MthWaist;
MthWaist_Contri_ddthShoulder_Integral = fnval(fnint(spline(time_onbar, MthWaist_Contri_ddthShoulder)),time_onbar);

%% 棒反力水平方向にどれだけ MthWaist が関与するか計算

Mth_StepH = 1e-3;

% MthWaist_Coeffs を得る
MrPB_tmp = MrPB;
MthHand_tmp = MthHand;
MthShoulder_tmp = MthShoulder;
MthWaist_tmp = MthWaist + Mth_StepH;

Fx_Hand_tmp_Before = find_Fx_Hand(ddthHand,ddthWaist,ddthShoulder,dthHand,dthWaist,dthShoulder,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);

[ddrPB_tmp_After,ddthHand_tmp_After,ddthShoulder_tmp_After,ddthWaist_tmp_After] = find_ddrPB_ddthHand_ddthShoulder_ddthWaist(InertiaLeg,InertiaArm,InertiaBody,MrPB_tmp,MthHand_tmp,MthWaist_tmp,MthShoulder_tmp,dthHand,dthWaist,dthShoulder,g,mArm,mBody,mLeg,mPB,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);

Fx_Hand_tmp_After = find_Fx_Hand(ddthHand_tmp_After,ddthWaist_tmp_After,ddthShoulder_tmp_After,dthHand,dthWaist,dthShoulder,mArm,mBody,mLeg,rArm,rArmMCD,rBody,rBodyMCD,rLegMCD,thHand,thShoulder,thWaist);

MthWaist_Coeffs_Fx_Hand = (Fx_Hand_tmp_After - Fx_Hand_tmp_Before)/Mth_StepH;
MthWaist_Contri_Fx_Hand = MthWaist_Coeffs_Fx_Hand .* MthWaist;
MthWaist_Contri_Fx_Hand_Integral = fnval(fnint(spline(time_onbar, MthWaist_Contri_Fx_Hand)),time_onbar);


%% グラフに出力

Figure_Base_Num = 20;
FontSize = 15;

figure(1 + Figure_Base_Num)
plot(time_onbar, [MthHand_Coeffs_dmomentumG, MthShoulder_Coeffs_dmomentumG, MthWaist_Coeffs_dmomentumG, MrPB_Coeffs_dmomentumG, g_Coeffs_dmomentumG_Mth])
title('$$a_i=\frac{\partial}{\partial\tau_i}\left(\frac{\partial L}{\partial t}\right)$$', 'Interpreter', 'latex', 'FontSize', FontSize)
xlabel('時間(s)')
xlim(time_onbar([1,end]))
ylabel('貢献係数')
legend({'手首のトルク', '肩のトルク', '腰のトルク', '棒反力', '重力'},'location','best')
drawnow
ax = gca;
ax.YLimMode = 'manual';
line([time_AtBodyUpStraight, time_AtBodyUpStraight], ax.YLim, 'LineStyle', ':', 'Color', 'black', 'DisplayName', '胴体が垂直')
ax.YGrid = 'on';

figure(2 + Figure_Base_Num)
plot(time_onbar, [MthHand_Contri_dmomentumG, MthShoulder_Contri_dmomentumG, MthWaist_Contri_dmomentumG, MrPB_Contri_dmomentumG, g_Contri_dmomentumG_Mth, Rest_Contri_dmomentumG_Mth])
title('$$\frac{\partial L}{\partial t} = \sum_i \tau_i\cdot\frac{\partial}{\partial\tau_i}\left(\frac{\partial L}{\partial t}\right)$$', 'Interpreter', 'latex', 'FontSize', FontSize)
xlabel('時間(s)')
xlim(time_onbar([1,end]))
ylabel('貢献量(Nm)')
legend({'手首のトルク', '肩のトルク', '腰のトルク', '棒反力', '重力', '残り'},'location','best')
line(time_onbar, dmomentumG_tmp_Before, 'LineStyle', '--', 'Color', 'black', 'DisplayName', '\partial L/\partial t')
drawnow
ax = gca;
ax.YLimMode = 'manual';
line([time_AtBodyUpStraight, time_AtBodyUpStraight], ax.YLim, 'LineStyle', ':', 'Color', 'black', 'DisplayName', '胴体が垂直')
ax.YGrid = 'on';

figure(3 + Figure_Base_Num)
plot(time_onbar, [MthHand_Contri_dmomentumG_Integral, MthShoulder_Contri_dmomentumG_Integral, MthWaist_Contri_dmomentumG_Integral, MrPB_Contri_dmomentumG_Integral, g_Contri_dmomentumG_Mth_Integral, Rest_Contri_dmomentumG_Mth_Integral])
title('$$\Delta L = \sum_i \int_0^t \tau\cdot\frac{\partial}{\partial\tau}\left(\frac{\partial L}{\partial t}\right)dt$$', 'Interpreter', 'latex', 'FontSize', FontSize)
xlabel('時間(s)')
xlim(time_onbar([1,end]))
ylabel('貢献量の積分値(Nms)')
legend({'手首のトルク', '肩のトルク', '腰のトルク', '棒反力', '重力', '残り'},'location','best')
line(time_onbar, momentumG, 'LineStyle', '--', 'Color', 'black', 'DisplayName', '\Delta L')
drawnow
ax = gca;
ax.YLimMode = 'manual';
line([time_AtBodyUpStraight, time_AtBodyUpStraight], ax.YLim, 'LineStyle', ':', 'Color', 'black', 'DisplayName', '胴体が垂直')
ax.YGrid = 'on';


figure(4 + Figure_Base_Num)
plot(time_onbar, [MthHand_Coeffs_ddrPB, MthShoulder_Coeffs_ddrPB, MthWaist_Coeffs_ddrPB, MrPB_Coeffs_ddrPB, g_Coeffs_ddrPB_Mth])
title('$$a_i = \frac{\partial}{\partial\tau_i}\left(\frac{\partial (vPB)}{\partial t}\right)$$', 'Interpreter', 'latex', 'FontSize', FontSize)
xlabel('時間(s)')
xlim(time_onbar([1,end]))
ylabel('貢献係数(N^{-1}s^{-2})')
legend({'手首のトルク', '肩のトルク', '腰のトルク', '棒反力', '重力'},'location','best')
drawnow
ax = gca;
ax.YLimMode = 'manual';
line([time_AtBodyUpStraight, time_AtBodyUpStraight], ax.YLim, 'LineStyle', ':', 'Color', 'black', 'DisplayName', '胴体が垂直')
ax.YGrid = 'on';

figure(5 + Figure_Base_Num)
% plot(time_onbar, [MthHand_Contri_ddrPB, MthShoulder_Contri_ddrPB, MthWaist_Contri_ddrPB])
plot(time_onbar, [MthHand_Contri_ddrPB, MthShoulder_Contri_ddrPB, MthWaist_Contri_ddrPB, MrPB_Contri_ddrPB, g_Contri_ddrPB_Mth, Rest_Contri_ddrPB_Mth])
title('$$ \frac{\partial (vPB)}{\partial t} = \sum_i \tau_i \cdot \frac{\partial}{\partial\tau_i}\left(\frac{\partial (vPB)}{\partial t}\right)$$', 'Interpreter', 'latex', 'FontSize', FontSize)
xlabel('時間(s)')
xlim(time_onbar([1,end]))
ylabel('貢献量(ms^{-2})')
legend({'手首のトルク', '肩のトルク', '腰のトルク', '棒反力', '重力', '残り'},'location','best')
line(time_onbar, ddrPB_tmp_Before, 'LineStyle', '--', 'Color', 'black', 'DisplayName', '\partial (vPB)/\partial t')
drawnow
ax = gca;
ax.YLimMode = 'manual';
line([time_AtBodyUpStraight, time_AtBodyUpStraight], ax.YLim, 'LineStyle', ':', 'Color', 'black', 'DisplayName', '胴体が垂直')
ax.YGrid = 'on';

figure(6 + Figure_Base_Num)
plot(time_onbar, [MthHand_Contri_ddrPB_Integral, MthShoulder_Contri_ddrPB_Integral, MthWaist_Contri_ddrPB_Integral, MrPB_Contri_ddrPB_Integral, g_Contri_ddrPB_Mth_Integral, Rest_Contri_ddrPB_Mth_Integral])
title('$$ \Delta (vPB) = \sum_i \int_0^t \tau_i \cdot \frac{\partial}{\partial\tau_i}\left(\frac{\partial (vPB)}{\partial t}\right)$$', 'Interpreter', 'latex', 'FontSize', FontSize)
xlabel('時間(s)')
xlim(time_onbar([1,end]))
ylabel('貢献量(ms^{-1})')
legend({'手首のトルク', '肩のトルク', '腰のトルク', '棒反力', '重力', '残り'},'location','best')
line(time_onbar, drPB, 'LineStyle', '--', 'Color', 'black', 'DisplayName', '\Delta (vPB)')
drawnow
ax = gca;
ax.YLimMode = 'manual';
line([time_AtBodyUpStraight, time_AtBodyUpStraight], ax.YLim, 'LineStyle', ':', 'Color', 'black', 'DisplayName', '胴体が垂直')
ax.YGrid = 'on';

figure(7 + Figure_Base_Num)
plot(time_onbar, [ddthHand_Coeffs_dmomentumG, ddthShoulder_Coeffs_dmomentumG, ddthWaist_Coeffs_dmomentumG])
title('$$ a_i = \frac{\partial}{\partial\ddot{\theta_i}}\left(\frac{\partial L}{\partial t}\right)$$', 'Interpreter', 'latex', 'FontSize', FontSize)
xlabel('時間(s)')
xlim(time_onbar([1,end]))
ylabel('貢献係数(Nms^2)')
legend({'手首の角加速度', '肩の角加速度', '腰の角加速度'},'location','best')
drawnow
ax = gca;
ax.YLimMode = 'manual';
line([time_AtBodyUpStraight, time_AtBodyUpStraight], ax.YLim, 'LineStyle', ':', 'Color', 'black', 'DisplayName', '胴体が垂直')
ax.YGrid = 'on';

figure(8 + Figure_Base_Num)
plot(time_onbar, [ddthHand_Contri_dmomentumG, ddthShoulder_Contri_dmomentumG, ddthWaist_Contri_dmomentumG, Rest_Contri_dmomentumG_ddth])
title('$$ \frac{\partial L}{\partial t} = \sum_i \ddot{\theta_i} \cdot \frac{\partial}{\partial\ddot{\theta_i}}\left(\frac{\partial L}{\partial t}\right)$$', 'Interpreter', 'latex', 'FontSize', FontSize)
xlabel('時間(s)')
xlim(time_onbar([1,end]))
ylabel('貢献量(Nm)')
legend({'手首の角加速度', '肩の角加速度', '腰の角加速度', '残り'},'location','best')
line(time_onbar, dmomentumG_tmp_Before, 'LineStyle', '--', 'Color', 'black', 'DisplayName', '\partial L/\partial t')
drawnow
ax = gca;
ax.YLimMode = 'manual';
line([time_AtBodyUpStraight, time_AtBodyUpStraight], ax.YLim, 'LineStyle', ':', 'Color', 'black', 'DisplayName', '胴体が垂直')
ax.YGrid = 'on';

figure(9 + Figure_Base_Num)
plot(time_onbar, [ddthHand_Contri_dmomentumG_Integral, ddthShoulder_Contri_dmomentumG_Integral, ddthWaist_Contri_dmomentumG_Integral, Rest_Contri_dmomentumG_ddth_Integral])
title('$$ \Delta L = \sum_i \int_0^t \ddot{\theta_i} \cdot \frac{\partial}{\partial\ddot{\theta_i}}\left(\frac{\partial L}{\partial t}\right)$$', 'Interpreter', 'latex', 'FontSize', FontSize)
xlabel('時間(s)')
xlim(time_onbar([1,end]))
ylabel('貢献量の積分値(Nms)')
legend({'手首の角加速度', '肩の角加速度', '腰の角加速度', '残り'},'location','best')
line(time_onbar, momentumG, 'LineStyle', '--', 'Color', 'black', 'DisplayName', '\Delta L')
drawnow
ax = gca;
ax.YLimMode = 'manual';
line([time_AtBodyUpStraight, time_AtBodyUpStraight], ax.YLim, 'LineStyle', ':', 'Color', 'black', 'DisplayName', '胴体が垂直')
ax.YGrid = 'on';

figure(10 + Figure_Base_Num)
plot(time_onbar, [ddthHand_Coeffs_ddrPB, ddthShoulder_Coeffs_ddrPB, ddthWaist_Coeffs_ddrPB, MrPB_Coeffs_ddrPB_ddth, g_Coeffs_ddrPB_ddth])
title('$$ a_i = \frac{\partial}{\partial\ddot{\theta_i}}\left(\frac{\partial (vPB)}{\partial t}\right)$$', 'Interpreter', 'latex', 'FontSize', FontSize)
xlabel('時間(s)')
xlim(time_onbar([1,end]))
ylabel('貢献量')
legend({'手首の角加速度', '肩の角加速度', '腰の角加速度', '棒反力', '重力'},'location','best')
drawnow
ax = gca;
ax.YLimMode = 'manual';
line([time_AtBodyUpStraight, time_AtBodyUpStraight], ax.YLim, 'LineStyle', ':', 'Color', 'black', 'DisplayName', '胴体が垂直')
ax.YGrid = 'on';

figure(11 + Figure_Base_Num)
% plot(time_onbar, [ddthHand_Contri_ddrPB, ddthShoulder_Contri_ddrPB, ddthWaist_Contri_ddrPB])
plot(time_onbar, [ddthHand_Contri_ddrPB, ddthShoulder_Contri_ddrPB, ddthWaist_Contri_ddrPB, MrPB_Contri_ddrPB_ddth, g_Contri_ddrPB_ddth, Rest_Contri_ddrPB_ddth])
title('$$ \frac{\partial (vPB)}{\partial t} = \sum_i \ddot{\theta_i} \cdot \frac{\partial}{\partial\ddot{\theta_i}}\left(\frac{\partial (vPB)}{\partial t}\right)$$', 'Interpreter', 'latex', 'FontSize', FontSize)
xlabel('時間(s)')
xlim(time_onbar([1,end]))
ylabel('貢献量(ms^{-2})')
legend({'手首の角加速度', '肩の角加速度', '腰の角加速度', '棒反力', '重力', '残り'},'location','best')
line(time_onbar, ddrPB_tmp_Before, 'LineStyle', '--', 'Color', 'black', 'DisplayName', '\partial (vPB)/\partial t')
drawnow
ax = gca;
ax.YLimMode = 'manual';
line([time_AtBodyUpStraight, time_AtBodyUpStraight], ax.YLim, 'LineStyle', ':', 'Color', 'black', 'DisplayName', '胴体が垂直')
ax.YGrid = 'on';

figure(12 + Figure_Base_Num)
plot(time_onbar, [ddthHand_Contri_ddrPB_Integral, ddthShoulder_Contri_ddrPB_Integral, ddthWaist_Contri_ddrPB_Integral, MrPB_Contri_ddrPB_ddth_Integral, g_Contri_ddrPB_ddth_Integral, Rest_Contri_ddrPB_ddth_Integral])
title('$$ \Delta (vPB) = \sum_i \int_0^t \ddot{\theta_i} \cdot \frac{\partial}{\partial\ddot{\theta_i}}\left(\frac{\partial (vPB)}{\partial t}\right)$$', 'Interpreter', 'latex', 'FontSize', FontSize)
xlabel('時間(s)')
xlim(time_onbar([1,end]))
ylabel('貢献量(ms^{-1})')
legend({'手首の角加速度', '肩の角加速度', '腰の角加速度', '棒反力', '重力', '残り'},'location','best')
line(time_onbar, drPB, 'LineStyle', '--', 'Color', 'black', 'DisplayName', '\Delta (vPB)')
drawnow
ax = gca;
ax.YLimMode = 'manual';
line([time_AtBodyUpStraight, time_AtBodyUpStraight], ax.YLim, 'LineStyle', ':', 'Color', 'black', 'DisplayName', '胴体が垂直')
ax.YGrid = 'on';

figure(13 + Figure_Base_Num)
plot(time_onbar, [MthHand, MthShoulder, MthWaist])
title('関節トルク(Nm)')
xlabel('時間(s)')
xlim(time_onbar([1,end]))
ylabel('トルク(Nms^{-1})')
legend({'手', '肩', '腰'},'location','best')
drawnow
ax = gca;
ax.YLimMode = 'manual';
line([time_AtBodyUpStraight, time_AtBodyUpStraight], ax.YLim, 'LineStyle', ':', 'Color', 'black', 'DisplayName', '胴体が垂直')
ax.YGrid = 'on';

figure(14 + Figure_Base_Num)
plot(time_onbar, MrPB)
title('棒反力(N)')
xlabel('時間(s)')
xlim(time_onbar([1,end]))
ylabel('力(N)')
legend({'棒反力'},'location','best')
drawnow
ax = gca;
ax.YLimMode = 'manual';
line([time_AtBodyUpStraight, time_AtBodyUpStraight], ax.YLim, 'LineStyle', ':', 'Color', 'black', 'DisplayName', '胴体が垂直')
ax.YGrid = 'on';

figure(15 + Figure_Base_Num)
plot(time_onbar, [ddthHand, ddthShoulder, ddthWaist])
title('角加速度(s^{-2})')
xlabel('時間(s)')
xlim(time_onbar([1,end]))
ylabel('角加速度(s^{-2})')
legend({'手', '肩', '腰'},'location','best')
drawnow
ax = gca;
ax.YLimMode = 'manual';
line([time_AtBodyUpStraight, time_AtBodyUpStraight], ax.YLim, 'LineStyle', ':', 'Color', 'black', 'DisplayName', '胴体が垂直')
ax.YGrid = 'on';

figure(16 + Figure_Base_Num)
plot(time_onbar, MthWaist_Coeffs_ddthShoulder)
title('胴体の角加速度への貢献係数')
xlabel('時間(s)')
xlim(time_onbar([1,end]))
ylabel('係数')
legend({'腰'},'location','best')
drawnow
ax = gca;
ax.YLimMode = 'manual';
line([time_AtBodyUpStraight, time_AtBodyUpStraight], ax.YLim, 'LineStyle', ':', 'Color', 'black', 'DisplayName', '胴体が垂直')
ax.YGrid = 'on';

figure(17 + Figure_Base_Num)
plot(time_onbar, MthWaist_Contri_ddthShoulder)
title('胴体の角加速度への貢献量')
xlabel('時間(s)')
xlim(time_onbar([1,end]))
ylabel('s^{^2}')
legend({'腰'},'location','best')
drawnow
ax = gca;
ax.YLimMode = 'manual';
line([time_AtBodyUpStraight, time_AtBodyUpStraight], ax.YLim, 'LineStyle', ':', 'Color', 'black', 'DisplayName', '胴体が垂直')
ax.YGrid = 'on';

figure(18 + Figure_Base_Num)
plot(time_onbar, MthWaist_Contri_ddthShoulder_Integral)
title('胴体の角加速度への貢献量の積分値')
xlabel('時間(s)')
xlim(time_onbar([1,end]))
ylabel('s^{-1}')
legend({'腰'},'location','best')
drawnow
ax = gca;
ax.YLimMode = 'manual';
line([time_AtBodyUpStraight, time_AtBodyUpStraight], ax.YLim, 'LineStyle', ':', 'Color', 'black', 'DisplayName', '胴体が垂直')
ax.YGrid = 'on';

figure(19 + Figure_Base_Num)
plot(time_onbar, MthWaist_Coeffs_Fx_Hand)
title('棒反力水平成分への貢献係数')
xlabel('時間(s)')
xlim(time_onbar([1,end]))
ylabel('係数')
legend({'腰'},'location','best')
drawnow
ax = gca;
ax.YLimMode = 'manual';
line([time_AtBodyUpStraight, time_AtBodyUpStraight], ax.YLim, 'LineStyle', ':', 'Color', 'black', 'DisplayName', '胴体が垂直')
ax.YGrid = 'on';

figure(20 + Figure_Base_Num)
plot(time_onbar, MthWaist_Contri_Fx_Hand)
title('棒反力水平成分への貢献量')
xlabel('時間(s)')
xlim(time_onbar([1,end]))
ylabel('s^{^2}')
legend({'腰'},'location','best')
drawnow
ax = gca;
ax.YLimMode = 'manual';
line([time_AtBodyUpStraight, time_AtBodyUpStraight], ax.YLim, 'LineStyle', ':', 'Color', 'black', 'DisplayName', '胴体が垂直')
ax.YGrid = 'on';

figure(21 + Figure_Base_Num)
plot(time_onbar, MthWaist_Contri_Fx_Hand_Integral)
title('棒反力水平成分への貢献量の積分値')
xlabel('時間(s)')
xlim(time_onbar([1,end]))
ylabel('s^{-1}')
legend({'腰'},'location','best')
drawnow
ax = gca;
ax.YLimMode = 'manual';
line([time_AtBodyUpStraight, time_AtBodyUpStraight], ax.YLim, 'LineStyle', ':', 'Color', 'black', 'DisplayName', '胴体が垂直')
ax.YGrid = 'on';



















































