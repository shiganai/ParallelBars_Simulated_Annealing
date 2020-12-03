function [outCurve, doutCurve, ddoutCurve] = GetSmoothingDerivates(orgData, orgCurve, outData)
%AUTOSMOOTHINGSPLINE ���̊֐��̊T�v�������ɋL�q
%   �ڍא����������ɋL�q
f = fit(orgData, orgCurve, "smoothingspline");
outCurve = f(outData);
if nargout >= 2
    dpp = fnder(f.p);
    doutCurve = ppval(dpp, outData);
    if nargout >= 3
        ddpp = fnder(dpp);
        ddoutCurve = ppval(ddpp, outData);
    end
end
end

