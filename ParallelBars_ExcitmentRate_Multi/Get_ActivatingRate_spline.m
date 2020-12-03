function [ActivatingRate_Spline, ExcitmentRate_Spline] = Get_ActivatingRate_spline(Data_Time, ExcitmentRate, ode_time, tau)
%GET_ACTIVATINGRATE ���̊֐��̊T�v�������ɋL�q
%   �ڍא����������ɋL�q

ExcitmentRate_before = spline(Data_Time, ExcitmentRate, ode_time);
ExcitmentRate_before(ExcitmentRate_before > 1) = 1;
ExcitmentRate_before(ExcitmentRate_before < -1) = -1;
ExcitmentRate_Spline = spline(ode_time, ExcitmentRate_before);

q0 = ExcitmentRate(1);

ode_fcn = @(time, q) dt_jiteisu(time, q, tau, ExcitmentRate_Spline);

[time, q] = ode45(ode_fcn, ode_time, q0);

ActivatingRate_Spline = spline(time, q);

end

