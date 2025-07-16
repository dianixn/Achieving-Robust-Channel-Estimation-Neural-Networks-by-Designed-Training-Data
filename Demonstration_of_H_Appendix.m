SNR_Range = 5:5:25;
Num_of_frame_each_SNR = 5000;

MSE_LS_over_SNR = zeros(length(SNR_Range), 1);
MSE_DNN_over_SNR = zeros(length(SNR_Range), 1);
MSE_SimpleNet_over_SNR = zeros(length(SNR_Range), 1);
MSE_HA02_over_SNR = zeros(length(SNR_Range), 1);

% Import Deep Neuron Network
%load('InterpolateNet_Appendix.mat');
load('InterpolateNet_mix.mat');

load('SimpleNet_Appendix.mat');

load('parameters_Appendix.mat');

Parameter.parameters

MaxDopplerShift = 97; 

for SNR = SNR_Range

M = 4; % QPSK
k = log2(M);

Num_of_QPSK_symbols = Num_of_FFT * Num_of_symbols * Num_of_frame_each_SNR;
Num_of_bits = Num_of_QPSK_symbols * k;

LS_MSE_in_frame = zeros(Num_of_frame_each_SNR, 1);
DNN_MSE_in_frame = zeros(Num_of_frame_each_SNR, 1);
SimpleNet_MSE_in_frame = zeros(Num_of_frame_each_SNR, 1);
HA02_MSE_in_frame = zeros(Num_of_frame_each_SNR, 1);

for Frame = 1 : Num_of_frame_each_SNR

% Data generation
N = Num_of_FFT * Num_of_symbols;
data = randi([0 1], N, k);
Data = reshape(data, [], 1);
dataSym = bi2de(data);

% QPSK modulator
QPSK_symbol = OFDM.QPSK_Modualtor(dataSym);
QPSK_signal = reshape(QPSK_symbol, Num_of_FFT, Num_of_symbols);

% Pilot inserted
[data_in_IFFT, data_location] = OFDM.Pilot_Insert(Pilot_value_user, Pilot_location_symbols, Pilot_location, Frame_size, Num_of_FFT, QPSK_signal);
[data_for_channel, ~] = OFDM.Pilot_Insert(1, Pilot_location_symbols, kron((1 : Num_of_FFT)', ones(1, Num_of_pilot)), Frame_size, Num_of_FFT, (ones(Num_of_FFT, Num_of_symbols)));

% OFDM Transmitter
[Transmitted_signal, ~] = OFDM.OFDM_Transmitter(data_in_IFFT, Num_of_FFT, length_of_CP);
[Transmitted_signal_for_channel, ~] = OFDM.OFDM_Transmitter(data_for_channel, Num_of_FFT, length_of_CP);

% Channel

SNR_OFDM = SNR;
Doppler_shift = randi([0, MaxDopplerShift]);
[Multitap_Channel_Signal, Multitap_Channel_Signal_user, Multitap_Channel_Signal_user_for_channel] = Channel.Propagation_Channel_Model(Transmitted_signal, Transmitted_signal_for_channel, SNR_OFDM, SampleRate, Carrier_Frequency, PathDelays, AveragePathGains, Doppler_shift, DelayProfile);

% OFDM Receiver
[Unrecovered_signal, RS_User] = OFDM.OFDM_Receiver(Multitap_Channel_Signal, Num_of_FFT, length_of_CP, length_of_symbol, Multitap_Channel_Signal_user);
[~, RS] = OFDM.OFDM_Receiver(Multitap_Channel_Signal_user_for_channel, Num_of_FFT, length_of_CP, length_of_symbol, Multitap_Channel_Signal_user_for_channel);

[Received_pilot, ~] = OFDM.Pilot_extract(RS_User, Pilot_location, Num_of_pilot, Pilot_location_symbols, data_location);
H_Ref = Received_pilot ./ Pilot_value_user;

% Channel estimation

% LS

[R, ~] = OFDM.Pilot_extract(RS, Pilot_location, Num_of_pilot, Pilot_location_symbols, data_location);

[Received_pilot_LS, ~] = OFDM.Pilot_extract(Unrecovered_signal, Pilot_location, Num_of_pilot, Pilot_location_symbols, data_location);

H_LS = CSI.LS(Received_pilot_LS, Pilot_value_user);

MSE_LS = mean(abs(H_LS - R).^2, 'all');

% Deep learning

Neural_Network_Input(:, :, 1) = real(H_LS);
Neural_Network_Input(:, :, 2) = imag(H_LS);

H_DNN_feature = predict(InterpolateNet, Neural_Network_Input);

H_DNN = H_DNN_feature(:, :, 1) + 1j * H_DNN_feature(:, :, 2);

MSE_DNN = mean(abs(H_DNN - RS).^2, 'all');

% SimpleNet

H_SimpleNet_feature = predict(SimpleNet, Neural_Network_Input);

H_SimpleNet_frame = H_SimpleNet_feature(:, :, 1) + 1j * H_SimpleNet_feature(:, :, 2);

MSE_SimpleNet_frame = mean(abs(H_SimpleNet_frame - R).^2, 'all');

% HA03

Feature_signal(:, 1, 1) = reshape(real(H_LS), [], 1);
Feature_signal(:, 2, 1) = reshape(imag(H_LS), [], 1);
Feature_signal = dlarray(Feature_signal);

H_HA02_feature = transformer.model(Feature_signal, parameters);

H_HA02_frame = reshape(extractdata(H_HA02_feature(:, 1)), 36, 4) + 1j * reshape(extractdata(H_HA02_feature(:, 2)), 36, 4);

MSE_HA02_frame = mean(abs(H_HA02_frame - R).^2, 'all');

% LS MSE calculation in each frame
LS_MSE_in_frame(Frame, 1) = MSE_LS;

% DNN MSE calculation in each frame
DNN_MSE_in_frame(Frame, 1) = MSE_DNN;

SimpleNet_MSE_in_frame(Frame, 1) = MSE_SimpleNet_frame;

HA02_MSE_in_frame(Frame, 1) = MSE_HA02_frame;

end

% MSE calculation
MSE_LS_over_SNR(SNR_Range == SNR, 1) = sum(LS_MSE_in_frame, 1) / Num_of_frame_each_SNR;

MSE_DNN_over_SNR(SNR_Range == SNR, 1) = sum(DNN_MSE_in_frame, 1) / Num_of_frame_each_SNR;

MSE_SimpleNet_over_SNR(SNR_Range == SNR, 1) = sum(SimpleNet_MSE_in_frame, 1) / Num_of_frame_each_SNR;

MSE_HA02_over_SNR(SNR_Range == SNR, 1) = sum(HA02_MSE_in_frame, 1) / Num_of_frame_each_SNR;

end
