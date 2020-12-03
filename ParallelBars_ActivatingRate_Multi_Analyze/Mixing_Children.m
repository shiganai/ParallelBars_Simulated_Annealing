function ActivatingRate_post = Mixing_Children(elite_num, child_num, notNaN_num, Joint_num, Data_Set_Time, ActivatingRate_post, ActivatingRate, Mutation_Max_num, ActivatingRate_Step_num)
%MI ���̊֐��̊T�v�������ɋL�q
%   �ڍא����������ɋL�q
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
end

