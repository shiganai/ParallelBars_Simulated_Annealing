function dotq = dt_jiteisu(time, q, tau, ExcitingRate_Spline)
%DDT ���̊֐��̊T�v�������ɋL�q
%   �ڍא����������ɋL�q
dotq = 1/tau * (fnval(ExcitingRate_Spline, time) - q);
end

