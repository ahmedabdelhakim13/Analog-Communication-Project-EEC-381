function DSB_SC = supprassedCarrier(carrier, signal, f_Sampling)
    DSB_SC = signal .* carrier;

    len = length(DSB_SC);
    DSB_SC_Freq = fftshift(fft(DSB_SC));
    freq = f_Sampling/2 * linspace(-1, 1, len);

    figure;
    plot(freq, abs(DSB_SC_Freq) / len);
    title('Double Side Band Suppressed Carrier');
end