classdef Shoulder_Para_Matthew
    %HIP_PARA このクラスの概要をここに記述
    %   詳細説明をここに記述
    
    properties(Constant)
        % 角度の正の方向は閉じる方. 
        % 角度は倒立状態が 0 になるように補正した
        
        % Ext は肩を閉じる方. 
        % Flex は肩を開く方. 
        
        tau_M_0_Ext = 127 % 正
        theta_A_0_Ext = -123 + 180
        theta_A_W_Ext = 105 % 正
        omega_Max_Ext = 931 % 正
        t_V_E_Max_Ext = 1.10
        t_V_C_Half_Ext = 0.25
        theta_PE_0_Ext = -162 + 180 % 負
        theta_PE_1_Ext = -204 + 180 % 負
        
        tau_M_0_Flex = -91 % 負
        theta_A_0_Flex = -51 + 180
        theta_A_W_Flex = 74 % 正
        omega_Max_Flex = -1093 % 負
        t_V_E_Max_Flex = 1.23
        t_V_C_Half_Flex = 0.25
        theta_PE_0_Flex = 30 + 180 % 正
        theta_PE_1_Flex = 60 + 180 % 正
    end
end

