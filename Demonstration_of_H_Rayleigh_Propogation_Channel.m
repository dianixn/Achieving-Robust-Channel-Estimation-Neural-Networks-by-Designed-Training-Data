SNR_Range = 0:5:30;
Num_of_frame_each_SNR = 5000;

MSE_LS_over_SNR = zeros(length(SNR_Range), 1);
MSE_MMSE_over_SNR = zeros(length(SNR_Range), 1);
MSE_DNN_over_SNR = zeros(length(SNR_Range), 1);
MSE_SimpleNet_over_SNR = zeros(length(SNR_Range), 1);
MSE_HA02_over_SNR = zeros(length(SNR_Range), 1);

BER_LS_over_SNR = zeros(length(SNR_Range), 1);
BER_MMSE_over_SNR = zeros(length(SNR_Range), 1);
BER_DNN_over_SNR = zeros(length(SNR_Range), 1);
BER_SimpleNet_over_SNR = zeros(length(SNR_Range), 1);
BER_HA02_over_SNR = zeros(length(SNR_Range), 1);

% Import Deep Neuron Network
load('InterpolateNet_CE.mat');

% Import Deep Neuron Network
load('SimpleNet_CE.mat');

% Import HA03 Network
load('parameters_CE.mat');

Parameter.parameters

for SNR = SNR_Range

M = 4; % QPSK
k = log2(M);

Num_of_QPSK_symbols = Num_of_FFT * Num_of_symbols * Num_of_frame_each_SNR;
Num_of_bits = Num_of_QPSK_symbols * k;

LS_MSE_in_frame = zeros(Num_of_frame_each_SNR, 1);
MMSE_MSE_in_frame = zeros(Num_of_frame_each_SNR, 1);
DNN_MSE_in_frame = zeros(Num_of_frame_each_SNR, 1);
SimpleNet_MSE_in_frame = zeros(Num_of_frame_each_SNR, 1);
HA02_MSE_in_frame = zeros(Num_of_frame_each_SNR, 1);

Frame_error_LS = 0;
Frame_error_MMSE = 0;
Frame_error_DNN = 0;
Frame_error_SimpleNet = 0;
Frame_error_HA02 = 0;

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
[Received_pilot_LS, ~] = OFDM.Pilot_extract(Unrecovered_signal, Pilot_location, Num_of_pilot, Pilot_location_symbols, data_location);

H_LS = CSI.LS(Received_pilot_LS, Pilot_value_user);

H_LS_frame = imresize(H_LS, [Num_of_FFT, max(Pilot_location_symbols)]);
H_LS_frame(:, max(Pilot_location_symbols) + 1 : Frame_size) = kron(H_LS_frame(:, max(Pilot_location_symbols)), ones(1, Frame_size - max(Pilot_location_symbols)));

MSE_LS_frame = mean(abs(H_LS_frame - RS).^2, 'all');

% MMSE

% linear MMSE

H_MMSE = CSI.MMSE(H_Ref, RS, Pilot_location, Pilot_location_symbols, Num_of_FFT, SNR, Num_of_pilot, H_LS);

H_MMSE_frame = imresize(H_MMSE, [Num_of_FFT, max(Pilot_location_symbols)]);
H_MMSE_frame(:, max(Pilot_location_symbols) + 1 : Frame_size) = kron(H_MMSE_frame(:, max(Pilot_location_symbols)), ones(1, Frame_size - max(Pilot_location_symbols)));

MSE_MMSE_frame = mean(abs(H_MMSE_frame - RS).^2, 'all');

% MMSE

% Pre-error 

h_A = channel_impulse(PathDelays, AveragePathGains, SampleRate); 

h_A = abs(h_A).^2 / sum(abs(h_A).^2, 'all');

%PathDelays_D = [0 30 200 300 500 1500 2500 5000 7000 9000] * 1e-9; 
%AveragePathGains_D = [0.0 0 0 0.0 0.0 0.0 -1.0 -1.0 -2.0 -3.0]; 

PathDelays_D = 0; 
AveragePathGains_D = 0.0; 

%PathDelays_D = [0 30 70 90 110 190 410] * 1e-9; % EPA
%AveragePathGains_D = [0 -1 -2 -3 -8 -17.2 -20.8]; % EPA

%PathDelays_D = [0 50 120 200 230 500 1600 2300 5000] * 1e-9; % ETU
%AveragePathGains_D = [-1.0 -1.0 -1.0 0.0 0.0 0.0 -3.0 -5.0 -7.0]; % ETU

%PathDelays_D = [0 50 120 200 230 500 1600 2300 5000 7000] * 1e-9; % DC3
%AveragePathGains_D = [0.0 -1.0 -1.0 -1.0 -1.0 -1.5 -1.5 -1.5 -3.0 -5.0]; % DC3

h_D = channel_impulse(PathDelays_D, AveragePathGains_D, SampleRate); 

h_D = abs(h_D).^2 / sum(abs(h_D).^2, 'all'); 

SNR_Q = 10^(SNR_OFDM/10); 

% Q 

Z = (diag(h_D)+(1/SNR_Q)*eye(Num_of_FFT))*diag(h_D); 

Q = (1/Num_of_FFT) * trace(dftmtx(Num_of_FFT) * diag(h_A)*(2*Z-Z.^2) * pinv(dftmtx(Num_of_FFT))); 

% error 

error = (1/Num_of_FFT) * trace(dftmtx(Num_of_FFT) * (eye(Num_of_FFT) + (1 / SNR_Q)*Z*Z - diag(h_A)*(2*Z-Z.^2)) * pinv(dftmtx(Num_of_FFT))); 

% Deep learning

Neural_Network_Input(:, :, 1) = real(H_LS);
Neural_Network_Input(:, :, 2) = imag(H_LS);

H_DNN_feature = predict(InterpolateNet, Neural_Network_Input);

H_DNN_frame = H_DNN_feature(:, :, 1) + 1j * H_DNN_feature(:, :, 2);

MSE_DNN_frame = mean(abs(H_DNN_frame - RS).^2, 'all');

% SimpleNet

H_SimpleNet_feature = predict(SimpleNet, Neural_Network_Input);

H_SimpleNet_frame = H_SimpleNet_feature(:, :, 1) + 1j * H_SimpleNet_feature(:, :, 2);

MSE_SimpleNet_frame = mean(abs(H_SimpleNet_frame - RS).^2, 'all');

% HA03

Feature_signal(:, 1, 1) = reshape(real(H_LS), [], 1);
Feature_signal(:, 2, 1) = reshape(imag(H_LS), [], 1);
Feature_signal = dlarray(Feature_signal);

H_HA02_feature = transformer.model(Feature_signal, parameters);

H_HA02_frame = reshape(extractdata(H_HA02_feature(:, 1)), Num_of_FFT, Frame_size) + 1j * reshape(extractdata(H_HA02_feature(:, 2)), Num_of_FFT, Frame_size);

MSE_HA02_frame = mean(abs(H_HA02_frame - RS).^2, 'all');

% QPSK demodulation

LS_recover_signal = Unrecovered_signal .* conj(H_LS_frame) ./ (abs(H_LS_frame) .^ 2);
MMSE_recover_signal = Unrecovered_signal .* conj(H_MMSE_frame) ./ (abs(H_MMSE_frame) .^ 2);
DNN_recover_signal = Unrecovered_signal .* conj(H_DNN_frame) ./ (abs(H_DNN_frame) .^ 2);
SimpleNet_recover_signal = Unrecovered_signal .* conj(H_SimpleNet_frame) ./ (abs(H_SimpleNet_frame) .^ 2);
HA02_recover_signal = Unrecovered_signal .* conj(H_HA02_frame) ./ (abs(H_HA02_frame) .^ 2);

[~, LS_recover_data] = OFDM.Pilot_extract(LS_recover_signal, Pilot_location, Num_of_pilot, Pilot_location_symbols, data_location);
[~, MMSE_recover_data] = OFDM.Pilot_extract(MMSE_recover_signal, Pilot_location, Num_of_pilot, Pilot_location_symbols, data_location);
[~, DNN_recover_data] = OFDM.Pilot_extract(DNN_recover_signal, Pilot_location, Num_of_pilot, Pilot_location_symbols, data_location);
[~, SimpleNet_recover_data] = OFDM.Pilot_extract(SimpleNet_recover_signal, Pilot_location, Num_of_pilot, Pilot_location_symbols, data_location);
[~, HA02_recover_data] = OFDM.Pilot_extract(HA02_recover_signal, Pilot_location, Num_of_pilot, Pilot_location_symbols, data_location);

LS_dataSym = OFDM.QPSK_Demodulator(reshape(LS_recover_data, [], 1));
MMSE_dataSym = OFDM.QPSK_Demodulator(reshape(MMSE_recover_data, [], 1));
DNN_dataSym = OFDM.QPSK_Demodulator(reshape(DNN_recover_data, [], 1));
SimpleNet_dataSym = OFDM.QPSK_Demodulator(reshape(SimpleNet_recover_data, [], 1));
HA02_dataSym = OFDM.QPSK_Demodulator(reshape(HA02_recover_data, [], 1));

Data_LS = reshape(de2bi(LS_dataSym), [], 1);
Data_MMSE = reshape(de2bi(MMSE_dataSym), [], 1);
Data_DNN = reshape(de2bi(DNN_dataSym), [], 1);
Data_SimpleNet = reshape(de2bi(SimpleNet_dataSym), [], 1);
Data_HA02 = reshape(de2bi(HA02_dataSym), [], 1);

Error_LS = sum(round(Data_LS) ~= round(Data));
Error_MMSE = sum(round(Data_MMSE) ~= round(Data));
Error_DNN = sum(round(Data_DNN) ~= round(Data));
Error_SimpleNet = sum(round(Data_SimpleNet) ~= round(Data));
Error_HA02 = sum(round(Data_HA02) ~= round(Data));

Frame_error_LS = Frame_error_LS + Error_LS;
Frame_error_MMSE = Frame_error_MMSE + Error_MMSE;
Frame_error_DNN = Frame_error_DNN + Error_DNN;
Frame_error_SimpleNet = Frame_error_SimpleNet + Error_SimpleNet;
Frame_error_HA02 = Frame_error_HA02 + Error_HA02;

% LS MSE calculation in each frame
LS_MSE_in_frame(Frame, 1) = MSE_LS_frame;

% MMSE MSE calculation in each frame
MMSE_MSE_in_frame(Frame, 1) = MSE_MMSE_frame;

% DNN MSE calculation in each frame
DNN_MSE_in_frame(Frame, 1) = MSE_DNN_frame;

% Transformer MSE calculation in each frame
SimpleNet_MSE_in_frame(Frame, 1) = MSE_SimpleNet_frame;

% HA02 MSE calculation in each frame
HA02_MSE_in_frame(Frame, 1) = MSE_HA02_frame;

end

% MSE calculation
MSE_LS_over_SNR(SNR_Range == SNR, 1) = sum(LS_MSE_in_frame, 1) / Num_of_frame_each_SNR;

MSE_MMSE_over_SNR(SNR_Range == SNR, 1) = sum(MMSE_MSE_in_frame, 1) / Num_of_frame_each_SNR;

Q_set(SNR_Range == SNR, 1) = Q;

error_set(SNR_Range == SNR, 1) = error;

MSE_DNN_over_SNR(SNR_Range == SNR, 1) = sum(DNN_MSE_in_frame, 1) / Num_of_frame_each_SNR;

MSE_SimpleNet_over_SNR(SNR_Range == SNR, 1) = sum(SimpleNet_MSE_in_frame, 1) / Num_of_frame_each_SNR;

MSE_HA02_over_SNR(SNR_Range == SNR, 1) = sum(HA02_MSE_in_frame, 1) / Num_of_frame_each_SNR;

% BER calculation
BER_LS_over_SNR(SNR_Range == SNR, 1) = Frame_error_LS / (Num_of_frame_each_SNR * N * k);

BER_MMSE_over_SNR(SNR_Range == SNR, 1) = Frame_error_MMSE / (Num_of_frame_each_SNR * N * k);

BER_DNN_over_SNR(SNR_Range == SNR, 1) = Frame_error_DNN / (Num_of_frame_each_SNR * N * k);

BER_SimpleNet_over_SNR(SNR_Range == SNR, 1) = Frame_error_SimpleNet / (Num_of_frame_each_SNR * N * k);

BER_HA02_over_SNR(SNR_Range == SNR, 1) = Frame_error_HA02 / (Num_of_frame_each_SNR * N * k);

end
