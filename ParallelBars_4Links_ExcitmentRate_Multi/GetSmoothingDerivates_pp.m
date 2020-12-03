function [outpp, outdpp, outddpp] = GetSmoothingDerivates_pp(data, orgCurve)
%AUTOSMOOTHINGSPLINE この関数の概要をここに記述
%   詳細説明をここに記述
f = fit(data, orgCurve, "smoothingspline");
outpp = f.p;
if nargout >= 2
    outdpp = fnder(f.p);
    if nargout >= 3
        outddpp = fnder(outdpp);
    end
end
end

