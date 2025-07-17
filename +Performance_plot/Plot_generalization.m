figure;
loglog(Delay,MSE_DNN_over_SNR_CDL_A_DelaySpread, 'Marker', 'o', 'LineWidth', 1);
hold on
loglog(Delay,MSE_DNN_over_SNR_CDL_B_DelaySpread, 'Marker', '*', 'LineWidth', 1);
hold on
loglog(Delay,MSE_DNN_over_SNR_CDL_C_DelaySpread, 'Marker', '+', 'LineWidth', 1);
hold on
loglog(Delay,MSE_DNN_over_SNR_TDL_A_DelaySpread, 'Marker', '|', 'LineWidth', 1);
hold on
loglog(Delay,MSE_DNN_over_SNR_TDL_B_DelaySpread, 'Marker', 'x', 'LineWidth', 1);

ylim([1e-3 1e1])

legend('InterpolateNet tested on the CDL-A channel', ...
    'InterpolateNet tested on the CDL-B channel', ...
    'InterpolateNet tested on the CDL-C channel', ...
    'InterpolateNet tested on the TDL-A channel', ...
    'InterpolateNet tested on the TDL-B channel'); 

xlabel('DelaySpread in second');
ylabel('MSE');
title('Generalization of the trained InterpolateNet to CDL/TDL channels');
grid on;
hold off;

figure;
loglog(Delay,MSE_SimpleNet_over_SNR_CDL_A_DelaySpread, 'Marker', 'o', 'LineWidth', 1);
hold on
loglog(Delay,MSE_SimpleNet_over_SNR_CDL_B_DelaySpread, 'Marker', '*', 'LineWidth', 1);
hold on
loglog(Delay,MSE_SimpleNet_over_SNR_CDL_C_DelaySpread, 'Marker', '+', 'LineWidth', 1);
hold on
loglog(Delay,MSE_SimpleNet_over_SNR_TDL_A_DelaySpread, 'Marker', '|', 'LineWidth', 1);
hold on
loglog(Delay,MSE_SimpleNet_over_SNR_TDL_B_DelaySpread, 'Marker', 'x', 'LineWidth', 1);

ylim([1e-3 1e1])

legend('SimpleNet tested on the CDL-A channel', ...
    'SimpleNet tested on the CDL-B channel', ...
    'SimpleNet tested on the CDL-C channel', ...
    'SimpleNet tested on the TDL-A channel', ...
    'SimpleNet tested on the TDL-B channel'); 

xlabel('DelaySpread in second');
ylabel('MSE');
title('Generalization of the trained SimpleNet to CDL/TDL channels');
grid on;
hold off;

figure;
loglog(Delay,MSE_HA02_over_SNR_CDL_A_DelaySpread, 'Marker', 'o', 'LineWidth', 1);
hold on
loglog(Delay,MSE_HA02_over_SNR_CDL_B_DelaySpread, 'Marker', '*', 'LineWidth', 1);
hold on
loglog(Delay,MSE_HA02_over_SNR_CDL_C_DelaySpread, 'Marker', '+', 'LineWidth', 1);
hold on
loglog(Delay,MSE_HA02_over_SNR_TDL_A_DelaySpread, 'Marker', '|', 'LineWidth', 1);
hold on
loglog(Delay,MSE_HA02_over_SNR_TDL_B_DelaySpread, 'Marker', 'x', 'LineWidth', 1);

ylim([1e-3 1e1])

legend('Channelformer tested on the CDL-A channel', ...
    'Channelformer tested on the CDL-B channel', ...
    'Channelformer tested on the CDL-C channel', ...
    'Channelformer tested on the TDL-A channel', ...
    'Channelformer tested on the TDL-B channel'); 

xlabel('DelaySpread in second');
ylabel('MSE');
title('Generalization of the trained Channelformer to CDL/TDL channels');
grid on;
hold off;
