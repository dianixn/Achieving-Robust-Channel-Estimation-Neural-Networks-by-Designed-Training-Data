%CDL Channel Model

function [Fading_signal, Fading_signal_noise_free, Reference_Signal] = TDL_Channel(Transmitted_signal, Transmitted_signal_for_channel, SNR, SampleRate, Carrier_Frequency, MaxDopplerShift, DelayProfile, DelaySpread, PathDelays, AveragePathGains)

tdl = nrTDLChannel;
tdl.DelayProfile = DelayProfile;
tdl.MaximumDopplerShift = MaxDopplerShift;
tdl.SampleRate = SampleRate;
tdl.DelaySpread = DelaySpread;

if contains(tdl.DelayProfile,'Custom')
    tdl.AveragePathGains = AveragePathGains;
    tdl.PathDelays = PathDelays; 
    tdl.AnglesAoD = zeros(1, size(PathDelays, 2));
    tdl.AnglesAoA = zeros(1, size(PathDelays, 2));
    tdl.AnglesZoD = 90 * ones(1, size(PathDelays, 2));
    tdl.AnglesZoA = zeros(1, size(PathDelays, 2));
end

tdl.Seed = randi([0, 1e9]);

tdl.NumTransmitAntennas = 1;
tdl.NumReceiveAntennas = 1;

tdl.InitialTime = 0;

Fading_signal_noise_free = tdl(Transmitted_signal);

release(tdl);

tdl.InitialTime = 0;
Reference_Signal = tdl(Transmitted_signal_for_channel);

%release(cdl);

%cdl.InitialTime = 0;
%h = cdl([1; zeros(size(Transmitted_signal_for_channel, 1) - 1, 1)]);

% Noise Generation
SignalPower = mean(abs(Fading_signal_noise_free) .^ 2);
Noise_Variance = SignalPower / (10 ^ (SNR / 10));

Nvariance = sqrt(Noise_Variance / 2);
n = Nvariance * (randn(length(Fading_signal_noise_free), 1) + 1j * randn(length(Fading_signal_noise_free), 1)); % Noise generation

Fading_signal = Fading_signal_noise_free + n;
