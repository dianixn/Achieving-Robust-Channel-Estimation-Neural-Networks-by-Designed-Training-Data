figure;
semilogy(SNR_Range,MSE_LS_over_SNR, 'Marker', '*', 'LineWidth', 1);
hold on
semilogy(SNR_Range,MSE_MMSE_over_SNR, 'Marker', 's', 'LineWidth', 1, 'LineStyle', '--');
hold on
semilogy(SNR_Range,MSE_SimpleNet_over_SNR_CE, 'Marker', 'o', 'LineWidth', 1);
hold on
semilogy(SNR_Range,MSE_SimpleNet_over_SNR_train, 'Marker', 'o', 'LineWidth', 1, 'LineStyle', '--');
hold on
semilogy(SNR_Range,MSE_SimpleNet_over_SNR_flat, 'Marker', '+', 'LineWidth', 1, 'LineStyle', ':');
hold on
semilogy(SNR_Range,MSE_SimpleNet_over_SNR_Two_path, 'Marker', 'v', 'LineWidth', 1, 'LineStyle', '-.');
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

legend('LS estimate tested on the CE channel', ...
    'MMSE estimate tested on the CE channel', ...
    'SimpleNet tested on the CE channel', ...
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
title('Generalization of SimpleNet to fixed PDP channels');
grid on;
hold off;
