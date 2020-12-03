/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * find_ddrPB_ddthHand_ddthShoulder_ddthWaist_terminate.c
 *
 * Code generation for function 'find_ddrPB_ddthHand_ddthShoulder_ddthWaist_terminate'
 *
 */

/* Include files */
#include "find_ddrPB_ddthHand_ddthShoulder_ddthWaist_terminate.h"
#include "_coder_find_ddrPB_ddthHand_ddthShoulder_ddthWaist_mex.h"
#include "find_ddrPB_ddthHand_ddthShoulder_ddthWaist.h"
#include "find_ddrPB_ddthHand_ddthShoulder_ddthWaist_data.h"
#include "rt_nonfinite.h"

/* Function Definitions */
void find_ddrPB_ddthHand_ddthShoulder_ddthWaist_atexit(void)
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtEnterRtStackR2012b(&st);
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
  emlrtExitTimeCleanup(&emlrtContextGlobal);
}

void find_ddrPB_ddthHand_ddthShoulder_ddthWaist_terminate(void)
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  st.tls = emlrtRootTLSGlobal;
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

/* End of code generation (find_ddrPB_ddthHand_ddthShoulder_ddthWaist_terminate.c) */
