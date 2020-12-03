function [OutputPara] = optimization_Anneal(Para)
%OPTIMIZATION この関数の概要をここに記述
%   詳細説明をここに記述
formatOut = 'dd/HH:MM:ss';
dateString = datestr(now,formatOut);
fprintf(strcat("    開始時刻    ", dateString,'\n'))

pop_num = Para.pop_num;
% gen_num = Para.gen_num;
elite_num = 2 - mod(pop_num,2);
child_num = Para.pop_num - elite_num;
% reset_gen_num = Para.reset_gen_num;
Annealing_gen_Range = Para.Annealing_gen_Range;
No_Gain_gen_Threshold = Para.No_Gain_gen_Threshold;
% No_Gain_pop_num_ratio = Para.No_Gain_pop_num_ratio;
Average_Range = Para.Average_Range;
Mean_Std_Threshold = Para.Mean_Std_Threshold;

mutation_max_ratio=Para.mutation_max_ratio; % (%) 1-5%が推奨
% mutation_max_num=round(mutation_max_ratio*0.01*numel(Para.dataTime)*2);

Joint_num = Para.Joint_num;
q0 = Para.q0;
Time_step_num = Para.Time_step_num;
Time_Limit = Para.Time_Limit;
Omega_step_num = Para.Omega_step_num;
Omega_max = Para.Omega_max;
Base_Transition_Probability = Para.Base_Transition_Probability;
Max_Transition_Probability = Para.Max_Transition_Probability;

Transition_Probability = Max_Transition_Probability;
no_gain_gen_num = 0;
Annealing_gen_num = 0;
Count_Mean_Memory = zeros([Average_Range, 1]) + NaN;
If_Gained_AfterAnnealing = 0;

Para.Annealing_gen_Memory = [1, 0];
Para.Gained_gen_Memory = 1; %始めを一応カウントしてElitestのindexと合わせる
Para.Count_Memory = zeros([Para.gen_num, 3]);


ii = 1;
fprintf(strcat("第", num2str(ii), "世代計算中\n"))

tic
Para.ObjectiveValueDatas = find_ObjectiveValueDatas(Para);

ObjectiveValueDatas_post = Para.ObjectiveValueDatas;
ExtreamPoint_post = Para.ExtreamPoint;
ExtreamPoint_num_post = Para.ExtreamPoint_num;

[ObjectiveValueDatas_post, index_pre] = sortrows(ObjectiveValueDatas_post, 1, 'MissingPlacement', 'last');
ExtreamPoint_post = ExtreamPoint_post(:, :, :, index_pre);
ExtreamPoint_num_post = ExtreamPoint_num_post(index_pre, :);

hold off
count = Para.Count_Memory(1,:);
DispObjectiveValueData(ObjectiveValueDatas_post(1:elite_num+1,:), count)
scatter(zeros(Para.pop_num,1) + ii, ObjectiveValueDatas_post(:,1))
ax = gca;
ylim(ax, [max(0, ObjectiveValueDatas_post(1,1) - (211-ObjectiveValueDatas_post(1,1)) * 0.1), min(220, 211 + (211-ObjectiveValueDatas_post(1,1)) * 0.1)])
yticks(ax, 'auto')
ax.YTick = sort([ax.YTick, 111]);
grid(ax, 'on')
drawnow
toc

Para.midterm_elitest_ExtreamPoint = Para.ExtreamPoint(:, :, :, 1);
Para.midterm_elitest_ExtreamPoint_num = Para.ExtreamPoint_num(1, :);
Para.midterm_elitest_ObjectiveValueDatas = Para.ObjectiveValueDatas(1,:);

Para.init_ExtreamPoint = ExtreamPoint_post;
Para.init_ExtreamPoint_num = ExtreamPoint_num_post;
Para.init_ObjectiveValueDatas = ObjectiveValueDatas_post;

Para.ExtreamPoint = ExtreamPoint_post;
Para.ExtreamPoint_num = ExtreamPoint_num_post;
Para.ObjectiveValueDatas = ObjectiveValueDatas_post;

while ii < Para.gen_num
    ii = ii + 1;
    tic
    fprintf(strcat("第", num2str(ii), "世代計算中\n"))
    fprintf(strcat("Transition_Probability = ", num2str(Transition_Probability), "\n"))
    
    ExtreamPoint = Para.ExtreamPoint;
    ExtreamPoint_num = Para.ExtreamPoint_num;
    ObjectiveValueDatas = Para.ObjectiveValueDatas;
    
    ExtreamPoint_post = zeros(size(ExtreamPoint));
    ExtreamPoint_num_post = zeros(size(ExtreamPoint_num));
    
    jj = 1:elite_num;
    ExtreamPoint_post(:, :, :, jj) = ExtreamPoint(:, :, :, jj);
    ExtreamPoint_num_post(jj, :) = ExtreamPoint_num(jj, :);
    
    notNaN_num = numel(find(~isnan(ObjectiveValueDatas(:,1))));
    
    for kk = 1:child_num
        
        %親の選択(最上位のエリートを除く、1位から最終位まで線形に選択確率が低下。1位は1000位の1000倍の確率。)
        
        child_num1 = kk + elite_num;
        
        Parents_rank = zeros(2,1);
        Parents_rank(1,1) = child_num1;
        while true
            
            %親にeliteを含まない場合
            %{/
            if notNaN_num > child_num
                notNaN_num = child_num;
            end
            rand_num = randi(notNaN_num * (notNaN_num + 1)/2 + child_num,1); % pop_num - elite_num
            rank_child = find_child_index(rand_num, notNaN_num);
            % 全集団の中での順位
            Parents_rank(2,1)=rank_child+elite_num;
            %}
            
            %親にelite全てを含む場合
            %{
            if notNaN_num > child_num + elite_num
                notNaN_num = child_num + elite_num;
            end
            rand_num = randi(notNaN_num * (notNaN_num + 1)/2 + child_num + elite_num,1); % pop_num
            rank_child = find_child_index(rand_num, notNaN_num);
            % 全集団の中での順位
            Parents_rank(2,1)=rank_child;
            %}
            
            %親に最も良いelite以外を全てを含む場合
            %{
            if notNaN_num > child_num + elite_num - 1
                notNaN_num = child_num + elite_num - 1;
            end
            rand_num = randi(notNaN_num * (notNaN_num + 1)/2 + child_num + elite_num - 1,1);% pop_num - 1
            rank_child = find_child_index(rand_num, notNaN_num);
            % 全集団の中での順位
            Parents_rank(2,1)=rank_child + 1;
            %}
            
            if Parents_rank(1,1) ~= Parents_rank(2,1)
                break
            end
        end

        rand_num2 = Parents_rank(2,1);
        
        ExtreamPoint_target1 = ExtreamPoint(:,:,:, child_num1);
        ExtreamPoint_target2 = ExtreamPoint(:,:,:, rand_num2);
        
        ExtreamPoint_Replaced1 = ExtreamPoint_target1;
        
        ExtreamPoint_num_target1 = ExtreamPoint_num(child_num1, :);
        ExtreamPoint_num_target2 = ExtreamPoint_num(rand_num2, :);
    
        for mm = 1:Joint_num
            
            %途中入れ替えバージョン
            swap_num_max = min(ExtreamPoint_num_target1(1, mm), ExtreamPoint_num_target2(1, mm)) - 1;
            swap_num = randi(swap_num_max);
            
            Replacing_index_start1 = randi(ExtreamPoint_num_target1(1, mm) - swap_num, 1) + 1;
            Replacing_index_start2 = randi(ExtreamPoint_num_target2(1, mm) - swap_num, 1) + 1;
            
            Replacing_index1 = Replacing_index_start1 : Replacing_index_start1 + swap_num - 1;
            Replacing_index2 = Replacing_index_start2 : Replacing_index_start2 + swap_num - 1;
            
            if Replacing_index1(end) > ExtreamPoint_num_target1(1, mm)
                error("Replacing_index1(end) > Para.ExtreamPoint_num(child_num1)")
            end
            if Replacing_index2(end) > ExtreamPoint_num_target2(1, mm)
                error("Replacing_index2(end) > Para.ExtreamPoint_num(rand_num2)")
            end
            
            Replaced_index1 = Replacing_index1;
%             Replaced_index2 = Replacing_index2;
            
            for dd = 1:swap_num
                target_Replacing_index = Replacing_index2(1, dd);
                time_match_index = find(ExtreamPoint_target1(:, 1, mm, 1) == ExtreamPoint_target2(target_Replacing_index, 1, mm, 1));
                
                if length(time_match_index) >= 2
                    error("time_macth_indexが複数あります")
                elseif length(time_match_index) == 1
                    Replaced_index_match_index = find(Replaced_index1(1, :) == time_match_index);
                    if length(Replaced_index_match_index) >= 2
                        error("Replaced_index_macth_indexが複数あります")
                    elseif length(Replaced_index_match_index) == 1
                        Replaced_index1(1, [dd Replaced_index_match_index]) = Replaced_index1(1, [Replaced_index_match_index dd]);
                    else
                        Replaced_index1(1, dd) = time_match_index;
                    end
                end
            end
            
            ExtreamPoint_Replaced1(Replaced_index1, :, mm, 1) = ExtreamPoint_target2(Replacing_index2, :, mm, 1);
            
            %突然変異の挿入
            %子供1
            mutaion_rate = randi(mutation_max_ratio + 1, 1) - 1;
            rand_rate = [100; randi(100, [ExtreamPoint_num_target1(1, mm) - 1, 1])];
            
            rand_ExtreamPoint = [0, q0(mm+5,1);
                (randperm(Time_step_num, ExtreamPoint_num_target1(1, mm))')/Time_step_num * Time_Limit,...
                (randi(2*Omega_step_num+1,[ExtreamPoint_num_target1(1, mm),1]) - Omega_step_num - 1)/Omega_step_num * Omega_max(mm,1)];
            
            for dd = 1:ExtreamPoint_num_target1(1, mm)
                if rand_rate(dd,1) <= mutaion_rate
                    match_index = find(ExtreamPoint_Replaced1(:, 1, mm, 1) == rand_ExtreamPoint(dd, 1));
                    if length(match_index) >= 2
                        error("match_indexが複数存在します")
                    elseif length(match_index) == 1
                        ExtreamPoint_Replaced1(match_index, :, mm, 1) = rand_ExtreamPoint(dd, :);
                    else
                        ExtreamPoint_Replaced1(dd, :, mm, 1) = rand_ExtreamPoint(dd, :);
                    end
                end
            end
            ExtreamPoint_Replaced1(:, :, mm, 1) = sortrows(ExtreamPoint_Replaced1(:, :, mm, 1), 1);
            
            if size(unique(ExtreamPoint_Replaced1(1:ExtreamPoint_num_target1(1, mm), 1, mm, 1)), 1) ~= ExtreamPoint_num_target1(1, mm)
                error("stop")
            end
            
        end
        
        ExtreamPoint_post(:,:,:, child_num1) = ExtreamPoint_Replaced1;
        ExtreamPoint_num_post(child_num1, :) = ExtreamPoint_num_target1;
        
        
    end
    
    ifElitestMatch = isequal(ExtreamPoint(:,:,:,1), ExtreamPoint_post(:,:,:,1));
    
    Para.ExtreamPoint = ExtreamPoint_post;
    Para.ExtreamPoint_num = ExtreamPoint_num_post;
    ObjectiveValueDatas_post = find_ObjectiveValueDatas(Para);
    
    ObjectiveValueDatas_post_NaN_Logical_Array = isnan(ObjectiveValueDatas_post(:,1));
    ObjectiveValueDatas_post(ObjectiveValueDatas_post_NaN_Logical_Array,1) = 111 + 100;
    
    Probability_Array = min(ones([pop_num,1]), (Transition_Probability/100).^(ObjectiveValueDatas_post(:,1)-ObjectiveValueDatas(:,1)))...
        .* ~((ObjectiveValueDatas(:,1) < 111) .* (ObjectiveValueDatas_post(:,1) > 111)); %minをとる必要はないかもしれない
    Randum_Array = rand([pop_num,1]);
    
    ObjectiveValueDatas_post(ObjectiveValueDatas_post_NaN_Logical_Array,1) = NaN;

    %直観的にはこの方が分かりやすい
    %{
    Transition_Logical_Array = Randum_Array < Probability_Array;
    ExtreamPoint(:,:,:, Transition_Logical_Array) = ExtreamPoint_post(:,:,:, Transition_Logical_Array);
    ExtreamPoint_num(Transition_Logical_Array, :) = ExtreamPoint_num_post(Transition_Logical_Array, :);
    ObjectiveValueDatas(Transition_Logical_Array, :) = ObjectiveValueDatas_post(Transition_Logical_Array, :);
    %}

    %ただしこっちの方がコードの改変が楽。遷移しないものを_postに代入していく
    Non_Transition_Logical_Array = Randum_Array > Probability_Array; %遷移しないものの論理行列
    Non_Transition_Logical_Array(1:elite_num, 1) = 1; %elite_numは一致しているはず
    ExtreamPoint_post(:,:,:, Non_Transition_Logical_Array) = ExtreamPoint(:,:,:, Non_Transition_Logical_Array);
    ExtreamPoint_num_post(Non_Transition_Logical_Array, :) = ExtreamPoint_num(Non_Transition_Logical_Array, :);
    ObjectiveValueDatas_post(Non_Transition_Logical_Array, :) = ObjectiveValueDatas(Non_Transition_Logical_Array, :);
    
    size(find(ObjectiveValueDatas_post(:,1)<111),1) - size(find(ObjectiveValueDatas(:,1)<111),1)
    
    Transition_ToUpper_Logical_Array = (Probability_Array < 1) .* (1 - Non_Transition_Logical_Array);
    Transition_ToVeryUpper_Logical_Array = ObjectiveValueDatas_post(:,1) - ObjectiveValueDatas(:,1) > 10;
    
    count = [pop_num - size(find(Non_Transition_Logical_Array), 1) - size(find(Transition_ToUpper_Logical_Array), 1),...
        size(find(Transition_ToUpper_Logical_Array), 1),...
        size(find(Transition_ToVeryUpper_Logical_Array), 1)];
    
    Para.Count_Memory(ii,:) = count;
    if ii >= Average_Range
        Count_Mean_Memory(mod(ii,Average_Range)+1,:) = mean(Para.Count_Memory(ii-(Average_Range-1):ii,1));
    end
    
    [ObjectiveValueDatas_post, index_pre] = sortrows(ObjectiveValueDatas_post, 1, 'MissingPlacement', 'last');
    ExtreamPoint_post = ExtreamPoint_post(:, :, :, index_pre);
    ExtreamPoint_num_post = ExtreamPoint_num_post(index_pre, :);
    
    if ObjectiveValueDatas_post(1,1) < ObjectiveValueDatas(1,1)
        warning("目的関数の値が下がりました")
        Para.midterm_elitest_ExtreamPoint(:, :, :,size(Para.midterm_elitest_ExtreamPoint,4) + 1) = ExtreamPoint_post(:, :, :, 1);
        Para.midterm_elitest_ExtreamPoint_num(size(Para.midterm_elitest_ExtreamPoint_num,1) + 1, :) = ExtreamPoint_num_post(1,:);
        Para.midterm_elitest_ObjectiveValueDatas(size(Para.midterm_elitest_ObjectiveValueDatas,1) + 1, :) = ObjectiveValueDatas_post(1,:);
        
        no_gain_gen_num = 0; %進んだら他の条件によらずno_gain_gen_numをリセット
        If_Gained_AfterAnnealing = 1;
        Para.Gained_gen_Memory = [Para.Gained_gen_Memory; ii];
    elseif ObjectiveValueDatas_post(1,1) > ObjectiveValueDatas(1,1)
        ifElitestMatch
        warning("目的関数の値が上がりました")
%     else
%         no_gain_gen_num = no_gain_gen_num + 1;
    end
    
    if Transition_Probability > Base_Transition_Probability
        Annealing_gen_num = Annealing_gen_num + 1;
        
        if Annealing_gen_num >= Annealing_gen_Range
            Annealing_gen_num = 0;
            Transition_Probability = Base_Transition_Probability;
            
            Para.Annealed_ExtreamPoint = ExtreamPoint_post;
            Para.Annealed_ExtreamPoint_num = ExtreamPoint_num_post;
            Para.Annealed_ObjectiveValueDatas = ObjectiveValueDatas_post;
        end
    else
        %Gainした個体の数の平均の標準偏差でno_gain_gen_numを増やす
        if ii >= 2*Average_Range - 1
            Mean_Std = std(Count_Mean_Memory)/pop_num;
            fprintf(strcat('Mean_Std = ', num2str(Mean_Std), '\n'))
            if Mean_Std < Mean_Std_Threshold
                no_gain_gen_num = no_gain_gen_num + 1;
            end
        end
        
        %全体個体数に対するGainした個体の数の割合でno_gain_gen_numを増やす
        %{
        if pop_num - size(find(Non_Transition_Logical_Array), 1) - size(find(Transition_ToUpper_Logical_Array), 1) < pop_num * No_Gain_pop_num_ratio
            no_gain_gen_num = no_gain_gen_num + 1;
        end
        %}
    end
    
    DispObjectiveValueData(ObjectiveValueDatas_post(1:elite_num+1,:), count)
    
    hold(ax,'on')
    scatter(ax, zeros(pop_num,1) + ii, ObjectiveValueDatas_post(:,1))
    hold(ax,'off')
    ylim(ax, [max(0, ObjectiveValueDatas_post(1,1) - (211-ObjectiveValueDatas_post(1,1)) * 0.1), min(220, 211 + (211-ObjectiveValueDatas_post(1,1)) * 0.1)])
    yticks(ax, 'auto')
    ax.YTick = sort([ax.YTick, 111]);
    %焼きなまし開始時をtickに記録
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
                error("Tick_Replace_Indexが複数存在する")
            end
            XTickLabel_tmp{Tick_Replace_Index(1,1),1} = "";
        end
    end
    ax.XTick = XTick_tmp;
    ax.XTickLabel = XTickLabel_tmp;
    %}
    drawnow
    
        
    Para.ExtreamPoint = ExtreamPoint_post;
    Para.ExtreamPoint_num = ExtreamPoint_num_post;
    Para.ObjectiveValueDatas = ObjectiveValueDatas_post;

    saveMidtermPara(Para,ii)
    
    %焼きなましの開始
    if no_gain_gen_num >= No_Gain_gen_Threshold
        no_gain_gen_num = 0;
        Transition_Probability = Max_Transition_Probability;
        Para.Annealing_gen_Memory(end,2) = If_Gained_AfterAnnealing;
        
        if ~If_Gained_AfterAnnealing
            if size(Para.Annealing_gen_Memory, 1) >= 3
                if isempty(find(Para.Annealing_gen_Memory(end-2:end-1,2) == 1, 1))
                    Para.ifstop = true;
                end
            end
        end
        
        If_Gained_AfterAnnealing = 0;
        Para.Annealing_gen_Memory = [Para.Annealing_gen_Memory; ii+1, 0];
        line([ii+1, ii+1], [0 220], "Color", "red")
%         line([ii+1, ii+1], ax.YLim, "Color", "red")
        fprintf("-----------------------------------------焼きなまし開始-----------------------------------------\n")
    end
    
    %全データのリセット
    %{
    if no_gain_gen_num >= reset_gen_num
        Para = reset_Para(Para);
        no_gain_gen_num = 0;
    end
    %}
    
    
    if Para.ifstop
        Para.gen_num = ii;
        Para.Count_Memory = Para.Count_Memory(1:Para.gen_num,:);
        break
    end
    toc
end

Para.Count_Memory = Para.Count_Memory(1:Para.gen_num,:);
OutputPara = Para;
end





