function outPara = generate_init_ExcitmentRate(Para)

outPara = Para;

outPara.init_ExcitmentRate = (randi(2*Para.ExcitmentRate_Step_num + 1,[Para.pop_num, Para.Joint_num, size(Para.Data_Set_Time, 1)]) - Para.ExcitmentRate_Step_num - 1) / Para.ExcitmentRate_Step_num;

outPara.ExcitmentRate = outPara.init_ExcitmentRate;

outPara.init_data_str = 'None';
end

























