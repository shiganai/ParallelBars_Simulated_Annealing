function [outCurve, doutCurve, ddoutCurve] = GetSmoothingDerivates(orgData, orgCurve, outData)
%AUTOSMOOTHINGSPLINE この関数の概要をここに記述
%   詳細説明をここに記述
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

