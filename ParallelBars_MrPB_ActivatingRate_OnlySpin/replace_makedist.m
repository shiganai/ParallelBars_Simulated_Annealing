

x = [-1e-3, 0, 0.5, 1, 1+1e-3];
y = [0, 0, 0.5, 1,1];

sp = spline(x,y);

xq1 = 0:1e-3:1;
yq1 = fnval(sp, xq1);

xq2 = -1:1e-3:2;