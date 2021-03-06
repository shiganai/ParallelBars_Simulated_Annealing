function outPara = load_and_fit_init_Mdatas(orgPara,filename, loadingNum)
%LOAD_INIT_MDATAS この関数の概要をここに記述
%   詳細説明をここに記述
load(filename)

outPara = orgPara;

outPara.init_ActivatingRate = (randi(2*outPara.ActivatingRate_Step_num + 1,[outPara.pop_num, outPara.Joint_num, size(outPara.Data_Set_Time, 1)]) - outPara.ActivatingRate_Step_num - 1) / outPara.ActivatingRate_Step_num;

% ii = 1:orgPara.pop_num;
ii = 1:loadingNum;

outPara.init_ActivatingRate(ii,:,:) = Para.ActivatingRate(mod(ii-1, Para.pop_num)+1,:,:);

outPara.ActivatingRate = outPara.init_ActivatingRate;

outPara.init_data_str = filename;
outPara.init_loadingNum = loadingNum;
end

