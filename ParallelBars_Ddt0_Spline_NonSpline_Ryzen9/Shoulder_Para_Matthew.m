classdef Shoulder_Para_Matthew
    %HIP_PARA ���̃N���X�̊T�v�������ɋL�q
    %   �ڍא����������ɋL�q
    
    properties(Constant)
        % �p�x�̐��̕����͕����. 
        % �p�x�͓|����Ԃ� 0 �ɂȂ�悤�ɕ␳����
        
        % Ext �͌�������. 
        % Flex �͌����J����. 
        
        tau_M_0_Ext = 127 % ��
        theta_A_0_Ext = -123 + 180
        theta_A_W_Ext = 105 % ��
        omega_Max_Ext = 931 % ��
        t_V_E_Max_Ext = 1.10
        t_V_C_Half_Ext = 0.25
        theta_PE_0_Ext = -162 + 180 % ��
        theta_PE_1_Ext = -204 + 180 % ��
        
        tau_M_0_Flex = -91 % ��
        theta_A_0_Flex = -51 + 180
        theta_A_W_Flex = 74 % ��
        omega_Max_Flex = -1093 % ��
        t_V_E_Max_Flex = 1.23
        t_V_C_Half_Flex = 0.25
        theta_PE_0_Flex = 30 + 180 % ��
        theta_PE_1_Flex = 60 + 180 % ��
    end
end

