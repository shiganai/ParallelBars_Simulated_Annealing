function saveErrorMdata(q0, dataTime, odeTime, absTol, constants, Mdata, odeEvent)
%SAVEERRORMDATAS ���̊֐��̊T�v�������ɋL�q
%   �ڍא����������ɋL�q
formatOut = 'mmddHHMMss';
dateString = datestr(now,formatOut);

save(strcat('errorMdata_',dateString,'.mat'),'q0','dataTime','odeTime','absTol','constants','Mdata','odeEvent')
end

