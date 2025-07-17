figure;
semilogy(SNR_Range,MSE_LS_over_SNR, 'Marker', '*', 'LineWidth', 1);
hold on
semilogy(SNR_Range,MSE_DNN_over_SNR, 'Marker', 's', 'LineWidth', 1);
hold on
semilogy(SNR_Range,MSE_SimpleNet_over_SNR, 'Marker', 'v', 'LineWidth', 1);
hold on
semilogy(SNR_Range,MSE_HA02_over_SNR, 'Marker', 'd', 'LineWidth', 1);

ylim([1e-4 1e4])

legend('LS estimate', ...
    'InterpolateNet', ...
    'SimpleNet', ...
    'Channelformer'); 

xlabel('SNR in dB');
ylabel('MSE');
title('Estimate errors tested on the designed channel');
grid on;
hold off;

figure;
semilogy(SNR_Range,MSE_DNN_over_SNR_flat, 'Marker', '+', 'LineWidth', 1);
hold on
semilogy(SNR_Range,MSE_DNN_over_SNR_Two, 'Marker', 'v', 'LineWidth', 1);
hold on
semilogy(SNR_Range,MSE_DNN_over_SNR_EPA, 'Marker', 'd', 'LineWidth', 1);
hold on
semilogy(SNR_Range,MSE_DNN_over_SNR_2, 'Marker', 'h', 'LineWidth', 1);
hold on
semilogy(SNR_Range,MSE_DNN_over_SNR_3, 'Marker', 's', 'LineWidth', 1);

ylim([1e-4 1e4])

legend('InterpolateNet tested on the flat fading channel', ...
    'InterpolateNet tested on the Two path channel', ...
    'InterpolateNet tested on the EPA channel', ...
    'InterpolateNet tested on the Additional channel 1', ...
    'InterpolateNet tested on the Additional channel 2'); 

xlabel('SNR in dB');
ylabel('MSE');
title('Adaption of InterpolateNet to different channels');
grid on;
hold off;
