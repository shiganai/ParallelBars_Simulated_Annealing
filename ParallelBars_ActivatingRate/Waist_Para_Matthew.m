classdef Waist_Para_Matthew
    %HIP_PARA ���̃N���X�̊T�v�������ɋL�q
    %   �ڍא����������ɋL�q
    
    properties(Constant)
        % �_���f�[�^��
        % �p�x�̐��̕����͔����. 
        % Ext �͔���. 
        % Flex �͋��g�����. 
        
        % �V�~�����[�V�������邩��
        % Ext �͋��g
        % Flex �͔�����Ɏ��.
        
        tau_M_0_Ext = 157 % ��
        theta_A_0_Ext = 42
        theta_A_W_Ext = 70 % ��
        omega_Max_Ext = 526 % ��
        t_V_E_Max_Ext = 1.12
        t_V_C_Half_Ext = 0.25
        theta_PE_0_Ext = -5 % ��
        theta_PE_1_Ext = -30 % ��
        
        tau_M_0_Flex = -176 % �� �����l�Ɛ����t
        theta_A_0_Flex = 61 % �����l�Ɛ����t
        theta_A_W_Flex = 61 % ��
        omega_Max_Flex = -517 % �� �����l�Ɛ����t
        t_V_E_Max_Flex = 1.10
        t_V_C_Half_Flex = 0.16
        theta_PE_0_Flex = 45 % ��
        theta_PE_1_Flex = 90 % ��
    end
end

