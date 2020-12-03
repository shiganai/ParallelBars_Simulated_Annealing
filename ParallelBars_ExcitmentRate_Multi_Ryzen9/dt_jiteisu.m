function dotq = dt_jiteisu(time, q, tau, ExcitingRate_Spline)
%DDT この関数の概要をここに記述
%   詳細説明をここに記述
dotq = 1/tau * (fnval(ExcitingRate_Spline, time) - q);
end

