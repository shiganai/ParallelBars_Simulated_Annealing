function Value = EvaluateValue(Center, Width, Data)
%EVALUATEVALUE ���̊֐��̊T�v�������ɋL�q
%   �ڍא����������ɋL�q

if Width <= 0
    error("Width�����ł�Value����`�ł��܂���")
end

Value = zeros(size(Data));

x_sp = [Center - Width, Center - Width*2/3, Center - Width*1/3, Center, Center + Width*1/3, Center + Width*2/3, Center + Width];
y_sp = [0, 0.0230, 0.1585 0.5, 0.8415, 0.9770, 1];
sp = spline(x_sp, [0, y_sp, 0]);

for ii = 1:length(Data(:))
if Data(ii) <= Center - Width
    Value(ii) = 0;
elseif Data(ii) >= Center + Width
    Value(ii) = 1;
else
    
    Value(ii) = fnval(sp, Data(ii));
end
end

