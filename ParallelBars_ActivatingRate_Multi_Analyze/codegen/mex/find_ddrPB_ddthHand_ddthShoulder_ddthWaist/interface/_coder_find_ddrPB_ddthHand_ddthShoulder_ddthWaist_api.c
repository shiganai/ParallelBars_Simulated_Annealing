/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_find_ddrPB_ddthHand_ddthShoulder_ddthWaist_api.c
 *
 * Code generation for function '_coder_find_ddrPB_ddthHand_ddthShoulder_ddthWaist_api'
 *
 */

/* Include files */
#include "_coder_find_ddrPB_ddthHand_ddthShoulder_ddthWaist_api.h"
#include "find_ddrPB_ddthHand_ddthShoulder_ddthWaist.h"
#include "find_ddrPB_ddthHand_ddthShoulder_ddthWaist_data.h"
#include "rt_nonfinite.h"

/* Function Declarations */
static real_T b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId);
static real_T c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId);
static real_T emlrt_marshallIn(const emlrtStack *sp, const mxArray *InertiaLeg,
  const char_T *identifier);
static const mxArray *emlrt_marshallOut(const real_T u);

/* Function Definitions */
static real_T b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId)
{
  real_T y;
  y = c_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static real_T c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId)
{
  real_T ret;
  static const int32_T dims = 0;
  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 0U, &dims);
  ret = *(real_T *)emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

static real_T emlrt_marshallIn(const emlrtStack *sp, const mxArray *InertiaLeg,
  const char_T *identifier)
{
  real_T y;
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = b_emlrt_marshallIn(sp, emlrtAlias(InertiaLeg), &thisId);
  emlrtDestroyArray(&InertiaLeg);
  return y;
}

static const mxArray *emlrt_marshallOut(const real_T u)
{
  const mxArray *y;
  const mxArray *m;
  y = NULL;
  m = emlrtCreateDoubleScalar(u);
  emlrtAssign(&y, m);
  return y;
}

void find_ddrPB_ddthHand_ddthShoulder_ddthWaist_api(const mxArray * const prhs
  [23], int32_T nlhs, const mxArray *plhs[4])
{
  real_T InertiaLeg;
  real_T InertiaArm;
  real_T InertiaBody;
  real_T MrPB;
  real_T MthHand;
  real_T MthWaist;
  real_T MthShoulder;
  real_T dthHand;
  real_T dthWaist;
  real_T dthShoulder;
  real_T g;
  real_T mArm;
  real_T mBody;
  real_T mLeg;
  real_T mPB;
  real_T rArm;
  real_T rArmMCD;
  real_T rBody;
  real_T rBodyMCD;
  real_T rLegMCD;
  real_T thHand;
  real_T thShoulder;
  real_T thWaist;
  real_T ddrPB;
  real_T ddthHand;
  real_T ddthShoulder;
  real_T ddthWaist;
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  st.tls = emlrtRootTLSGlobal;

  /* Marshall function inputs */
  InertiaLeg = emlrt_marshallIn(&st, emlrtAliasP(prhs[0]), "InertiaLeg");
  InertiaArm = emlrt_marshallIn(&st, emlrtAliasP(prhs[1]), "InertiaArm");
  InertiaBody = emlrt_marshallIn(&st, emlrtAliasP(prhs[2]), "InertiaBody");
  MrPB = emlrt_marshallIn(&st, emlrtAliasP(prhs[3]), "MrPB");
  MthHand = emlrt_marshallIn(&st, emlrtAliasP(prhs[4]), "MthHand");
  MthWaist = emlrt_marshallIn(&st, emlrtAliasP(prhs[5]), "MthWaist");
  MthShoulder = emlrt_marshallIn(&st, emlrtAliasP(prhs[6]), "MthShoulder");
  dthHand = emlrt_marshallIn(&st, emlrtAliasP(prhs[7]), "dthHand");
  dthWaist = emlrt_marshallIn(&st, emlrtAliasP(prhs[8]), "dthWaist");
  dthShoulder = emlrt_marshallIn(&st, emlrtAliasP(prhs[9]), "dthShoulder");
  g = emlrt_marshallIn(&st, emlrtAliasP(prhs[10]), "g");
  mArm = emlrt_marshallIn(&st, emlrtAliasP(prhs[11]), "mArm");
  mBody = emlrt_marshallIn(&st, emlrtAliasP(prhs[12]), "mBody");
  mLeg = emlrt_marshallIn(&st, emlrtAliasP(prhs[13]), "mLeg");
  mPB = emlrt_marshallIn(&st, emlrtAliasP(prhs[14]), "mPB");
  rArm = emlrt_marshallIn(&st, emlrtAliasP(prhs[15]), "rArm");
  rArmMCD = emlrt_marshallIn(&st, emlrtAliasP(prhs[16]), "rArmMCD");
  rBody = emlrt_marshallIn(&st, emlrtAliasP(prhs[17]), "rBody");
  rBodyMCD = emlrt_marshallIn(&st, emlrtAliasP(prhs[18]), "rBodyMCD");
  rLegMCD = emlrt_marshallIn(&st, emlrtAliasP(prhs[19]), "rLegMCD");
  thHand = emlrt_marshallIn(&st, emlrtAliasP(prhs[20]), "thHand");
  thShoulder = emlrt_marshallIn(&st, emlrtAliasP(prhs[21]), "thShoulder");
  thWaist = emlrt_marshallIn(&st, emlrtAliasP(prhs[22]), "thWaist");

  /* Invoke the target function */
  find_ddrPB_ddthHand_ddthShoulder_ddthWaist(&st, InertiaLeg, InertiaArm,
    InertiaBody, MrPB, MthHand, MthWaist, MthShoulder, dthHand, dthWaist,
    dthShoulder, g, mArm, mBody, mLeg, mPB, rArm, rArmMCD, rBody, rBodyMCD,
    rLegMCD, thHand, thShoulder, thWaist, &ddrPB, &ddthHand, &ddthShoulder,
    &ddthWaist);

  /* Marshall function outputs */
  plhs[0] = emlrt_marshallOut(ddrPB);
  if (nlhs > 1) {
    plhs[1] = emlrt_marshallOut(ddthHand);
  }

  if (nlhs > 2) {
    plhs[2] = emlrt_marshallOut(ddthShoulder);
  }

  if (nlhs > 3) {
    plhs[3] = emlrt_marshallOut(ddthWaist);
  }
}

/* End of code generation (_coder_find_ddrPB_ddthHand_ddthShoulder_ddthWaist_api.c) */
