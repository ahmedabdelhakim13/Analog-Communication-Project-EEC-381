function coherentDetection(dB, signal, carrierFreq, time, cutoffFreq, f_Sampling, phase)
    % coherentDetection performs coherent detection of a modulated signal
    % Inputs:
    %   dB: Signal-to-noise ratio in decibels
    %   signal: Input signal to be detected
    %   carrierFreq: Carrier frequency of the signal
    %   time: Time vector corresponding to the signal
    %   cutoffFreq: Frequency cutoff for filtering in Hz
    %   f_Sampling: Sampling frequency in Hz
    %   phase: Phase of the carrier signal in radians

    % Add white Gaussian noise to the input signal based on given SNR
    snr_dB = awgn(signal, dB);

    % Demodulate the signal using coherent detection
    demodSignal = snr_dB .* cos(2 * pi * carrierFreq * time + phase);

    % Compute the frequency spectrum of the demodulated signal
    demodSignalFreq = fftshift(fft(demodSignal));
    len = length(demodSignal);
    freq = f_Sampling / 2 * linspace(-1, 1, len);

    % Apply frequency domain filtering by zeroing out frequencies outside cutoff
    demodSignalFreq(freq >= cutoffFreq | freq <= -cutoffFreq) = 0;

    % Plot the frequency spectrum
    figure;
    plot(freq, abs(demodSignalFreq));

    % Set title based on the presence of frequency or phase error
    if (carrierFreq ~= 100000)
        title(sprintf("Spectrum With SNR= %d dB and Frequency Error", dB));
    elseif (phase ~= 0)
        title(sprintf("Spectrum With SNR= %d dB and Phase Error", dB));
    else
        title(sprintf("Spectrum With SNR= %d dB", dB));
    end

    % Retrieve the demodulated signal from frequency domain
    demodSignal = ifft(ifftshift(demodSignalFreq));

    % Plot the demodulated signal in time domain
    figure;
    plot(time, demodSignal);

    % Set title based on the presence of frequency or phase error in time domain
    if (carrierFreq ~= 100000)
        title(sprintf("Time Domain With SNR= %d dB and Frequency Error", dB));
    elseif (phase ~= 0)
        title(sprintf("Time Domain With SNR= %d dB and Phase Error", dB));
    else
        title(sprintf("Time Domain With SNR= %d dB", dB));
    end

    % Resample the demodulated signal and play the audio
    demodSignal = resample(demodSignal, f_Sampling / 5, f_Sampling);
    sound(abs(demodSignal), f_Sampling / 5);
end
