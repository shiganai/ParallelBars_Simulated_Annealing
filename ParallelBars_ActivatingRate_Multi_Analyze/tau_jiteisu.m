

load('Para_0909114047_pop_2400_gen_16454_2')

index = 1;

ActivatingRate = Para.ActivatingRate;

Data_Set_Time = Para.Data_Set_Time;

ActivatingRate_index = [reshape(ActivatingRate(index,1,:), size(Data_Set_Time)), reshape(ActivatingRate(index,2,:), size(Data_Set_Time)), reshape(ActivatingRate(index,3,:), size(Data_Set_Time))];

t = Para.odeTime;
MthWaist_ActivatingRate = spline(Data_Set_Time, ActivatingRate_index(:,3), t);

MthWaist_ActivatingRate(MthWaist_ActivatingRate > 1) = 1;
MthWaist_ActivatingRate(MthWaist_ActivatingRate < -1) = -1;

MthWaist_ActivatingRate_spline = spline(t, MthWaist_ActivatingRate);
dMthWaist_ActivatingRate = fnval(fnder(MthWaist_ActivatingRate_spline), t);

tau_Data = [10, 20, 50, 100]';

figure(3)
plot(t, MthWaist_ActivatingRate, 'Displayname', 'original', 'LineWidth', 3)
for ii = 1:size(tau_Data,1)
    tau = tau_Data(ii);
    hold on
    plot(t, MthWaist_ActivatingRate + tau/1000 * dMthWaist_ActivatingRate, 'Displayname', strcat("\tau = ", num2str(tau), 'ms'), 'LineWidth', 3)
    hold off
end
legend












































