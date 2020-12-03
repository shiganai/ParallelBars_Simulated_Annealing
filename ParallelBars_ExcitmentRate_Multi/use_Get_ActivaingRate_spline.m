time = (0:1e-2:5)';

ExcitingRate_Data = [(0:1e-2:1.5)', (0:1e-2:1.5)'*0;
    2, -2;
    (2.5:1e-2:10)', (2.5:1e-2:10)'*0
    ];

tau = 100 / 1000;
ActivatingRate_Spline = Get_ActivatingRate_spline(ExcitingRate_Data(:,1), ExcitingRate_Data(:,2), time, tau);

ExcitmentRate_Spline = spline(ExcitingRate_Data(:,1), ExcitingRate_Data(:,2));
ExcitingRate = fnval(ExcitmentRate_Spline, time);

plot(time, ExcitingRate, 'Displayname', 'Original')

hold on
plot(time, fnval(ActivatingRate_Spline, time))
hold off





































