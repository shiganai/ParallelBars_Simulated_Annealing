function saveMidtermPara(Para,ii)
%SAVEPARA ���̊֐��̊T�v�������ɋL�q
%   �ڍא����������ɋL�q

formatOut = 'dd/HH:MM:ss';
dateString = datestr(now,formatOut);
Para.Save_Date_String = dateString;

formatOut = 'mmddHHMMss';
dateString = datestr(now,formatOut);
Para.Save_Date_String_FileName = dateString;

Para.gen_num = ii;
Para.init_ActivatingRate = Para.init_ActivatingRate(1:Para.save_pop_num,:,:);
Para.init_ObjectiveValueDatas = Para.init_ObjectiveValueDatas(1:Para.save_pop_num,:);

Para.ActivatingRate = Para.ActivatingRate(1:Para.save_pop_num,:,:);
Para.ObjectiveValueDatas = Para.ObjectiveValueDatas(1:Para.save_pop_num,:);

save('MidtermPara.mat','Para')

% saveas(gca, 'MidtermResult.png')
end