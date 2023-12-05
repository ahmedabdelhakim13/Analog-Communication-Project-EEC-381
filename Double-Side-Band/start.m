function [signal, f_Sampling, S_freq, freq] = start(filename)
    [signal, f_Sampling] = audioread(filename);
    len = length(signal);
    S_freq = fftshift(fft(signal));
    freq = (f_Sampling/2) * linspace(-1, 1, len);

    figure;
    plot(freq, abs(S_freq)/len);
    title('Signal Spectrum');
end