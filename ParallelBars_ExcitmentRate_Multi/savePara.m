function savePara(Para)
%SAVEPARA この関数の概要をここに記述
%   詳細説明をここに記述

formatOut = 'dd/HH:MM:ss';
dateString = datestr(now,formatOut);
Para.Save_Date_String = dateString;

formatOut = 'mmddHHMMss';
dateString = datestr(now,formatOut);
Para.Save_Date_String_FileName = dateString;

Para.init_ExcitmentRate = Para.init_ExcitmentRate(1:Para.save_pop_num,:,:);
Para.init_ObjectiveValueDatas = Para.init_ObjectiveValueDatas(1:Para.save_pop_num,:);

Para.ExcitmentRate = Para.ExcitmentRate(1:Para.save_pop_num,:,:);
Para.ObjectiveValueDatas = Para.ObjectiveValueDatas(1:Para.save_pop_num,:);

strcat('Para_',dateString,...
    '_pop_', num2str(Para.pop_num),...
    '_gen_', num2str(Para.gen_num))

save(strcat('Para_',dateString,...
    '_pop_', num2str(Para.pop_num),...
    '_gen_', num2str(Para.gen_num),'.mat'),'Para')

% saveas(gca, strcat('Para_',dateString,...
%     '_pop_', num2str(Para.pop_num),...
%     '_gen_', num2str(Para.gen_num),'.png'))
end

