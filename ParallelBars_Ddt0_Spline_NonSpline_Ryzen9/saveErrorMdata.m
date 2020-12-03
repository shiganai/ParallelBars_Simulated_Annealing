function saveErrorMdata(q0, dataTime, odeTime, absTol, constants, Mdata, odeEvent)
%SAVEERRORMDATAS この関数の概要をここに記述
%   詳細説明をここに記述
formatOut = 'mmddHHMMss';
dateString = datestr(now,formatOut);

save(strcat('errorMdata_',dateString,'.mat'),'q0','dataTime','odeTime','absTol','constants','Mdata','odeEvent')
end

