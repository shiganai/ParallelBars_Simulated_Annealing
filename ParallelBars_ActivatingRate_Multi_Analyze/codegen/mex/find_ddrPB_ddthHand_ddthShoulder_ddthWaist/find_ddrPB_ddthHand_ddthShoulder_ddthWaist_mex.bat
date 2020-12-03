@echo off
set MATLAB=C:\PROGRA~1\MATLAB\R2020a
call "C:\Program Files\MATLAB\R2020a\sys\lcc64\lcc64\mex\lcc64opts.bat"
"C:\Program Files\MATLAB\R2020a\toolbox\shared\coder\ninja\win64\ninja.exe" -v %*
