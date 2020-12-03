/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_find_ddrPB_ddthHand_ddthShoulder_ddthWaist_mex.c
 *
 * Code generation for function '_coder_find_ddrPB_ddthHand_ddthShoulder_ddthWaist_mex'
 *
 */

/* Include files */
#include "_coder_find_ddrPB_ddthHand_ddthShoulder_ddthWaist_mex.h"
#include "_coder_find_ddrPB_ddthHand_ddthShoulder_ddthWaist_api.h"
#include "find_ddrPB_ddthHand_ddthShoulder_ddthWaist.h"
#include "find_ddrPB_ddthHand_ddthShoulder_ddthWaist_data.h"
#include "find_ddrPB_ddthHand_ddthShoulder_ddthWaist_initialize.h"
#include "find_ddrPB_ddthHand_ddthShoulder_ddthWaist_terminate.h"

/* Function Declarations */
MEXFUNCTION_LINKAGE void c_find_ddrPB_ddthHand_ddthShoul(int32_T nlhs, mxArray
  *plhs[4], int32_T nrhs, const mxArray *prhs[23]);

/* Function Definitions */
void c_find_ddrPB_ddthHand_ddthShoul(int32_T nlhs, mxArray *plhs[4], int32_T
  nrhs, const mxArray *prhs[23])
{
  const mxArray *outputs[4];
  int32_T b_nlhs;
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  st.tls = emlrtRootTLSGlobal;

  /* Check for proper number of arguments. */
  if (nrhs != 23) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:WrongNumberOfInputs", 5, 12, 23, 4,
                        42, "find_ddrPB_ddthHand_ddthShoulder_ddthWaist");
  }

  if (nlhs > 4) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:TooManyOutputArguments", 3, 4, 42,
                        "find_ddrPB_ddthHand_ddthShoulder_ddthWaist");
  }

  /* Call the function. */
  find_ddrPB_ddthHand_ddthShoulder_ddthWaist_api(prhs, nlhs, outputs);

  /* Copy over outputs to the caller. */
  if (nlhs < 1) {
    b_nlhs = 1;
  } else {
    b_nlhs = nlhs;
  }

  emlrtReturnArrays(b_nlhs, plhs, outputs);
}

void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs, const mxArray
                 *prhs[])
{
  mexAtExit(&find_ddrPB_ddthHand_ddthShoulder_ddthWaist_atexit);

  /* Module initialization. */
  find_ddrPB_ddthHand_ddthShoulder_ddthWaist_initialize();

  /* Dispatch the entry-point. */
  c_find_ddrPB_ddthHand_ddthShoul(nlhs, plhs, nrhs, prhs);

  /* Module termination. */
  find_ddrPB_ddthHand_ddthShoulder_ddthWaist_terminate();
}

emlrtCTX mexFunctionCreateRootTLS(void)
{
  emlrtCreateRootTLS(&emlrtRootTLSGlobal, &emlrtContextGlobal, NULL, 1);
  return emlrtRootTLSGlobal;
}

/* End of code generation (_coder_find_ddrPB_ddthHand_ddthShoulder_ddthWaist_mex.c) */
