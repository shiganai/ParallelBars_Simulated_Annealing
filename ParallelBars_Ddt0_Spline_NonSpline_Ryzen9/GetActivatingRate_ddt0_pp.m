function dthTH_pp = GetActivatingRate_ddt0_pp(Data_Set_Time, ActivatingRate)
%GETANGTH_PP この関数の概要をここに記述
%   詳細説明をここに記述
Step_Time = diff(Data_Set_Time(1:2));

time_for_spline = Data_Set_Time' + (0:1e-2:1)' .* Step_Time * 0.99;

ActivatingRate = ActivatingRate(:);
ActivatingRate_for_spline = ones(size(time_for_spline)) .* ActivatingRate';

time_for_spline = time_for_spline(:);
ActivatingRate_for_spline = ActivatingRate_for_spline(:);

dthTH_pp = spline(time_for_spline, ActivatingRate_for_spline);
end

