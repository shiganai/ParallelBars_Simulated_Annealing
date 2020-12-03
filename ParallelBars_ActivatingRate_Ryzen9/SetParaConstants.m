function Para = SetParaConstants(Para, constants)
%SETPARACONSTANTS この関数の概要をここに記述
%   詳細説明をここに記述

Para.constants_Name = constants.constants_Name;
Para.constants.g = constants.g;
Para.constants.kPB = constants.kPB;
Para.constants.cPB = constants.cPB;
Para.constants.mAll = constants.mAll;
Para.constants.mPB = constants.mPB;
Para.constants.rAll = constants.rAll;
Para.constants.mArm = constants.mArm;
Para.constants.mBody = constants.mBody;
Para.constants.mLeg = constants.mLeg;
Para.constants.rArm = constants.rArm;
Para.constants.rBody = constants.rBody;
Para.constants.rLeg = constants.rLeg;

Para.constants.InertiaModel.InertiaModel_Name = constants.InertiaModel.InertiaModel_Name;
Para.constants.InertiaModel.mArm = constants.InertiaModel.mArm;
Para.constants.InertiaModel.mBody = constants.InertiaModel.mBody;
Para.constants.InertiaModel.mLeg = constants.InertiaModel.mLeg;
Para.constants.InertiaModel.rArm = constants.InertiaModel.rArm;
Para.constants.InertiaModel.rBody = constants.InertiaModel.rBody;
Para.constants.InertiaModel.rLeg = constants.InertiaModel.rLeg;
Para.constants.InertiaModel.rArmMCD = constants.InertiaModel.rArmMCD;
Para.constants.InertiaModel.rBodyMCD = constants.InertiaModel.rBodyMCD;
Para.constants.InertiaModel.rLegMCD = constants.InertiaModel.rLegMCD;
Para.constants.InertiaModel.InertiaArm = constants.InertiaModel.InertiaArm;
Para.constants.InertiaModel.InertiaBody = constants.InertiaModel.InertiaBody;
Para.constants.InertiaModel.InertiaLeg = constants.InertiaModel.InertiaLeg;

Para.constants.rArmMCD = constants.rArmMCD;
Para.constants.rBodyMCD = constants.rBodyMCD;
Para.constants.rLegMCD = constants.rLegMCD;
Para.constants.InertiaArm = constants.InertiaArm;
Para.constants.InertiaBody = constants.InertiaBody;
Para.constants.InertiaLeg = constants.InertiaLeg;
Para.constants.InertiaG = constants.InertiaG;

Para.constants.Hand_Para = constants.Hand_Para;
Para.constants.Shoulder_Para = constants.Shoulder_Para;
Para.constants.Waist_Para = constants.Waist_Para;

end

