
omega_Target = 0;

muscle_Para = Hand_Para_Matthew;
% muscle_Para = Shoulder_Para_Matthew;
% muscle_Para = Waist_Para_Matthew;

theta_Target = muscle_Para.theta_PE_1_Ext:muscle_Para.theta_PE_1_Flex;

Torque_Out = VoluntaryTorque(muscle_Para, theta_Target, omega_Target, 1);

figure(2)
plot(theta_Target, Torque_Out)

Torque_Out = VoluntaryTorque(muscle_Para, theta_Target, omega_Target, -1);
hold on
plot(theta_Target, Torque_Out)
hold off

Torque_Out = VoluntaryTorque(muscle_Para, theta_Target, omega_Target, 0);
hold on
plot(theta_Target, Torque_Out, '-.')
hold off























