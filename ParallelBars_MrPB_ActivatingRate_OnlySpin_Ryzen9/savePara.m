function savePara(Para)
%SAVEPARA ���̊֐��̊T�v�������ɋL�q
%   �ڍא����������ɋL�q
formatOut = 'mmddHHMMss';
dateString = datestr(now,formatOut);

Para.init_ActivatingRate = Para.init_ActivatingRate(1:Para.save_pop_num,:,:);
Para.init_ObjectiveValueDatas = Para.init_ObjectiveValueDatas(1:Para.save_pop_num,:);

Para.ActivatingRate = Para.ActivatingRate(1:Para.save_pop_num,:,:);
Para.ObjectiveValueDatas = Para.ObjectiveValueDatas(1:Para.save_pop_num,:);

strcat('Para_',dateString,...
    '_pop_', num2str(Para.pop_num),...
    '_gen_', num2str(Para.gen_num))

save(strcat('Para_',dateString,...
    '_pop_', num2str(Para.pop_num),...
    '_gen_', num2str(Para.gen_num),'.mat'),'Para')

saveas(gca, strcat('Para_',dateString,...
    '_pop_', num2str(Para.pop_num),...
    '_gen_', num2str(Para.gen_num),'.png'))
end

