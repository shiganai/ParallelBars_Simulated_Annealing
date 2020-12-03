load('MidtermPara.mat')

formatOut = 'mmddHHMMss';
dateString = datestr(now,formatOut);

strcat('Para_',dateString,...
    '_pop_', num2str(Para.pop_num),...
    '_gen_', num2str(Para.gen_num))

save(strcat('Para_',dateString,...c
    '_pop_', num2str(Para.pop_num),...
    '_gen_', num2str(Para.gen_num),'.mat'),'Para')

% movefile("MidtermResult.png", strcat(strcat('Para_',dateString, '_pop_', num2str(Para.pop_num), '_gen_', num2str(Para.gen_num),'.png')));

















