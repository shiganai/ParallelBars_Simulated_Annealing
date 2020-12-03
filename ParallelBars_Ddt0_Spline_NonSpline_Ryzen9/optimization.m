function [OutputPara] = optimization(Para)
%OPTIMIZATION ���̊֐��̊T�v�������ɋL�q
%   �ڍא����������ɋL�q
formatOut = 'dd/HH:MM:ss';
dateString = datestr(now,formatOut);
fprintf(strcat("    �J�n����    ", dateString,'\n'))

pop_num = Para.pop_num;
% gen_num = Para.gen_num;
elite_num = 2 - mod(pop_num,2);
child_num = Para.pop_num - elite_num;
Reset_Annealing_Count_Threshold = Para.Reset_Annealing_Count_Threshold;
Save_Reset_Count_Threshold = Para.Save_Reset_Count_Threshold;
Annealing_gen = Para.Annealing_gen;
No_Gain_gen_Threshold = Para.No_Gain_gen_Threshold;
% No_Gain_pop_num_ratio = Para.No_Gain_pop_num_ratio;
Average_Range = Para.Average_Range;
Mean_Std_Threshold = Para.Mean_Std_Threshold;
dthSwitchValue_Border = Para.dthSwitchValue_Border;

Mutation_Max_Ratio=Para.mutation_max_ratio; % (%) 1-5%������
Mutation_Max_num=round(Mutation_Max_Ratio*0.01*numel(Para.Data_Set_Time)*2);

Joint_num = Para.Joint_num;
% q0 = Para.q0;
Data_Set_Time = Para.Data_Set_Time;
ActivatingRate_Step_num = Para.ActivatingRate_Step_num;
Base_Transition_Probability = Para.Base_Transition_Probability;
Max_Transition_Probability = Para.Max_Transition_Probability;

Transition_Probability = Base_Transition_Probability;
no_gain_gen_num = 0;
Annealing_gen_num = 0;
Count_Mean_Memory = zeros([Average_Range, 1]) + NaN;
If_Gained_AfterAnnealing = 0;
If_Gained_AfterReset = 0;

Para.Annealing_gen_Memory = [1, 0];
Para.Reset_gen_Memory = [1, 0];
Para.Gained_gen_Memory = 1; %�n�߂��ꉞ�J�E���g����Elitest��index�ƍ��킹��
Para.Count_Memory = zeros([Para.gen_num, 3]);


ii = 1;
fprintf(strcat("��", num2str(ii), "����v�Z��\n"))

tic
Para.ObjectiveValueDatas = find_ObjectiveValueDatas(Para);

ObjectiveValueDatas_post = Para.ObjectiveValueDatas;
ActivatingRate_post = Para.ActivatingRate;

[ObjectiveValueDatas_post, index_pre] = sortrows(ObjectiveValueDatas_post, 1, 'MissingPlacement', 'last');
ActivatingRate_post = ActivatingRate_post(index_pre, :, :);

hold off
count = Para.Count_Memory(1,:);
DispObjectiveValueData(ObjectiveValueDatas_post(1:elite_num+1,:), count)

if Para.IfScat
    figure(100)
    scatter(zeros(Para.pop_num,1) + ii, ObjectiveValueDatas_post(:,1))
    ax100 = gca;
    xlabel('���㐔')
    ylabel('�]���l(�Ⴂ�قǗǂ�)')
    ylim(ax100, [max(0, ObjectiveValueDatas_post(1,1) - (322-ObjectiveValueDatas_post(1,1)) * 0.1), min(330, 322 + (322-ObjectiveValueDatas_post(1,1)) * 0.1)])
    yticks(ax100, 'auto')
    ax100.YTick = sort([ax100.YTick, 111]);
    grid(ax100, 'on')
    drawnow
else
    figure(100)
    ax100 = gca;
    scatter(ax100, 1:pop_num, ObjectiveValueDatas_post(:,1))
    xlabel(ax100, '����')
    ylabel(ax100, '�]���l(�Ⴂ�قǗǂ�)')
    drawnow
    figure(101)
    ax101 = gca;
    scatter(ax101, 1:pop_num, ObjectiveValueDatas_post(:,5))
    xlabel(ax101, 'dSwitchNum')
    ylabel(ax101, '�]���l(�Ⴂ�قǗǂ�)')
    drawnow
end
toc

Para.Midterm_Elitest_ActivatingRate = Para.ActivatingRate(1, :, :);
Para.Midterm_Elitest_ObjectiveValueDatas = Para.ObjectiveValueDatas(1,:);

Para.init_ActivatingRate = ActivatingRate_post;
Para.init_ObjectiveValueDatas = ObjectiveValueDatas_post;

Para.ActivatingRate = ActivatingRate_post;
Para.ObjectiveValueDatas = ObjectiveValueDatas_post;

while true
    
    if Para.ifstop
        Para.gen_num = ii;
        Para.Count_Memory = Para.Count_Memory(1:Para.gen_num,:);
        break
    end
    
    ii = ii + 1;
    Para.gen_num = ii;
    
    tic
    fprintf(strcat("��", num2str(ii), "����v�Z��\n"))
    fprintf(strcat("Transition_Probability = ", num2str(Transition_Probability), "\n"))
    
    ActivatingRate = Para.ActivatingRate;
    ObjectiveValueDatas = Para.ObjectiveValueDatas;
    
    ActivatingRate_post = zeros(size(ActivatingRate));
    
    jj = 1:elite_num;
    ActivatingRate_post(jj, :, :) = ActivatingRate(jj, :, :);
    
    notNaN_num = numel(find(~isnan(ObjectiveValueDatas(:,1))));
    
    for kk = 1:child_num
        
        %�e�̑I��(�ŏ�ʂ̃G���[�g�������A1�ʂ���ŏI�ʂ܂Ő��`�ɑI���m�����ቺ�B1�ʂ�1000�ʂ�1000�{�̊m���B)
        
        child_num1 = kk + elite_num;
        
        Parents_rank = zeros(2,1);
        Parents_rank(1,1) = child_num1;
        while true
            
            %�e��elite���܂܂Ȃ��ꍇ
            %{/
            if notNaN_num > child_num
                notNaN_num = child_num;
            end
            rand_num = randi(notNaN_num * (notNaN_num + 1)/2 + child_num,1); % pop_num - elite_num
            rank_child = find_child_index(rand_num, notNaN_num);
            % �S�W�c�̒��ł̏���
            Parents_rank(2,1)=rank_child+elite_num;
            %}
            
            %�e��elite�S�Ă��܂ޏꍇ
            %{
            if notNaN_num > child_num + elite_num
                notNaN_num = child_num + elite_num;
            end
            rand_num = randi(notNaN_num * (notNaN_num + 1)/2 + child_num + elite_num,1); % pop_num
            rank_child = find_child_index(rand_num, notNaN_num);
            % �S�W�c�̒��ł̏���
            Parents_rank(2,1)=rank_child;
            %}
            
            %�e�ɍł��ǂ�elite�ȊO��S�Ă��܂ޏꍇ
            %{
            if notNaN_num > child_num + elite_num - 1
                notNaN_num = child_num + elite_num - 1;
            end
            rand_num = randi(notNaN_num * (notNaN_num + 1)/2 + child_num + elite_num - 1,1);% pop_num - 1
            rank_child = find_child_index(rand_num, notNaN_num);
            % �S�W�c�̒��ł̏���
            Parents_rank(2,1)=rank_child + 1;
            %}
            
            if Parents_rank(1,1) ~= Parents_rank(2,1)
                break
            end
        end

        rand_num2 = Parents_rank(2,1);
        
        for mm = 1:Joint_num
            
            %�r������ւ��o�[�W����
            Time_Cut_Points_pre = randi(numel(Data_Set_Time),[2, 1]);
            Time_Cut_Points = sortrows(Time_Cut_Points_pre, 1);
            Time_Cut_Points(1) = Time_Cut_Points(1) - 1;
            
            
            ActivatingRate_post(child_num1,mm,:) = cat(3,ActivatingRate(child_num1, mm, 1:Time_Cut_Points(1)),...
                ActivatingRate(rand_num2, mm, Time_Cut_Points(1)+1:Time_Cut_Points(2)),...
                ActivatingRate(child_num1, mm, Time_Cut_Points(2)+1:end));
            
        end
        
        % �ˑR�ψق̑}��
        % �q���P
        % �ˑR�ψِ��i�����j
        Mutation_num = randperm(Mutation_Max_num+1, 1) - 1;
        % �ˑR�ψّ}���ꏊ�̐����i�����j
        Mutation_Points = randperm(numel(Data_Set_Time) * Joint_num, Mutation_num);
        for dd = 1:Mutation_num
            % �ψك|�C���g�̋�
            Mut_Joint_Points = ceil(Mutation_Points(1, dd) / numel(Data_Set_Time));
            % �ψك|�C���g�̎���
            Mut_Time_Points = Mutation_Points(1, dd) - (Mut_Joint_Points - 1) * numel(Data_Set_Time);
            % �ψق̑}��
            ActivatingRate_post(child_num1, Mut_Joint_Points, Mut_Time_Points) = (randi(2*ActivatingRate_Step_num + 1, 1) - ActivatingRate_Step_num - 1) / ActivatingRate_Step_num;
        end
        
    end
    
    ifElitestMatch = isequal(ActivatingRate(1,:,:), ActivatingRate_post(1,:,:));
    
    Para.ActivatingRate = ActivatingRate_post;
    ObjectiveValueDatas_post = find_ObjectiveValueDatas(Para);
    
    ObjectiveValueDatas_post_NaN_Logical_Array = isnan(ObjectiveValueDatas_post(:,1));
    ObjectiveValueDatas_post(ObjectiveValueDatas_post_NaN_Logical_Array,1) = 111 + 100;
    
    Probability_Array = min(ones([pop_num,1]), (Transition_Probability/100).^(ObjectiveValueDatas_post(:,1)-ObjectiveValueDatas(:,1))); %min���Ƃ�K�v�͂Ȃ���������Ȃ�
    Randum_Array = rand([pop_num,1]);
    
    ObjectiveValueDatas_post(ObjectiveValueDatas_post_NaN_Logical_Array,1) = NaN;

    %���ϓI�ɂ͂��̕���������₷��
    %{
    Transition_Logical_Array = Randum_Array < Probability_Array;
    ExtreamPoint(:,:,:, Transition_Logical_Array) = ExtreamPoint_post(:,:,:, Transition_Logical_Array);
    ExtreamPoint_num(Transition_Logical_Array, :) = ExtreamPoint_num_post(Transition_Logical_Array, :);
    ObjectiveValueDatas(Transition_Logical_Array, :) = ObjectiveValueDatas_post(Transition_Logical_Array, :);
    %}

    %�������������̕����R�[�h�̉��ς��y�B�J�ڂ��Ȃ����̂�_post�ɑ�����Ă���
    %{/
    Non_Transition_Logical_Array = Randum_Array > Probability_Array; %�J�ڂ��Ȃ����̘̂_���s��
    Non_Transition_Logical_Array(1:elite_num, 1) = 1; %elite_num�͈�v���Ă���͂�
    
    dthSwitchNumReducedIndex = (ObjectiveValueDatas_post(:,1) < dthSwitchValue_Border) .* (ObjectiveValueDatas_post(:,5) < ObjectiveValueDatas(:,5));
    Non_Transition_Logical_Array(logical(dthSwitchNumReducedIndex)) = 0; % �J�ڂ�������̂� 0
    
    dthSwitchNumGainedIndex = (ObjectiveValueDatas(:,1) < dthSwitchValue_Border) .* (ObjectiveValueDatas(:,5) <= 3) .* (ObjectiveValueDatas_post(:,5) >= 4);
    Non_Transition_Logical_Array(logical(dthSwitchNumGainedIndex)) = 1; % �J�ڂ�������̂� 0
    
    ActivatingRate_post(Non_Transition_Logical_Array,:,:) = ActivatingRate(Non_Transition_Logical_Array,:,:);
    ObjectiveValueDatas_post(Non_Transition_Logical_Array, :) = ObjectiveValueDatas(Non_Transition_Logical_Array, :);
    %}
    
    
    Transition_ToUpper_Logical_Array = (Probability_Array < 1) .* (1 - Non_Transition_Logical_Array);
    Transition_ToVeryUpper_Logical_Array = ObjectiveValueDatas_post(:,1) - ObjectiveValueDatas(:,1) > 10;
    
    count = [pop_num - size(find(Non_Transition_Logical_Array), 1) - size(find(Transition_ToUpper_Logical_Array), 1),...
        size(find(Transition_ToUpper_Logical_Array), 1),...
        size(find(Transition_ToVeryUpper_Logical_Array), 1)];
    
    Para.Count_Memory(ii,:) = count;
    if ii >= Average_Range + 1
        Count_Mean_Memory(mod(ii,Average_Range)+1,:) = mean(Para.Count_Memory(ii-(Average_Range-1):ii,1)-Para.Count_Memory(ii-(Average_Range-1) - 1:ii - 1,2));
    end
    
    [ObjectiveValueDatas_post, index_pre] = sortrows(ObjectiveValueDatas_post, 1, 'MissingPlacement', 'last');
    ActivatingRate_post = ActivatingRate_post(index_pre,:,:);
    
    if ObjectiveValueDatas_post(1,1) < ObjectiveValueDatas(1,1)
        warning("�ړI�֐��̒l��������܂���")
        Para.Midterm_Elitest_ActivatingRate(size(Para.Midterm_Elitest_ActivatingRate,1) + 1,:,:) = ActivatingRate_post(1,:,:);
        Para.Midterm_Elitest_ObjectiveValueDatas(size(Para.Midterm_Elitest_ObjectiveValueDatas,1) + 1, :) = ObjectiveValueDatas_post(1,:);
        
        no_gain_gen_num = 0; %�i�񂾂瑼�̏����ɂ�炸no_gain_gen_num�����Z�b�g
        If_Gained_AfterAnnealing = 1;
        If_Gained_AfterReset = 1;
        Para.Gained_gen_Memory = [Para.Gained_gen_Memory; ii];
    elseif ObjectiveValueDatas_post(1,1) > ObjectiveValueDatas(1,1)
        ifElitestMatch
        warning("�ړI�֐��̒l���オ��܂���")
%     else
%         no_gain_gen_num = no_gain_gen_num + 1;
    end
    
    if Transition_Probability > Base_Transition_Probability
        Annealing_gen_num = Annealing_gen_num + 1;
        
        if Annealing_gen_num >= Annealing_gen
            Annealing_gen_num = 0;
            Transition_Probability = Base_Transition_Probability;
            
            Para.Annealed_ActivaitingRate = ActivatingRate_post;
            Para.Annealed_ObjectiveValueDatas = ObjectiveValueDatas_post;
        end
    else
        %Gain�����̂̐��̕��ς̕W���΍���no_gain_gen_num�𑝂₷
        if ii >= 2*Average_Range - 1
            Mean_Std = std(Count_Mean_Memory)/pop_num;
            fprintf(strcat('Mean_Std = ', num2str(Mean_Std), '\n'))
            if Mean_Std < Mean_Std_Threshold
                no_gain_gen_num = no_gain_gen_num + 1;
            end
        end
        
        %�S�̌̐��ɑ΂���Gain�����̂̐��̊�����no_gain_gen_num�𑝂₷
        %{
        if pop_num - size(find(Non_Transition_Logical_Array), 1) - size(find(Transition_ToUpper_Logical_Array), 1) < pop_num * No_Gain_pop_num_ratio
            no_gain_gen_num = no_gain_gen_num + 1;
        end
        %}
    end
    
    DispObjectiveValueData(ObjectiveValueDatas_post(1:elite_num+1,:), count)
    
    if Para.IfScat
        hold(ax100,'on')
        scatter(ax100, zeros(pop_num,1) + ii, ObjectiveValueDatas_post(:,1))
        hold(ax100,'off')
        ylim(ax100, [max(0, ObjectiveValueDatas_post(1,1) - (322-ObjectiveValueDatas_post(1,1)) * 0.1), min(330, 322 + (322-ObjectiveValueDatas_post(1,1)) * 0.1)])
        yticks(ax100, 'auto')
        ax100.YTick = sort([ax100.YTick, 111]);
        %�Ă��Ȃ܂��J�n����tick�ɋL�^
        %{
    xticks('auto')
    xticklabels('auto')
    XTick_tmp = ax.XTick;
    XTickLabel_tmp = ax.XTickLabel;
    for jj = 1:size(Annealing_gen_Memory,1)
        TargetTick = Annealing_gen_Memory(jj,1);
        if isempty(find(XTick_tmp == TargetTick, 1))
            [XTick_tmp, Tick_Index] = sort([XTick_tmp, TargetTick]);
            XTickLabel_tmp = [XTickLabel_tmp; ""];
            XTickLabel_tmp = XTickLabel_tmp(Tick_Index',1);
        else
            Tick_Replace_Index = find(XTick_tmp == TargetTick);
            if size(Tick_Replace_Index,1) > 1
                error("Tick_Replace_Index���������݂���")
            end
            XTickLabel_tmp{Tick_Replace_Index(1,1),1} = "";
        end
    end
    ax.XTick = XTick_tmp;
    ax.XTickLabel = XTickLabel_tmp;
        %}
        drawnow
    else
        scatter(ax100, 1:pop_num, ObjectiveValueDatas_post(:,1))
        drawnow
        scatter(ax101, 1:pop_num, ObjectiveValueDatas_post(:,5))
        drawnow
    end
    
        
    Para.ActivatingRate = ActivatingRate_post;
    Para.ObjectiveValueDatas = ObjectiveValueDatas_post;

    saveMidtermPara(Para,ii)
    
    %�Ă��Ȃ܂��̊J�n
    if no_gain_gen_num >= No_Gain_gen_Threshold
        if Para.IfScat
            line(ax100, [ii+1, ii+1], [0 330], "Color", "red")
        end
        fprintf("-----------------------------------------�Ă��Ȃ܂��J�n-----------------------------------------\n")
        
        no_gain_gen_num = 0;
        Transition_Probability = Max_Transition_Probability;
        Para.Annealing_gen_Memory(end,2) = If_Gained_AfterAnnealing;
        
        Para.Before_Annealing_ActivatingRate = ActivatingRate_post;
        Para.Before_Annealing_ObjectiveValueDatas = ObjectiveValueDatas_post;
        
        Annealing_gen_Memory_After_Reset = Para.Annealing_gen_Memory(Para.Annealing_gen_Memory(:,1)>=Para.Reset_gen_Memory(end,1), :);
        if size(Annealing_gen_Memory_After_Reset, 1) >= Reset_Annealing_Count_Threshold
            if isempty(find(Annealing_gen_Memory_After_Reset(end-(Reset_Annealing_Count_Threshold-1):end,2) == 1, 1))
                
                Para.Reset_gen_Memory(end,2) = If_Gained_AfterReset;
                if size(Para.Reset_gen_Memory, 1) >= Save_Reset_Count_Threshold
                    if isempty(find(Para.Reset_gen_Memory(end-(Save_Reset_Count_Threshold-1):end,2) == 1, 1))
                        Para.ifstop = true;
                    else
                        if Para.IfScat
                            line(ax100, [ii+1, ii+1], [0 330], "Color", "green")
                        end
                        If_Gained_AfterReset = 0;
                        Para.Reset_gen_Memory = [Para.Reset_gen_Memory; ii+1, 0];
                        Para = reset_Para(Para);
                    end
                else
                    if Para.IfScat
                        line(ax100, [ii+1, ii+1], [0 330], "Color", "green")
                    end
                    
                    If_Gained_AfterReset = 0;
                    Para.Reset_gen_Memory = [Para.Reset_gen_Memory; ii+1, 0];
                    Para = reset_Para(Para);
                end
                
            end
        end
        
        If_Gained_AfterAnnealing = 0;
        Para.Annealing_gen_Memory = [Para.Annealing_gen_Memory; ii+1, 0];
    end
    
    %�S�f�[�^�̃��Z�b�g
    %{
    if no_gain_gen_num >= reset_gen_num
        Para = reset_Para(Para);
        no_gain_gen_num = 0;
    end
    %}
    
    toc
end

Para.Count_Memory = Para.Count_Memory(1:Para.gen_num,:);
OutputPara = Para;
end





