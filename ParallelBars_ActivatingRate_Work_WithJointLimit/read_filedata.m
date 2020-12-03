function A = read_filedata(filename,data_read_index)
%READ_FILEDATA この関数の概要をここに記述
%   詳細説明をここに記述
A = readmatrix(filename);
A = A(data_read_index,:);
end

