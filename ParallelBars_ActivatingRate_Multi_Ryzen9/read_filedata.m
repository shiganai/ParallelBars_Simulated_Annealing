function A = read_filedata(filename,data_read_index)
%READ_FILEDATA ���̊֐��̊T�v�������ɋL�q
%   �ڍא����������ɋL�q
A = readmatrix(filename);
A = A(data_read_index,:);
end

