Channel = 1:5;
figure;
semilogy(Channel,MSE_DNN_over_SNR_batch_16, 'Marker', '*', 'LineWidth', 1);
hold on
semilogy(Channel,MSE_DNN_over_SNR_batch_32, 'Marker', 's', 'LineWidth', 1);
hold on
semilogy(Channel,MSE_DNN_over_SNR_batch_64, 'Marker', 'o', 'LineWidth', 1);
hold on
semilogy(Channel,MSE_DNN_over_SNR_batch_96, 'Marker', '+', 'LineWidth', 1);
hold on
semilogy(Channel,MSE_DNN_over_SNR_batch_128, 'Marker', '|', 'LineWidth', 1);
hold on
semilogy(Channel,MSE_HA02_over_SNR_batch_16, 'Marker', '*', 'LineWidth', 1, 'LineStyle', '--');
hold on
semilogy(Channel,MSE_HA02_over_SNR_batch_32, 'Marker', 's', 'LineWidth', 1, 'LineStyle', '--');
hold on
semilogy(Channel,MSE_HA02_over_SNR_batch_64, 'Marker', 'o', 'LineWidth', 1, 'LineStyle', '--');
hold on
semilogy(Channel,MSE_HA02_over_SNR_batch_96, 'Marker', '+', 'LineWidth', 1, 'LineStyle', '--');
hold on
semilogy(Channel,MSE_HA02_over_SNR_batch_128, 'Marker', '|', 'LineWidth', 1, 'LineStyle', '--');
hold on
semilogy(Channel,MSE_SimpleNet_over_SNR_batch_16, 'Marker', '*', 'LineWidth', 1, 'LineStyle', '-.');
hold on
semilogy(Channel,MSE_SimpleNet_over_SNR_batch_32, 'Marker', 's', 'LineWidth', 1, 'LineStyle', '-.');
hold on
semilogy(Channel,MSE_SimpleNet_over_SNR_batch_64, 'Marker', 'o', 'LineWidth', 1, 'LineStyle', '-.');
hold on
semilogy(Channel,MSE_SimpleNet_over_SNR_batch_96, 'Marker', '+', 'LineWidth', 1, 'LineStyle', '-.');
hold on
semilogy(Channel,MSE_SimpleNet_over_SNR_batch_128, 'Marker', '|', 'LineWidth', 1, 'LineStyle', '-.');

ylim([1e-4 1e5])

xticklabels({'Flat fading', 'Two path channel', 'EPA', 'ETU', 'Designed channel'})
xtickangle(0)

legend('InterpolateNet trained with batch size of 16', ...
    'InterpolateNet trained with batch size of 32', ...
    'InterpolateNet trained with batch size of 64', ...
    'InterpolateNet trained with batch size of 96', ...
    'InterpolateNet trained with batch size of 128', ...
    'Channelformer trained with batch size of 16', ...
    'Channelformer trained with batch size of 32', ...
    'Channelformer trained with batch size of 64', ...
    'Channelformer trained with batch size of 96', ...
    'Channelformer trained with batch size of 128', ...
    'SimpleNet trained with batch size of 16', ...
    'SimpleNet trained with batch size of 32', ...
    'SimpleNet trained with batch size of 64', ...
    'SimpleNet trained with batch size of 96', ...
    'SimpleNet trained with batch size of 128'); 

xlabel('Simulation channels');
ylabel('MSE');
title('MSE performance tested with the SNR of 15dB');
grid on;
hold off;
