function saveMidtermPara2(Para,ii, Mdatas, objectiveValues)
%SAVEPARA ���̊֐��̊T�v�������ɋL�q
%   �ڍא����������ɋL�q
% formatOut = 'mmddHHMMss';
% dateString = datestr(now,formatOut)

Para.gen_num = ii;
Para.res_Mdatas = Mdatas;
Para.res_objectiveValues = objectiveValues;

save('MidtermPara2.mat','Para')

% saveas(gca, 'MidtermResult2.fig')

% strcat('MidtermPara_',dateString,...
%     '_pop_', num2str(Para.pop_num),...
%     '_gen_', num2str(Para.gen_num))
% 
% save(strcat('MidtermPara_',dateString,...
%     '_pop_', num2str(Para.pop_num),...
%     '_gen_', num2str(Para.gen_num),'.mat'),'Para')
% 
% saveas(gca, strcat('MidtermResult_',dateString,...
%     '_pop_', num2str(Para.pop_num),...
%     '_gen_', num2str(Para.gen_num),'.fig'))
end