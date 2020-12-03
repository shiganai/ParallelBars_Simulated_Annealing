classdef Hand_Para_Matthew
    %HIP_PARA ���̃N���X�̊T�v�������ɋL�q
    %   �ڍא����������ɋL�q
    
    properties(Constant)
        % Ulnar �͌������ɓ|����
        % Radal �͌���O�ɏo����.
        % Unlar �� Ext �Ɏ��� + ���������O�������œ�������. 
        
        % �������� Ext : Radal, Flex : Ulnar�łƂ��Ă���
        % Ext : Ulnar
        % Flex : Radial
        
        tau_M_0_Ext = 31 % ��
        theta_A_0_Ext = 25
        theta_A_W_Ext = 85 % ��
        omega_Max_Ext = 1032 % ��
        t_V_E_Max_Ext = 1.35
        t_V_C_Half_Ext = 0.20
        theta_PE_0_Ext = 0 % ��
        theta_PE_1_Ext = -30 % ��
%         theta_PE_0_Ext = -45 % ��
%         theta_PE_1_Ext = -45 % ��
        
        tau_M_0_Flex = -24 % ��
        theta_A_0_Flex = -65 
        theta_A_W_Flex = 147 % ��
        omega_Max_Flex = -1247 % ��
        t_V_E_Max_Flex = 1.31
        t_V_C_Half_Flex = 0.21
        theta_PE_0_Flex = 20 % ��
        theta_PE_1_Flex = 50 % ��
%         theta_PE_0_Flex = 45 % ��
%         theta_PE_1_Flex = 90 % ��
    end
end

