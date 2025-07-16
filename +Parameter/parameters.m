% Parameters

M = 4; % QPSK
k = log2(M);

Num_of_subcarriers = 71; 
Num_of_FFT = Num_of_subcarriers + 1; % 5G also deploy DC subcarrier, so dont remove DC
length_of_CP = 10 + 7;

Num_of_symbols = 10;
Num_of_pilot = 4;
Frame_size = Num_of_symbols + Num_of_pilot;

Pilot_location_symbols = [3, 6, 9, 12];
Pilot_location = [(2 : 2 : Num_of_FFT)', (2 : 2 : Num_of_FFT)', (2 : 2 : Num_of_FFT)', (2 : 2 : Num_of_FFT)'];
Pilot_value_user = 1 + 1j;

length_of_symbol = Num_of_FFT + length_of_CP;

Frequency_Spacing = 15e3;

Carrier_Frequency = 2.1e9;
Max_Mobile_Speed = 50; % km/h

SampleRate = Num_of_subcarriers * Frequency_Spacing; 
%PathDelays = [0 30 70 90 110 190 410] * 1e-9; % EPA
%AveragePathGains = [0 -1 -2 -3 -8 -17.2 -20.8]; % EPA
%PathDelays = [0 30 150 310 370 710 1090 1730 2510] * 1e-9; % EVA
%AveragePathGains = [0 -1.5 -1.4 -3.6 -0.6 -9.1 -7 -12 -16.9]; % EVA
%PathDelays = [0 50 120 200 230 500 1600 2300 5000] * 1e-9; % ETU
%AveragePathGains = [-1.0 -1.0 -1.0 0.0 0.0 0.0 -3.0 -5.0 -7.0]; % ETU

%PathDelays = 0; 
%AveragePathGains = 0.0; 

%PathDelays = [0 50 100 200 400] * 1e-9; % DC1
%AveragePathGains = [0.0 -2.0 -4.0 -8.0 -16.0]; % DC1

%PathDelays = [0 50 120 200 230 500 1600] * 1e-9; % DC2
%AveragePathGains = [-7.0 -3.0 -1.0 0.0 -2.0 -5.0 -7.0]; % DC2

%PathDelays = [0 5000] * 1e-9; 
%AveragePathGains = [-3.0 -3.0]; 

%PathDelays = [0 30 200 300 500 1500 2500 5000 7000 9000] * 1e-9; 
%AveragePathGains = [0.0 0 0 0.0 0.0 0.0 -1.0 -1.0 -2.0 -3.0]; 

%PathDelays = [0 50 120 200 230 500 1600 2300 5000 7000] * 1e-9; % DC3
%AveragePathGains = [0.0 -1.0 -1.0 -1.0 -1.0 -1.5 -1.5 -1.5 -3.0 -5.0]; % DC3

PathDelays = [0:300:9300] * 1e-9; 
AveragePathGains = zeros(1, size(PathDelays, 2)); 

% Appendix

%PathDelays = 0; 
%AveragePathGains = 0; 

%PathDelays = [0 5000] * 1e-9; 
%AveragePathGains = [-3.0 -3.0]; 

%PathDelays = [0 50 120 200 500 1000 1600] * 1e-9; % DC2
%AveragePathGains = [-7.0 -3.0 -14.0 0.0 -12.0 -5.0 -9.0]; % DC2

%PathDelays = [0 50 120 200 230 500 1600 2300 5000 7000] * 1e-9; % DC3
%AveragePathGains = [0.0 -14.0 -15.0 -1.0 -5.0 -1 -15 -10 -10 -5.0]; % DC3


MaxDopplerShift = floor((Carrier_Frequency * Max_Mobile_Speed) / (physconst('lightspeed') * 3.6));

DelayProfile = 'Custom'; % 'EPA' 'EVA' 'ETU' 'Custom' 
