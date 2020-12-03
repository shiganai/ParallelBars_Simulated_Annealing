function ActivatingRate_post = Mixing_Children(elite_num, child_num, notNaN_num, Joint_num, Data_Set_Time, ActivatingRate_post, ActivatingRate, Mutation_Max_num, ActivatingRate_Step_num)
%MI この関数の概要をここに記述
%   詳細説明をここに記述
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
    
    for mm = 1:Joint_num
        
        %途中入れ替えバージョン
        Time_Cut_Points_pre = randi(numel(Data_Set_Time),[2, 1]);
        Time_Cut_Points = sortrows(Time_Cut_Points_pre, 1);
        Time_Cut_Points(1) = Time_Cut_Points(1) - 1;
        
        
        ActivatingRate_post(child_num1,mm,:) = cat(3,ActivatingRate(child_num1, mm, 1:Time_Cut_Points(1)),...
            ActivatingRate(rand_num2, mm, Time_Cut_Points(1)+1:Time_Cut_Points(2)),...
            ActivatingRate(child_num1, mm, Time_Cut_Points(2)+1:end));
        
    end
    
    % 突然変異の挿入
    % 子供１
    % 突然変異数（乱数）
    Mutation_num = randperm(Mutation_Max_num+1, 1) - 1;
    % 突然変異挿入場所の生成（乱数）
    Mutation_Points = randperm(numel(Data_Set_Time) * Joint_num, Mutation_num);
    for dd = 1:Mutation_num
        % 変異ポイントの筋
        Mut_Joint_Points = ceil(Mutation_Points(1, dd) / numel(Data_Set_Time));
        % 変異ポイントの時刻
        Mut_Time_Points = Mutation_Points(1, dd) - (Mut_Joint_Points - 1) * numel(Data_Set_Time);
        % 変異の挿入
        ActivatingRate_post(child_num1, Mut_Joint_Points, Mut_Time_Points) = (randi(2*ActivatingRate_Step_num + 1, 1) - ActivatingRate_Step_num - 1) / ActivatingRate_Step_num;
    end
    
end
end

