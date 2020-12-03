classdef Waist_Para_Matthew
    %HIP_PARA このクラスの概要をここに記述
    %   詳細説明をここに記述
    
    properties(Constant)
        % 論文データは
        % 角度の正の方向は反る方. 
        % Ext は反る. 
        % Flex は屈身する方. 
        
        % シミュレーションするから
        % Ext は屈身
        % Flex は反る方に取る.
        
        tau_M_0_Ext = 157 % 正
        theta_A_0_Ext = 42
        theta_A_W_Ext = 70 % 正
        omega_Max_Ext = 526 % 正
        t_V_E_Max_Ext = 1.12
        t_V_C_Half_Ext = 0.25
        theta_PE_0_Ext = -5 % 負
        theta_PE_1_Ext = -30 % 負
        
        tau_M_0_Flex = -176 % 負 文献値と正負逆
        theta_A_0_Flex = 61 % 文献値と正負逆
        theta_A_W_Flex = 61 % 正
        omega_Max_Flex = -517 % 負 文献値と正負逆
        t_V_E_Max_Flex = 1.10
        t_V_C_Half_Flex = 0.16
        theta_PE_0_Flex = 45 % 正
        theta_PE_1_Flex = 90 % 正
    end
end

