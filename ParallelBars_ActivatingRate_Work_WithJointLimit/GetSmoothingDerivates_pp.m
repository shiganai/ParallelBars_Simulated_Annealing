function [outpp, outdpp, outddpp] = GetSmoothingDerivates_pp(data, orgCurve)
%AUTOSMOOTHINGSPLINE ���̊֐��̊T�v�������ɋL�q
%   �ڍא����������ɋL�q
f = fit(data, orgCurve, "smoothingspline");
outpp = f.p;
if nargout >= 2
    outdpp = fnder(f.p);
    if nargout >= 3
        outddpp = fnder(outdpp);
    end
end
end

