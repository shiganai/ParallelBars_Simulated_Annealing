function dthTH_pp = GetdthTH_pp(ExtreamPoint)
%GETANGTH_PP この関数の概要をここに記述
%   詳細説明をここに記述
time_ExtreamPoint = ExtreamPoint(:,1)';
theta_ExtreamPoint = ExtreamPoint(:,2)';

time_ExtreamPoint = [time_ExtreamPoint; 1e-3 + time_ExtreamPoint];
theta_ExtreamPoint = [theta_ExtreamPoint; theta_ExtreamPoint];

time_ExtreamPoint = time_ExtreamPoint(:);
theta_ExtreamPoint = theta_ExtreamPoint(:);

dthTH_pp = spline(time_ExtreamPoint, theta_ExtreamPoint);
end

