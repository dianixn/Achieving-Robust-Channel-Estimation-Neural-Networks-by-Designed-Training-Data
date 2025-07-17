figure;
semilogy(SNR_Range,BER_LS_over_SNR, 'Marker', '*', 'LineWidth', 1);
hold on
semilogy(SNR_Range,BER_MMSE_over_SNR, 'Marker', 's', 'LineWidth', 1, 'LineStyle', '--');
hold on
semilogy(SNR_Range,BER_DNN_over_SNR_train, 'Marker', 'o', 'LineWidth', 1);
hold on
semilogy(SNR_Range,BER_DNN_over_SNR_flat, 'Marker', '+', 'LineWidth', 1, 'LineStyle', ':');
hold on
semilogy(SNR_Range,BER_DNN_over_SNR_Two_path, 'Marker', 'v', 'LineWidth', 1, 'LineStyle', '-.');
hold on
semilogy(SNR_Range,BER_DNN_over_SNR_EPA, 'Marker', 'd', 'LineWidth', 1, 'LineStyle', ':');
hold on
semilogy(SNR_Range,BER_DNN_over_SNR_EVA, 'Marker', 'h', 'LineWidth', 1, 'LineStyle', '--');
hold on
semilogy(SNR_Range,BER_DNN_over_SNR_ETU, 'Marker', 'h', 'LineWidth', 1);
hold on
semilogy(SNR_Range,BER_DNN_over_SNR_DC1, 'Marker', 'x', 'LineWidth', 1, 'LineStyle', '--');
hold on
semilogy(SNR_Range,BER_DNN_over_SNR_DC2, 'Marker', 's', 'LineWidth', 1);
hold on
semilogy(SNR_Range,BER_DNN_over_SNR_DC3, 'Marker', 'd', 'LineWidth', 1);

ylim([1e-4 1e4])

legend('LS estimate tested on the designed channel', ...
    'MMSE estimate tested on the designed channel', ...
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
ylabel('BER');
title('BER performance of InterpolateNet on fixed PDP channels');
grid on;
hold off;

figure;
semilogy(SNR_Range,BER_LS_over_SNR, 'Marker', '*', 'LineWidth', 1);
hold on
semilogy(SNR_Range,BER_MMSE_over_SNR, 'Marker', 's', 'LineWidth', 1, 'LineStyle', '--');
hold on
semilogy(SNR_Range,BER_HA02_over_SNR_train, 'Marker', 'o', 'LineWidth', 1);
hold on
semilogy(SNR_Range,BER_HA02_over_SNR_flat, 'Marker', '+', 'LineWidth', 1, 'LineStyle', ':');
hold on
semilogy(SNR_Range,BER_HA02_over_SNR_Two_path, 'Marker', 'v', 'LineWidth', 1, 'LineStyle', '-.');
hold on
semilogy(SNR_Range,BER_HA02_over_SNR_EPA, 'Marker', 'd', 'LineWidth', 1, 'LineStyle', ':');
hold on
semilogy(SNR_Range,BER_HA02_over_SNR_EVA, 'Marker', 'h', 'LineWidth', 1, 'LineStyle', '--');
hold on
semilogy(SNR_Range,BER_HA02_over_SNR_ETU, 'Marker', 'h', 'LineWidth', 1);
hold on
semilogy(SNR_Range,BER_HA02_over_SNR_DC1, 'Marker', 'x', 'LineWidth', 1, 'LineStyle', '--');
hold on
semilogy(SNR_Range,BER_HA02_over_SNR_DC2, 'Marker', 's', 'LineWidth', 1);
hold on
semilogy(SNR_Range,BER_HA02_over_SNR_DC3, 'Marker', 'd', 'LineWidth', 1);

ylim([1e-4 1e4])

legend('LS estimate tested on the designed channel', ...
    'MMSE estimate tested on the designed channel', ...
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
ylabel('BER');
title('BER performance of Channelformer on fixed PDP channels');
grid on;
hold off;

figure;
semilogy(SNR_Range,BER_LS_over_SNR, 'Marker', '*', 'LineWidth', 1);
hold on
semilogy(SNR_Range,BER_MMSE_over_SNR, 'Marker', 's', 'LineWidth', 1, 'LineStyle', '--');
hold on
semilogy(SNR_Range,BER_SimpleNet_over_SNR_train, 'Marker', 'o', 'LineWidth', 1);
hold on
semilogy(SNR_Range,BER_SimpleNet_over_SNR_flat, 'Marker', '+', 'LineWidth', 1, 'LineStyle', ':');
hold on
semilogy(SNR_Range,BER_SimpleNet_over_SNR_Two_path, 'Marker', 'v', 'LineWidth', 1, 'LineStyle', '-.');
hold on
semilogy(SNR_Range,BER_SimpleNet_over_SNR_EPA, 'Marker', 'd', 'LineWidth', 1, 'LineStyle', ':');
hold on
semilogy(SNR_Range,BER_SimpleNet_over_SNR_EVA, 'Marker', 'h', 'LineWidth', 1, 'LineStyle', '--');
hold on
semilogy(SNR_Range,BER_SimpleNet_over_SNR_ETU, 'Marker', 'h', 'LineWidth', 1);
hold on
semilogy(SNR_Range,BER_SimpleNet_over_SNR_DC1, 'Marker', 'x', 'LineWidth', 1, 'LineStyle', '--');
hold on
semilogy(SNR_Range,BER_SimpleNet_over_SNR_DC2, 'Marker', 's', 'LineWidth', 1);
hold on
semilogy(SNR_Range,BER_SimpleNet_over_SNR_DC3, 'Marker', 'd', 'LineWidth', 1);

ylim([1e-4 1e4])

legend('LS estimate tested on the designed channel', ...
    'MMSE estimate tested on the designed channel', ...
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
ylabel('BER');
title('BER performance of SimpleNet on fixed PDP channels');
grid on;
hold off;
