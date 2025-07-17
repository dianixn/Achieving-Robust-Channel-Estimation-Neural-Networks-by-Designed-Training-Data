function h = channel_impulse(PathDelays, AveragePathGains, SampleRate)

PathDelays = PathDelays .* SampleRate;

AveragePathGains = 10 .^ (AveragePathGains / 10);

N_f = 72;

n = 1 : N_f - 1;

h_tem = zeros(1, N_f);

h_temp = zeros(1, N_f);

for i = 1:size(PathDelays, 2)

    if PathDelays(i) == 0
    
        h_temp(1) = AveragePathGains(i) * exp(-1j * sym(pi) / N_f * ((N_f - 1) * PathDelays(i))) .* N_f;
    
    else

        h_temp(1) = AveragePathGains(i) * exp(-1j * sym(pi) / N_f * ((N_f - 1) * PathDelays(i))) .* (sin(pi * PathDelays(i)) ./ sin(sym(pi) / N_f * (PathDelays(i))));

    end

    h_temp(2:end) = AveragePathGains(i) * (sin(sym(pi) * PathDelays(i)) * exp(-1j * pi / N_f * (n + (N_f - 1) * PathDelays(i))) ./ sin(sym(pi) / N_f * (PathDelays(i) - n)));

    h_tem = h_tem + h_temp; 

end

h = (1/sqrt(N_f)) * h_tem;
