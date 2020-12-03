function outPara = load_partly_init_Mdatas(orgPara,filename, loadingNum)
%LOAD_INIT_MDATAS この関数の概要をここに記述
%   詳細説明をここに記述
load(filename)

outPara = orgPara;

outPara.init_ActivatingRate = (randi(2*Para.ActivatingRate_Step_num + 1,[Para.pop_num, Para.Joint_num, size(Para.Data_Set_Time, 1)]) - Para.ActivatingRate_Step_num - 1) / Para.ActivatingRate_Step_num;

% ii = 1:orgPara.pop_num;
ii = 1:loadingNum;

outPara.init_ActivatingRate(ii,:,:) = Para.ActivatingRate(mod(ii-1, Para.pop_num)+1,:,:);

outPara.ActivatingRate = outPara.init_ActivatingRate;

outPara.init_data_str = filename;
outPara.init_loadingNum = loadingNum;
end

