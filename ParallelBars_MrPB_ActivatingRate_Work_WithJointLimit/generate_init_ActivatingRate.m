function outPara = generate_init_ActivatingRate(Para)

outPara = Para;

outPara.init_ActivatingRate = (randi(2*Para.ActivatingRate_Step_num + 1,[Para.pop_num, Para.Joint_num, size(Para.Data_Set_Time, 1)]) - Para.ActivatingRate_Step_num - 1) / Para.ActivatingRate_Step_num;

outPara.ActivatingRate = outPara.init_ActivatingRate;

outPara.init_data_str = 'None';
end

























