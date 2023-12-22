function filteredSignal = filtering(cutoffFreq, S_freq, freq, f_Sampling)
    % filtering filters the input frequency-domain signal S_freq based on the cutoff frequency
    % Inputs:
    %   cutoffFreq: Frequency cutoff for filtering in Hz
    %   S_freq: Frequency domain signal
    %   freq: Frequency vector corresponding to the signal
    %   f_Sampling: Sampling frequency in Hz

    % Apply frequency domain filtering by zeroing out frequencies outside cutoff
    S_freq(freq >= cutoffFreq | freq <= -cutoffFreq) = 0;

    % Retrieve the filtered signal in time domain using inverse FFT
    filteredSignal = ifft(ifftshift(S_freq));

    % Compute the length of the filtered signal
    len = length(filteredSignal);

    % Compute the frequency spectrum of the filtered signal
    S_freq = fftshift(fft(filteredSignal));
    freq = f_Sampling / 2 * linspace(-1, 1, len);

    % Plot the frequency spectrum of the filtered signal
    figure;
    plot(freq, abs(S_freq));
    title('Filtered Signal Spectrum'); % Set the title for the plot
end
