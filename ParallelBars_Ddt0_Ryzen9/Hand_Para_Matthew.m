classdef Hand_Para_Matthew
    %HIP_PARA このクラスの概要をここに記述
    %   詳細説明をここに記述
    
    properties(Constant)
        % Ulnar は肩を後ろに倒す方
        % Radal は肩を前に出す方.
        % Unlar を Ext に取れば + 側が肩を外す動きで同期する. 
        
        % 文献だと Ext : Radal, Flex : Ulnarでとっている
        % Ext : Ulnar
        % Flex : Radial
        
        tau_M_0_Ext = 31 % 正
        theta_A_0_Ext = 25
        theta_A_W_Ext = 85 % 正
        omega_Max_Ext = 1032 % 正
        t_V_E_Max_Ext = 1.35
        t_V_C_Half_Ext = 0.20
        theta_PE_0_Ext = 0 % 負
        theta_PE_1_Ext = -30 % 負
%         theta_PE_0_Ext = -45 % 負
%         theta_PE_1_Ext = -45 % 負
        
        tau_M_0_Flex = -24 % 負
        theta_A_0_Flex = -65 
        theta_A_W_Flex = 147 % 正
        omega_Max_Flex = -1247 % 負
        t_V_E_Max_Flex = 1.31
        t_V_C_Half_Flex = 0.21
        theta_PE_0_Flex = 20 % 正
        theta_PE_1_Flex = 50 % 正
%         theta_PE_0_Flex = 45 % 正
%         theta_PE_1_Flex = 90 % 正
    end
end

