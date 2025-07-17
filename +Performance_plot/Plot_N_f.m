figure;
semilogy([36 60 72 96 108],MSE_DNN_over_SNR_N_f_design, 'Marker', '*', 'LineWidth', 1);
hold on
semilogy([36 60 72 96 108],MSE_DNN_over_SNR_N_f_ETU, 'Marker', 's', 'LineWidth', 1);
hold on
semilogy([36 60 72 96 108],MSE_DNN_over_SNR_N_f_EPA, 'Marker', 'o', 'LineWidth', 1);
hold on
semilogy([36 60 72 96 108],MSE_DNN_over_SNR_N_f_LOS, 'Marker', '+', 'LineWidth', 1);
hold on
semilogy([36 60 72 96 108],MSE_DNN_over_SNR_N_f_two, 'Marker', '|', 'LineWidth', 1);
hold on
semilogy([36 60 72 96 108],MSE_HA02_over_SNR_N_f_design, 'Marker', '*', 'LineWidth', 1, 'LineStyle', '--');
hold on
semilogy([36 60 72 96 108],MSE_HA02_over_SNR_N_f_ETU, 'Marker', 's', 'LineWidth', 1, 'LineStyle', '--');
hold on
semilogy([36 60 72 96 108],MSE_HA02_over_SNR_N_f_EPA, 'Marker', 'o', 'LineWidth', 1, 'LineStyle', '--');
hold on
semilogy([36 60 72 96 108],MSE_HA02_over_SNR_N_f_LOS, 'Marker', '+', 'LineWidth', 1, 'LineStyle', '--');
hold on
semilogy([36 60 72 96 108],MSE_HA02_over_SNR_N_f_two, 'Marker', '|', 'LineWidth', 1, 'LineStyle', '--');
hold on
semilogy([36 60 72 96 108],MSE_SimpleNet_over_SNR_N_f_design, 'Marker', '*', 'LineWidth', 1, 'LineStyle', '-.');
hold on
semilogy([36 60 72 96 108],MSE_SimpleNet_over_SNR_N_f_ETU, 'Marker', 's', 'LineWidth', 1, 'LineStyle', '-.');
hold on
semilogy([36 60 72 96 108],MSE_SimpleNet_over_SNR_N_f_EPA, 'Marker', 'o', 'LineWidth', 1, 'LineStyle', '-.');
hold on
semilogy([36 60 72 96 108],MSE_SimpleNet_over_SNR_N_f_LOS, 'Marker', '+', 'LineWidth', 1, 'LineStyle', '-.');
hold on
semilogy([36 60 72 96 108],MSE_SimpleNet_over_SNR_N_f_two, 'Marker', '|', 'LineWidth', 1, 'LineStyle', '-.');

ylim([1e-4 1e5])

legend('InterpolateNet tested on the designed channel', ...
    'InterpolateNet tested on the ETU channel', ...
    'InterpolateNet tested on the EPA channel', ...
    'InterpolateNet tested on the flat fading channel', ...
    'InterpolateNet tested on the Two path channel', ...
    'Channelformer tested on the designed channel', ...
    'Channelformer tested on the ETU channel', ...
    'Channelformer tested on the EPA channel', ...
    'Channelformer tested on the flat fading channel', ...
    'Channelformer tested on the Two path channel', ...
    'SimpleNet tested on the designed channel', ...
    'SimpleNet tested on the ETU channel', ...
    'SimpleNet tested on the EPA channel', ...
    'SimpleNet tested on the flat fading channel', ...
    'SimpleNet tested on the Two path channel'); 

xlabel('Number of subcarriers');
ylabel('MSE');
title('MSE performance tested with the SNR of 15dB');
grid on;
hold off;
