function index = find_child_index(rand_int, notNaN_num)
%PDF ���̊֐��̊T�v�������ɋL�q
%   �ڍא����������ɋL�q

%NaN�̒l�͂��ׂē���ŉ��ʂƂ��A1�̒l���B
%�l������U��ꂽ�̂Ɋւ��Ă͍ŉ��ʂ�2�A�ŏ�ʂ�notNaN_num+1�̒l������U��B
%rand_int�̒l���ǂ̊Ԃɓ��邩���v�Z����B

if rand_int >= (notNaN_num + 2) * (notNaN_num + 1) / 2 -1
    index = rand_int - (notNaN_num + 1) * (notNaN_num + 2) / 2 + 1 + notNaN_num;
elseif rand_int < (notNaN_num + 2) * (notNaN_num + 1) / 2 -1
    index = notNaN_num + 3/2 - (notNaN_num^2 + 3*notNaN_num + 9/4 - 2*rand_int)^(1/2);
end
index = ceil(index);
end

