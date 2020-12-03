% x = fnzeros(MthShoulderData_spline);
% x = unique(x(:));
% y = fnval(MthShoulderData_spline,x);
% 
% xsp = 0:1e-2:1;
% sp = spline(x,y);
% ysp = fnval(sp, xsp);
% plot(xsp, ysp)

% er = 1e-2;
% x = fnzeros(fnder(MthShoulderData_spline));
% x(1,:) = x(1,:) - er;
% x(2,:) = x(2,:) + er;
% x = unique(x(:));
% y = fnval(MthShoulderData_spline,x);

er = 1e-1;
x = fnzeros(fnder(MthShoulderData_spline));
x = [x(1,:); x(1,:); x(1,:)];
x(1,:) = x(1,:) - er;
x(3,:) = x(3,:) + er;
x = unique(x(:));
y = fnval(MthShoulderData_spline,x);

figure(1)
sp = spline(x,y);
xsp = 0:1e-2:1;
ysp = fnval(sp,xsp);
plot(xsp,ysp)

ysp2 = fnval(MthShoulderData_spline, xsp);
hold on
plot(xsp, ysp2)
hold off
legend("sp","MthShoulderData","location","southwest")

figure(2)
plot(xsp, ysp-ysp2)
