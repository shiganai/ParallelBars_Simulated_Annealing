classdef InertiaModel_CompleteSticks
    %INERTIAMODEL_YEADON ���̃N���X�̊T�v�������ɋL�q
    %   �ڍא����������ɋL�q
    
    properties(Constant)
        InertiaModel_Name = 'InertiaModel_CompleteSticks';
        mArm = 1;
        mBody = 1;
        mLeg = 1;
        
        rArm = 1;
        rBody = 1;
        rLeg = 1;
        
        rArmMCD = 1/2;
        rBodyMCD = 1/2;
        rLegMCD = 1/2;
        
        InertiaArm = 1/12;
        InertiaBody = 1/12;
        InertiaLeg = 1/12;
    end    
end

