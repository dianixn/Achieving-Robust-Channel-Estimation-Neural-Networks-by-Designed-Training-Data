%pathdelay should be normalized by sampling ratio

function correlation = Correlation(AveragePathGains, PathDelays, N_f)

PathDelays = PathDelays * 1065000;

AveragePathGains = 10 .^ (AveragePathGains / 10);

correlation = zeros(N_f, N_f);

for k = 1 : N_f

for l = 1 : N_f

    CoF = zeros(size(PathDelays, 2), 1);

for m = 1 : size(PathDelays, 2)

    Cof = zeros(N_f, 1);

    for n = 1 : N_f

        cof = zeros(N_f, 1);

        for n_1 = 1 : N_f

            if n == 1 && n_1 == 1 && PathDelays(m) == 0

                cof(n_1) = (exp(-1j * pi / N_f * (2 * (k - 1) + 1) * (n - 1))) * (exp(1j * pi / N_f * (2 * (l - 1) + 1) * (n_1 - 1))) * N_f * N_f;
                
            elseif n_1 == 1 && PathDelays(m) == 0

                cof(n_1) = (exp(-1j * pi / N_f * (2 * (k - 1) + 1) * (n - 1))) * (exp(1j * pi / N_f * (2 * (l - 1) + 1) * (n_1 - 1))) * (sin(pi * PathDelays(m)) / sin(pi / N_f * (PathDelays(m) - n + 1))) * N_f;

            elseif n == 1 && PathDelays(m) == 0

                cof(n_1) = (exp(-1j * pi / N_f * (2 * (k - 1) + 1) * (n - 1))) * (exp(1j * pi / N_f * (2 * (l - 1) + 1) * (n_1 - 1))) * N_f * (sin(pi * PathDelays(m)) / sin(pi / N_f * (PathDelays(m) - n_1 + 1)));

            else

                cof(n_1) = (exp(-1j * pi / N_f * (2 * (k - 1) + 1) * (n - 1))) * (exp(1j * pi / N_f * (2 * (l - 1) + 1) * (n_1 - 1))) * ((sin(pi * PathDelays(m)))^2 / (sin(pi / N_f * (PathDelays(m) - n + 1)) * sin(pi / N_f * (PathDelays(m) - n_1 + 1))));

            end

        end

        Cof(n) = sum(cof, 'all') / (N_f ^ 2);

    end

    CoF(m) = abs(AveragePathGains(m)) ^ 2 * sum(Cof, 'all');

end

correlation(k, l) = sum(CoF, 'all');

end

end
