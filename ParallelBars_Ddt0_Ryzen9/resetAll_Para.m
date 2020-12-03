function outPara = reset_Para(Para)
%LOAD_INIT_MDATAS この関数の概要をここに記述
%   詳細説明をここに記述

outPara = Para;

outPara.ExtreamPoint_num = randi(Para.ExtreamPoint_num_max - 1,[Para.pop_num, Para.Joint_num]) + 1;

outPara.ExtreamPoint = zeros([Para.ExtreamPoint_num_max, 2, Para.Joint_num, Para.pop_num]);

for ii = 1:Para.pop_num
    for jj = 1:Para.Joint_num
        outPara.ExtreamPoint(:,:,jj,ii) = ...
            [0, Para.q0(jj+5,1);
            (randperm(Para.Time_step_num, Para.ExtreamPoint_num_max-1)')/Para.Time_step_num * Para.Time_Limit,...
            (randi(2*Para.Omega_step_num+1,[Para.ExtreamPoint_num_max-1,1]) - Para.Omega_step_num - 1)/Para.Omega_step_num * Para.Omega_max(jj,1)];
        
        outPara.ExtreamPoint(1:outPara.ExtreamPoint_num(ii,jj), : , jj, ii)...
            = sortrows(outPara.ExtreamPoint(1:outPara.ExtreamPoint_num(ii,jj), : , jj, ii), 1);
        
        outPara.ExtreamPoint(outPara.ExtreamPoint_num(ii,jj)+1 : end, :, jj, ii)...
            = [zeros(outPara.ExtreamPoint_num_max - outPara.ExtreamPoint_num(ii,jj),1) + Para.Time_Limit + 10,...
            zeros(size(outPara.ExtreamPoint(outPara.ExtreamPoint_num(ii,jj)+1 : end, :, jj, ii),1),1)];
    end
end

% outPara.ExtreamPoint(:,:,:,1:Para.save_pop_num) = Para.ExtreamPoint(:,:,:,1:Para.save_pop_num);
% outPara.ExtreamPoint_num(1:Para.save_pop_num, :) = Para.ExtreamPoint_num(1:Para.save_pop_num, :);
% outPara.ObjectiveValueDatas(1:Para.save_pop_num,:) = Para.ObjectiveValueDatas(1:Para.save_pop_num,:);

fprintf("-----------------------------------------resetAll-----------------------------------------\n")
end