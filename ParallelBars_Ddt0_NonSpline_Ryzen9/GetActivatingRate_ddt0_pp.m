function dthTH_pp = GetActivatingRate_ddt0_pp(Data_Set_Time, ActivatingRate)
%GETANGTH_PP ���̊֐��̊T�v�������ɋL�q
%   �ڍא����������ɋL�q
Step_Time = diff(Data_Set_Time(1:2));

time_ExtreamPoint = [Data_Set_Time', Data_Set_Time' + Step_Time * 0.4, Data_Set_Time' + Step_Time * 0.5];
time_ExtreamPoint = time_ExtreamPoint(:);

ActivatingRate = ActivatingRate(:);

ActivatingRate_ExtreamPoint = [ActivatingRate', ActivatingRate', ActivatingRate'];
ActivatingRate_ExtreamPoint = ActivatingRate_ExtreamPoint(:);

time_ExtreamPoint = [time_ExtreamPoint; 1e-3 + time_ExtreamPoint];
ActivatingRate_ExtreamPoint = [ActivatingRate_ExtreamPoint; ActivatingRate_ExtreamPoint];

time_ExtreamPoint = time_ExtreamPoint(:);
ActivatingRate_ExtreamPoint = ActivatingRate_ExtreamPoint(:);

dthTH_pp = spline(time_ExtreamPoint, ActivatingRate_ExtreamPoint);
end

