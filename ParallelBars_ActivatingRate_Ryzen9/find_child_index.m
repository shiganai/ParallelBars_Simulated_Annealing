function index = find_child_index(rand_int, notNaN_num)
%PDF この関数の概要をここに記述
%   詳細説明をここに記述

%NaNの値はすべて同列最下位とし、1の値を。
%値が割り振られた個体に関しては最下位が2、最上位がnotNaN_num+1の値を割り振る。
%rand_intの値がどの間に入るかを計算する。

if rand_int >= (notNaN_num + 2) * (notNaN_num + 1) / 2 -1
    index = rand_int - (notNaN_num + 1) * (notNaN_num + 2) / 2 + 1 + notNaN_num;
elseif rand_int < (notNaN_num + 2) * (notNaN_num + 1) / 2 -1
    index = notNaN_num + 3/2 - (notNaN_num^2 + 3*notNaN_num + 9/4 - 2*rand_int)^(1/2);
end
index = ceil(index);
end

