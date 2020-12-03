function Torque_Out = VoluntaryTorque(Joint_Para, theta_Target, omega_Target, activatingRatio)
%VOLUNTARYTORQUE この関数の概要をここに記述
%   詳細説明をここに記述

if (size(theta_Target(:),1) == 1 && size(omega_Target(:),1) == 1 && size(activatingRatio(:),1) == 1)
    if activatingRatio >= 0
        
        tau_M_0_Ext = Joint_Para.tau_M_0_Ext;
        theta_A_0_Ext = Joint_Para.theta_A_0_Ext;
        theta_A_W_Ext = Joint_Para.theta_A_W_Ext;
        
        t_A_Ext = exp(-(theta_Target-theta_A_0_Ext).^2/(2 * theta_A_W_Ext^2));
        
        if theta_Target <= 0
            c_Ext = -1e-3;
            
            theta_PE_0_Ext = Joint_Para.theta_PE_0_Ext;
            theta_PE_1_Ext = Joint_Para.theta_PE_1_Ext;
            
            a_PE_Ext = (log(-c_Ext)-log(1-c_Ext))/(theta_PE_0_Ext - theta_PE_1_Ext);
            b_PE_Ext = -theta_PE_1_Ext + log(1 - c_Ext)/a_PE_Ext;
            
            t_PE_Ext = exp(a_PE_Ext * (theta_Target + b_PE_Ext)) + c_Ext;
            t_PE = t_PE_Ext * tau_M_0_Ext;
        else
            tau_M_0_Flex = Joint_Para.tau_M_0_Flex;
            c_Flex = -1e-3;
            theta_PE_0_Flex = Joint_Para.theta_PE_0_Flex;
            theta_PE_1_Flex = Joint_Para.theta_PE_1_Flex;
            
            a_PE_Flex = (log(-c_Flex)-log(1 - c_Flex))/(theta_PE_0_Flex - theta_PE_1_Flex);
            b_PE_Flex = -theta_PE_1_Flex + log(1 - c_Flex)/a_PE_Flex;
            
            t_PE_Flex = exp(a_PE_Flex * (theta_Target + b_PE_Flex)) + c_Flex;
            t_PE = t_PE_Flex * tau_M_0_Flex;
        end
        
        omega_Max_Ext = Joint_Para.omega_Max_Ext;
        t_V_C_Half_Ext = Joint_Para.t_V_C_Half_Ext;
        omega_C_Ext = t_V_C_Half_Ext / (1 - 2 * t_V_C_Half_Ext) * omega_Max_Ext;
        if omega_Target >= 0
            T_C_Ext = tau_M_0_Ext * omega_C_Ext / omega_Max_Ext;
            C_Ext = T_C_Ext * (omega_Max_Ext + omega_C_Ext);
            t_V_Ext = (C_Ext ./ (omega_C_Ext + omega_Target) - T_C_Ext) / tau_M_0_Ext;
        else
            t_V_E_Max_Ext = Joint_Para.t_V_E_Max_Ext;
            k = 4.3;
            omega_E_Ext = (t_V_E_Max_Ext * tau_M_0_Ext - 1 * tau_M_0_Ext) /(k * 1 * tau_M_0_Ext) * (omega_Max_Ext * omega_C_Ext) / (omega_Max_Ext + omega_C_Ext);
            E_Ext = -(t_V_E_Max_Ext * tau_M_0_Ext - 1 * tau_M_0_Ext) * omega_E_Ext;
            t_V_Ext = (E_Ext ./ (omega_E_Ext - omega_Target) + t_V_E_Max_Ext * tau_M_0_Ext) / tau_M_0_Ext;
        end
        
        Torque_Out = tau_M_0_Ext * activatingRatio * t_A_Ext * t_V_Ext + t_PE;
    else
        
        tau_M_0_Flex = Joint_Para.tau_M_0_Flex;
        theta_A_0_Flex = Joint_Para.theta_A_0_Flex;
        theta_A_W_Flex = Joint_Para.theta_A_W_Flex;
        
        t_A_Flex = exp(-(theta_Target-theta_A_0_Flex).^2/(2 * theta_A_W_Flex^2));
        
        if theta_Target <= 0
            tau_M_0_Ext = Joint_Para.tau_M_0_Ext;
            c_Ext = -1e-3;
            
            theta_PE_0_Ext = Joint_Para.theta_PE_0_Ext;
            theta_PE_1_Ext = Joint_Para.theta_PE_1_Ext;
            
            a_PE_Ext = (log(-c_Ext)-log(1-c_Ext))/(theta_PE_0_Ext - theta_PE_1_Ext);
            b_PE_Ext = -theta_PE_1_Ext + log(1 - c_Ext)/a_PE_Ext;
            
            t_PE_Ext = exp(a_PE_Ext * (theta_Target + b_PE_Ext)) + c_Ext;
            t_PE = t_PE_Ext * tau_M_0_Ext;
        else
            c_Flex = -1e-3;
            theta_PE_0_Flex = Joint_Para.theta_PE_0_Flex;
            theta_PE_1_Flex = Joint_Para.theta_PE_1_Flex;
            
            a_PE_Flex = (log(-c_Flex)-log(1 - c_Flex))/(theta_PE_0_Flex - theta_PE_1_Flex);
            b_PE_Flex = -theta_PE_1_Flex + log(1 - c_Flex)/a_PE_Flex;
            
            t_PE_Flex = exp(a_PE_Flex * (theta_Target + b_PE_Flex)) + c_Flex;
            t_PE = t_PE_Flex * tau_M_0_Flex;
        end
        
        t_V_C_Half_Flex = Joint_Para.t_V_C_Half_Flex;
        omega_Max_Flex = Joint_Para.omega_Max_Flex;
        omega_C_Flex = t_V_C_Half_Flex / (1 - 2 * t_V_C_Half_Flex) * omega_Max_Flex;
        if omega_Target <= 0
            
            
            T_C_Flex = tau_M_0_Flex * omega_C_Flex / omega_Max_Flex;
            C_Flex = T_C_Flex * (omega_Max_Flex + omega_C_Flex);
            
            t_V_Flex = (C_Flex ./ (omega_C_Flex + omega_Target) - T_C_Flex) / tau_M_0_Flex;
        else
            t_V_E_Max_Flex = Joint_Para.t_V_E_Max_Flex;
            
            k = 4.3;
            omega_E_Flex = (t_V_E_Max_Flex * tau_M_0_Flex - 1 * tau_M_0_Flex) /(k * 1 * tau_M_0_Flex) * (omega_Max_Flex * omega_C_Flex) / (omega_Max_Flex + omega_C_Flex);
            E_Flex = -(t_V_E_Max_Flex * tau_M_0_Flex - 1 * tau_M_0_Flex) * omega_E_Flex;
            
            t_V_Flex = (E_Flex ./ (omega_E_Flex - omega_Target) + t_V_E_Max_Flex * tau_M_0_Flex) / tau_M_0_Flex;
        end
        
        Torque_Out = tau_M_0_Flex * (-activatingRatio) * t_A_Flex * t_V_Flex + t_PE;
    end
else
    
    %%
    
    tau_M_0_Ext = Joint_Para.tau_M_0_Ext;
    theta_A_0_Ext = Joint_Para.theta_A_0_Ext;
    theta_A_W_Ext = Joint_Para.theta_A_W_Ext;
    
    t_A_Ext = exp(-(theta_Target-theta_A_0_Ext).^2/(2 * theta_A_W_Ext^2));
    
    c_Ext = -1e-3;
    
    theta_PE_0_Ext = Joint_Para.theta_PE_0_Ext;
    theta_PE_1_Ext = Joint_Para.theta_PE_1_Ext;
    
    a_PE_Ext = (log(-c_Ext)-log(1-c_Ext))/(theta_PE_0_Ext - theta_PE_1_Ext);
    b_PE_Ext = -theta_PE_1_Ext + log(1 - c_Ext)/a_PE_Ext;
    
    t_PE_Ext = exp(a_PE_Ext * (theta_Target + b_PE_Ext)) + c_Ext;
    
    %%
    
    tau_M_0_Flex = Joint_Para.tau_M_0_Flex;
    theta_A_0_Flex = Joint_Para.theta_A_0_Flex;
    theta_A_W_Flex = Joint_Para.theta_A_W_Flex;
    
    t_A_Flex = exp(-(theta_Target-theta_A_0_Flex).^2/(2 * theta_A_W_Flex^2));
    
    c_Flex = -1e-3;
    
    theta_PE_0_Flex = Joint_Para.theta_PE_0_Flex;
    theta_PE_1_Flex = Joint_Para.theta_PE_1_Flex;
    
    a_PE_Flex = (log(-c_Flex)-log(1 - c_Flex))/(theta_PE_0_Flex - theta_PE_1_Flex);
    b_PE_Flex = -theta_PE_1_Flex + log(1 - c_Flex)/a_PE_Flex;
    
    t_PE_Flex = exp(a_PE_Flex * (theta_Target + b_PE_Flex)) + c_Flex;
    
    %%
    
    t_PE = t_PE_Ext * tau_M_0_Ext + t_PE_Flex * tau_M_0_Flex;
    
    %%
    
    omega_Max_Ext = Joint_Para.omega_Max_Ext;
    omega_Max_Flex = Joint_Para.omega_Max_Flex;
    t_V_C_Half_Ext = Joint_Para.t_V_C_Half_Ext;
    t_V_E_Max_Ext = Joint_Para.t_V_E_Max_Ext;
    
    omega_C_Ext_Hyperbola = (0 : 1 * omega_Max_Ext)';
    omega_E_Ext_Hyperbola = (1 * omega_Max_Flex : -1)';
    
    omega_C_Ext = t_V_C_Half_Ext / (1 - 2 * t_V_C_Half_Ext) * omega_Max_Ext;
    T_C_Ext = tau_M_0_Ext * omega_C_Ext / omega_Max_Ext;
    C_Ext = T_C_Ext * (omega_Max_Ext + omega_C_Ext);
    
    k = 4.3;
    omega_E_Ext = (t_V_E_Max_Ext * tau_M_0_Ext - 1 * tau_M_0_Ext) /(k * 1 * tau_M_0_Ext) * (omega_Max_Ext * omega_C_Ext) / (omega_Max_Ext + omega_C_Ext);
    E_Ext = -(t_V_E_Max_Ext * tau_M_0_Ext - 1 * tau_M_0_Ext) * omega_E_Ext;
    
    t_V_C_Ext_Hyperbola = (C_Ext ./ (omega_C_Ext + omega_C_Ext_Hyperbola) - T_C_Ext) / tau_M_0_Ext;
    t_V_E_Ext_Hyperbola = (E_Ext ./ (omega_E_Ext - omega_E_Ext_Hyperbola) + t_V_E_Max_Ext * tau_M_0_Ext) / tau_M_0_Ext;
    
    t_V_Ext_Spline = spline([omega_C_Ext_Hyperbola; omega_E_Ext_Hyperbola], [t_V_C_Ext_Hyperbola; t_V_E_Ext_Hyperbola]);
    t_V_Ext = fnval(t_V_Ext_Spline, omega_Target);
    
    %%
    
    omega_Max_Flex = Joint_Para.omega_Max_Flex;
    t_V_C_Half_Flex = Joint_Para.t_V_C_Half_Flex;
    t_V_E_Max_Flex = Joint_Para.t_V_E_Max_Flex;
    
    omega_C_Flex_Hyperbola = (1 * omega_Max_Flex : 0)';
    omega_E_Flex_Hyperbola = (1 : 1 * omega_Max_Ext)';
    
    omega_C_Flex = t_V_C_Half_Flex / (1 - 2 * t_V_C_Half_Flex) * omega_Max_Flex;
    T_C_Flex = tau_M_0_Flex * omega_C_Flex / omega_Max_Flex;
    C_Flex = T_C_Flex * (omega_Max_Flex + omega_C_Flex);
    
    k = 4.3;
    omega_E_Flex = (t_V_E_Max_Flex * tau_M_0_Flex - 1 * tau_M_0_Flex) /(k * 1 * tau_M_0_Flex) * (omega_Max_Flex * omega_C_Flex) / (omega_Max_Flex + omega_C_Flex);
    E_Flex = -(t_V_E_Max_Flex * tau_M_0_Flex - 1 * tau_M_0_Flex) * omega_E_Flex;
    
    t_V_C_Flex_Hyperbola = (C_Flex ./ (omega_C_Flex + omega_C_Flex_Hyperbola) - T_C_Flex) / tau_M_0_Flex;
    t_V_E_Flex_Hyperbola = (E_Flex ./ (omega_E_Flex - omega_E_Flex_Hyperbola) + t_V_E_Max_Flex * tau_M_0_Flex) / tau_M_0_Flex;
    
    t_V_Flex_Spline = spline([omega_C_Flex_Hyperbola; omega_E_Flex_Hyperbola], [t_V_C_Flex_Hyperbola; t_V_E_Flex_Hyperbola]);
    t_V_Flex = fnval(t_V_Flex_Spline, omega_Target);
    
    %%
    if activatingRatio >= 0
        Torque_Out = tau_M_0_Ext .* activatingRatio .* t_A_Ext .* t_V_Ext + t_PE;
    else
        Torque_Out = tau_M_0_Flex .* (-activatingRatio) .* t_A_Flex .* t_V_Flex + t_PE;
    end
end

end

