function filteredSignal = filtering(cutoffFreq, S_freq, freq, f_Sampling)
    S_freq(freq >= cutoffFreq | freq <= -cutoffFreq) = 0;
    filteredSignal = ifft(ifftshift(S_freq));

    len = length(filteredSignal);
    S_freq = fftshift(fft(filteredSignal));
    freq = f_Sampling/2 * linspace(-1, 1, len);

    figure;
    plot(freq, abs(S_freq)/len);
    title('Filtered Signal Spectrum');
end