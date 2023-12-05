function coherentDetection(dB, signal, carrierFreq, time, cutoffFreq, f_Sampling,phase )
    snr_dB = awgn(signal, dB);
    demodSignal = snr_dB .* cos( 2 * pi * carrierFreq * time + phase);

    demodSignalFreq = fftshift(fft(demodSignal));
    len = length(demodSignal);
    freq = f_Sampling / 2*linspace(-1, 1, len);
    demodSignalFreq(freq >= cutoffFreq | freq <= -cutoffFreq) = 0;

    figure;
    plot(freq, abs(demodSignalFreq) / len);
    if (carrierFreq ~= 100000)
        title(sprintf("Spectrum With SNR= %d dB and Frequency Error", dB));
    elseif (phase ~= 0)
        title(sprintf("Spectrum With SNR= %d dB and Phase Error", dB));
    else
        title(sprintf("Spectrum With SNR= %d dB", dB));
    end

    demodSignal = ifft(ifftshift(demodSignalFreq));

    figure;
    plot(time, demodSignal);
    if (carrierFreq ~= 100000)
        title(sprintf("Time Domain With SNR= %d dB and Frequency Error", dB));
    elseif (phase ~= 0)
        title(sprintf("Time Domain With SNR= %d dB and Phase Error", dB));
    else
        title(sprintf("Time Domain With SNR= %d dB", dB));
    end

    demodSignal = resample(demodSignal, f_Sampling / 5, f_Sampling);
    sound(abs(demodSignal), f_Sampling / 5);
end