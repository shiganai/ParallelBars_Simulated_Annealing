/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * find_ddrPB_ddthHand_ddthShoulder_ddthWaist.h
 *
 * Code generation for function 'find_ddrPB_ddthHand_ddthShoulder_ddthWaist'
 *
 */

#pragma once

/* Include files */
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "mex.h"
#include "emlrt.h"
#include "rtwtypes.h"
#include "find_ddrPB_ddthHand_ddthShoulder_ddthWaist_types.h"

/* Function Declarations */
void find_ddrPB_ddthHand_ddthShoulder_ddthWaist(const emlrtStack *sp, real_T
  InertiaLeg, real_T InertiaArm, real_T InertiaBody, real_T MrPB, real_T MthHand,
  real_T MthWaist, real_T MthShoulder, real_T dthHand, real_T dthWaist, real_T
  dthShoulder, real_T g, real_T mArm, real_T mBody, real_T mLeg, real_T mPB,
  real_T rArm, real_T rArmMCD, real_T rBody, real_T rBodyMCD, real_T rLegMCD,
  real_T thHand, real_T thShoulder, real_T thWaist, real_T *ddrPB, real_T
  *ddthHand, real_T *ddthShoulder, real_T *ddthWaist);

/* End of code generation (find_ddrPB_ddthHand_ddthShoulder_ddthWaist.h) */
