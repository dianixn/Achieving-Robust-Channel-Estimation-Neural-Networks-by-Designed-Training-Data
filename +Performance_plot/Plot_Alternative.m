figure;
semilogy(SNR_Range,MSE_DNN_over_SNR_CE, 'Marker', 'o', 'LineWidth', 1);
hold on
semilogy(SNR_Range,MSE_DNN_over_SNR_train, 'Marker', 'o', 'LineWidth', 1, 'LineStyle', '--');
hold on
semilogy(SNR_Range,MSE_DNN_over_SNR_flat, 'Marker', '+', 'LineWidth', 1, 'LineStyle', ':');
hold on
semilogy(SNR_Range,MSE_DNN_over_SNR_Two, 'Marker', 'v', 'LineWidth', 1, 'LineStyle', '-.');
hold on
semilogy(SNR_Range,MSE_DNN_over_SNR_EPA, 'Marker', 'd', 'LineWidth', 1, 'LineStyle', ':');
hold on
semilogy(SNR_Range,MSE_DNN_over_SNR_EVA, 'Marker', 'h', 'LineWidth', 1, 'LineStyle', '--');
hold on
semilogy(SNR_Range,MSE_DNN_over_SNR_ETU, 'Marker', 'h', 'LineWidth', 1);
hold on
semilogy(SNR_Range,MSE_DNN_over_SNR_DC1, 'Marker', 'x', 'LineWidth', 1, 'LineStyle', '--');
hold on
semilogy(SNR_Range,MSE_DNN_over_SNR_DC2, 'Marker', 's', 'LineWidth', 1);
hold on
semilogy(SNR_Range,MSE_DNN_over_SNR_DC3, 'Marker', 'd', 'LineWidth', 1);

ylim([1e-4 1e6])

legend('InterpolateNet tested on the CE channel', ...
    'InterpolateNet tested on the designed channel', ...
    'InterpolateNet tested on the flat fading channel', ...
    'InterpolateNet tested on the Two path channel', ...
    'InterpolateNet tested on the EPA channel', ...
    'InterpolateNet tested on the EVA channel', ...
    'InterpolateNet tested on the ETU channel', ...
    'InterpolateNet tested on the DC1 channel', ...
    'InterpolateNet tested on the DC2 channel', ...
    'InterpolateNet tested on the DC3 channel'); 

xlabel('SNR in dB');
ylabel('MSE');
title('MSE performance tested on the extended SNR range');
grid on;
hold off;

figure;
semilogy(SNR_Range,MSE_HA02_over_SNR_CE, 'Marker', 'o', 'LineWidth', 1);
hold on
semilogy(SNR_Range,MSE_HA02_over_SNR_train, 'Marker', 'o', 'LineWidth', 1, 'LineStyle', '--');
hold on
semilogy(SNR_Range,MSE_HA02_over_SNR_flat, 'Marker', '+', 'LineWidth', 1, 'LineStyle', ':');
hold on
semilogy(SNR_Range,MSE_HA02_over_SNR_Two, 'Marker', 'v', 'LineWidth', 1, 'LineStyle', '-.');
hold on
semilogy(SNR_Range,MSE_HA02_over_SNR_EPA, 'Marker', 'd', 'LineWidth', 1, 'LineStyle', ':');
hold on
semilogy(SNR_Range,MSE_HA02_over_SNR_EVA, 'Marker', 'h', 'LineWidth', 1, 'LineStyle', '--');
hold on
semilogy(SNR_Range,MSE_HA02_over_SNR_ETU, 'Marker', 'h', 'LineWidth', 1);
hold on
semilogy(SNR_Range,MSE_HA02_over_SNR_DC1, 'Marker', 'x', 'LineWidth', 1, 'LineStyle', '--');
hold on
semilogy(SNR_Range,MSE_HA02_over_SNR_DC2, 'Marker', 's', 'LineWidth', 1);
hold on
semilogy(SNR_Range,MSE_HA02_over_SNR_DC3, 'Marker', 'd', 'LineWidth', 1);

ylim([1e-4 1e6])

legend('Channelformer tested on the CE channel', ...
    'Channelformer tested on the designed channel', ...
    'Channelformer tested on the flat fading channel', ...
    'Channelformer tested on the Two path channel', ...
    'Channelformer tested on the EPA channel', ...
    'Channelformer tested on the EVA channel', ...
    'Channelformer tested on the ETU channel', ...
    'Channelformer tested on the DC1 channel', ...
    'Channelformer tested on the DC2 channel', ...
    'Channelformer tested on the DC3 channel'); 

xlabel('SNR in dB');
ylabel('MSE');
title('MSE performance tested on the extended SNR range');
grid on;
hold off;

figure;
semilogy(SNR_Range,MSE_SimpleNet_over_SNR_CE, 'Marker', 'o', 'LineWidth', 1);
hold on
semilogy(SNR_Range,MSE_SimpleNet_over_SNR_train, 'Marker', 'o', 'LineWidth', 1, 'LineStyle', '--');
hold on
semilogy(SNR_Range,MSE_SimpleNet_over_SNR_flat, 'Marker', '+', 'LineWidth', 1, 'LineStyle', ':');
hold on
semilogy(SNR_Range,MSE_SimpleNet_over_SNR_Two, 'Marker', 'v', 'LineWidth', 1, 'LineStyle', '-.');
hold on
semilogy(SNR_Range,MSE_SimpleNet_over_SNR_EPA, 'Marker', 'd', 'LineWidth', 1, 'LineStyle', ':');
hold on
semilogy(SNR_Range,MSE_SimpleNet_over_SNR_EVA, 'Marker', 'h', 'LineWidth', 1, 'LineStyle', '--');
hold on
semilogy(SNR_Range,MSE_SimpleNet_over_SNR_ETU, 'Marker', 'h', 'LineWidth', 1);
hold on
semilogy(SNR_Range,MSE_SimpleNet_over_SNR_DC1, 'Marker', 'x', 'LineWidth', 1, 'LineStyle', '--');
hold on
semilogy(SNR_Range,MSE_SimpleNet_over_SNR_DC2, 'Marker', 's', 'LineWidth', 1);
hold on
semilogy(SNR_Range,MSE_SimpleNet_over_SNR_DC3, 'Marker', 'd', 'LineWidth', 1);

ylim([1e-4 1e6])

legend('SimpleNet tested on the CE channel', ...
    'SimpleNet tested on the designed channel', ...
    'SimpleNet tested on the flat fading channel', ...
    'SimpleNet tested on the Two path channel', ...
    'SimpleNet tested on the EPA channel', ...
    'SimpleNet tested on the EVA channel', ...
    'SimpleNet tested on the ETU channel', ...
    'SimpleNet tested on the DC1 channel', ...
    'SimpleNet tested on the DC2 channel', ...
    'SimpleNet tested on the DC3 channel'); 

xlabel('SNR in dB');
ylabel('MSE');
title('MSE performance tested on the extended SNR range');
grid on;
hold off;
