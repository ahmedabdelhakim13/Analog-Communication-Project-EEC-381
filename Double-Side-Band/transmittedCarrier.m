function DSB_TC = transmittedCarrier(carrier, signal, modIndex, f_Sampling)
    amplitude = max(signal);
    DSB_TC = (1 + modIndex * signal / amplitude) .* carrier;

    len = length(DSB_TC);
    DSB_TC_Freq = fftshift(fft(DSB_TC));
    freq = f_Sampling/2 * linspace(-1, 1, len);

    figure;
    plot(freq, abs(DSB_TC_Freq) / len);
    title('Double Side Band Transmitted Carrier');
end