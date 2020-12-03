function theta = GetThetaFromXY(pBackward,pForward)
%AJUSTATAN2 この関数の概要をここに記述
%   詳細説明をここに記述

x = pForward(:,1) - pBackward(:,1);
y = pForward(:,2) - pBackward(:,2);


theta_tmp = atan2(y,x);

diff_theta_tmp = diff(theta_tmp);
cliff_index = find(abs(diff_theta_tmp)>pi);

for ii = 1:length(cliff_index)
    if diff_theta_tmp(cliff_index(ii,1)) > pi
        theta_tmp = [theta_tmp(1:cliff_index(ii,1),1); theta_tmp(cliff_index(ii,1) + 1:end,1) - 2*pi];
    else
        theta_tmp = [theta_tmp(1:cliff_index(ii,1),1); theta_tmp(cliff_index(ii,1) + 1:end,1) + 2*pi];
    end
end

% while numel(find(abs(diff(theta_tmp))>pi)) > 0
%     diff_theta_tmp = diff(theta_tmp);
%     cliff_index = find(abs(diff_theta_tmp)>pi);
%     
%     if diff_thetta_tmp(cliff_index(1,1)) > pi
%         theta_tmp = [theta_tmp(1:cliff_index(1,1),1); theta_tmp(cliff_index(1,1) + 1:end,1) - 2*pi];
%     else
%         theta_tmp = [theta_tmp(1:cliff_index(1,1),1); theta_tmp(cliff_index(1,1) + 1:end,1) -+2*pi];
%     end
% end

theta = theta_tmp;
end

