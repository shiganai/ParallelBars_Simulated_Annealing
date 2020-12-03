classdef constants_Yeadon_Less_WaistCounter
    %CONSTANTS このクラスの概要をここに記述
    %   詳細説明をここに記述
    
    %{
    properties(Constant)
        
        constants_Name = 'constants_Yeadon'
        g = 9.8
        kPB = 1.9831 * 1e4
        cPB = 4.1
        mAll = 80
        mPB = 2
        
        mArm = 10.83
        mBody = 35.47
        mLeg = 13.91 + 7.59
        
        rArm = 0.537;
        rBody = 0.569;
        rLeg = 0.8727;% = 0.374*7/3;
        
%         InertiaModel = InertiaModel_CompleteSticks;
        InertiaModel = struct(InertiaModel_Yeadon);
        
        rArmMCD = constants_HH.rArm / constants_HH.InertiaModel.rArm * constants_HH.InertiaModel.rArmMCD;
        rBodyMCD = constants_HH.rBody / constants_HH.InertiaModel.rBody * constants_HH.InertiaModel.rBodyMCD;
        rLegMCD = constants_HH.rLeg / constants_HH.InertiaModel.rLeg * constants_HH.InertiaModel.rLegMCD;
        
        InertiaArm = constants_HH.mArm / constants_HH.InertiaModel.mArm * (constants_HH.rArm / constants_HH.InertiaModel.rArm)^2 * constants_HH.InertiaModel.InertiaArm;
        InertiaBody = constants_HH.mBody / constants_HH.InertiaModel.mBody * (constants_HH.rBody / constants_HH.InertiaModel.rBody)^2 * constants_HH.InertiaModel.InertiaBody;
        InertiaLeg = constants_HH.mLeg / constants_HH.InertiaModel.mLeg * (constants_HH.rLeg / constants_HH.InertiaModel.rLeg)^2 * constants_HH.InertiaModel.InertiaLeg;
        
        InertiaG =  find_InertiaG(constants_HH.InertiaLeg,constants_HH.InertiaArm,constants_HH.InertiaBody,...
            constants_HH.mArm,constants_HH.mBody,constants_HH.mLeg,...
            constants_HH.rArm,constants_HH.rArmMCD,constants_HH.rBody,constants_HH.rBodyMCD,constants_HH.rLegMCD,...
            pi, 0)
        
        Hand_Para = struct(Hand_Para_Matthew);
        Shoulder_Para = struct(Shoulder_Para_Matthew);
        Waist_Para = struct(Waist_Para_Matthew);
    end
    %}
    
    properties
        constants_Name
        g
        kPB
        cPB
        mAll
        mPB
        rAll
        
        mArm
        mBody
        mLeg
        
        rArm
        rBody
        rLeg
        
        %         InertiaModel = InertiaModel_CompleteSticks;
        InertiaModel
        
        rArmMCD
        rBodyMCD
        rLegMCD
        
        InertiaArm
        InertiaBody
        InertiaLeg
        
        InertiaG
        
        Hand_Para
        Shoulder_Para
        Waist_Para
    end
    
    methods
        function obj = constants_Yeadon_Less_WaistCounter
            
            obj.constants_Name = 'constants_Yeadon_Less_WaistCounter';
            obj.g = 9.8;
            obj.kPB = 1.9831 * 1e4;
            obj.cPB = 4.1;
            obj.mAll = 80;
            obj.mPB = 2;
            obj.rAll = 1.81;
            
            obj.mArm = 10.83;
            obj.mBody = 35.47;
            obj.mLeg = 13.91 + 7.59;
            
            obj.rArm = 0.537;
            obj.rBody = 0.569;
            obj.rLeg = 0.374 * 7/3;
            
            %         obj.InertiaModel = InertiaModel_CompleteSticks;
            obj.InertiaModel = struct(InertiaModel_Yeadon);
            
            obj.rArmMCD = obj.rArm / obj.InertiaModel.rArm * obj.InertiaModel.rArmMCD;
            obj.rBodyMCD = obj.rBody / obj.InertiaModel.rBody * obj.InertiaModel.rBodyMCD;
            obj.rLegMCD = obj.rLeg / obj.InertiaModel.rLeg * obj.InertiaModel.rLegMCD;
            
            obj.InertiaArm = obj.mArm / obj.InertiaModel.mArm * (obj.rArm / obj.InertiaModel.rArm)^2 * obj.InertiaModel.InertiaArm;
            obj.InertiaBody = obj.mBody / obj.InertiaModel.mBody * (obj.rBody / obj.InertiaModel.rBody)^2 * obj.InertiaModel.InertiaBody;
            obj.InertiaLeg = obj.mLeg / obj.InertiaModel.mLeg * (obj.rLeg / obj.InertiaModel.rLeg)^2 * obj.InertiaModel.InertiaLeg;
            
            obj.InertiaG =  find_InertiaG(obj.InertiaLeg,obj.InertiaArm,obj.InertiaBody,...
                obj.mArm,obj.mBody,obj.mLeg,...
                obj.rArm,obj.rArmMCD,obj.rBody,obj.rBodyMCD,obj.rLegMCD,...
                pi, 0);
            
            obj.Hand_Para = struct(Hand_Para_Matthew);
            obj.Shoulder_Para = struct(Shoulder_Para_Matthew);
            obj.Waist_Para = struct(Waist_Para_Matthew_Less_CounterMove);
        end
    end
end

