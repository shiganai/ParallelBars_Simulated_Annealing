classdef InertiaModel_Yeadon
    %INERTIAMODEL_YEADON このクラスの概要をここに記述
    %   詳細説明をここに記述
    
    % Optimum technique for generating angular momentum in accelerated backward giant circles prior to a dismount
    properties(Constant)
        InertiaModel_Name = 'InertiaModel_Yeadon';
        mArm = 10.83;
        mBody = 35.47;
        mLeg = 21.500; % = 13.91 + 7.59;
        
        rArm = 0.537;
        rBody = 0.569;
        rLeg = 0.8727;% = 0.374*7/3;
        
        rArmMCD = 0.537 - 0.300;
        rBodyMCD = 0.226;
        rLegMCD = 0.3099; % = (13.91*0.151 + (0.374+0.227)*7.59) / (13.91+7.59);
        
        InertiaArm = 0.184;
        InertiaBody = 1.702;
        InertiaLeg = 1.5953; % = 13.91*(0.151 - 0.3099)^2 + 0.174 + 7.59*(0.374+0.277 - 0.3099)^2 + 0.187
    end    
end

