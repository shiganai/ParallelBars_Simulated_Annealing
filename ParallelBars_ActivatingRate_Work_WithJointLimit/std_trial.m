
% gen_num_tmp = 3390;
gen_num_tmp = Para.gen_num;

Count_Memory = Para.Count_Memory(1:gen_num_tmp,:);

N = 300;

Mean_Array = zeros([gen_num_tmp-(N-1), 1]);
Std_Array = zeros([gen_num_tmp-(N-1), 1]);
for ii_std_trial = 1:gen_num_tmp-(N-1)
    Mean_Array(ii_std_trial,1) = mean(Count_Memory(ii_std_trial:ii_std_trial+(N-1),1));
    Std_Array(ii_std_trial,1) = std(Count_Memory(ii_std_trial:ii_std_trial+(N-1),1));
end

Mean_Std_Array = zeros([gen_num_tmp-((2*N-1)-1), 1]);
for jj_std_trial = 1:gen_num_tmp-((2*N-1)-1)
    Mean_Std_Array(jj_std_trial,1) = std(Mean_Array(jj_std_trial:jj_std_trial+(N-1),1));
end

figure(1)
PL = plot(N:gen_num_tmp, [Mean_Array, Std_Array], 2*N-1:gen_num_tmp, Mean_Std_Array, 'black');
line([Para.Gained_gen_Memory'; Para.Gained_gen_Memory'],  [zeros([1, size(Para.Gained_gen_Memory,1)]); zeros([1, size(Para.Gained_gen_Memory,1)]) + 200], 'Color', 'red', 'LineStyle', ':')

% ylim([0, 2])
legend(PL,{'平均','標準偏差','平均の標準偏差'})

figure(2)
plot(1:Para.gen_num, Count_Memory(:,1))
line([Para.Gained_gen_Memory'; Para.Gained_gen_Memory'],  [zeros([1, size(Para.Gained_gen_Memory,1)]); zeros([1, size(Para.Gained_gen_Memory,1)]) + 200], 'Color', 'red', 'LineStyle', ':')
