function outPara = reset_Para(Para)
%LOAD_INIT_MDATAS この関数の概要をここに記述
%   詳細説明をここに記述

%{
outPara = Para;

outPara.dthData = (randi(Para.step_num + 1, [size(Para.dataTime,1), Para.muscle_num, Para.pop_num]) - 1) /Para.step_num;

for ii = 1:Para.muscle_num
    outPara.dthData(:,ii,:) = outPara.init_dthData(:,ii,:) * diff(Para.OmegaLimit(ii,:)) + Para.OmegaLimit(ii,1);
end
outPara.dthData(:, :, 1:Para.save_pop_num) = Para.dthData(:,:, 1:Para.save_pop_num);
outPara.ObjectiveValueDatas(1:Para.save_pop_num,:) = Para.ObjectiveValueDatas(1:Para.save_pop_num,:);
%}

outPara = Para;


outPara.ActivatingRate = (randi(2*Para.ActivatingRate_Step_num + 1,[Para.pop_num, Para.Joint_num, size(Para.Data_Set_Time, 1)]) - Para.ActivatingRate_Step_num - 1) / Para.ActivatingRate_Step_num;

outPara.ObjectiveValueDatas = Para.ObjectiveValueDatas + NaN;


outPara.ActivatingRate(:,:,:,1:Para.not_reset_pop_num) = Para.ActivatingRate(:,:,:,1:Para.not_reset_pop_num);
outPara.ObjectiveValueDatas(1:Para.not_reset_pop_num,:) = Para.ObjectiveValueDatas(1:Para.not_reset_pop_num,:);


fprintf("-----------------------------------------reset-----------------------------------------\n")
end