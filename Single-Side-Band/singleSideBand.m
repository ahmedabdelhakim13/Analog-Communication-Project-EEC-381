function SSB_LSB = singleSideBand(DSB_SC, f_Sampling, carrierFreq)
    % singleSideBand - Generates Single Side Band (SSB) modulation by suppressing one sideband.
    % Inputs:
    %   DSB_SC: Double Side Band Suppressed Carrier signal.
    %   f_Sampling: Sampling frequency of the input signal.
    %   carrierFreq: Carrier frequency used in modulation.

    % Copy the input signal to SSB_LSB
    SSB_LSB = DSB_SC;
    
    % Calculate length and frequency vector
    len = length(SSB_LSB);
    freq = f_Sampling/2 * linspace(-1, 1, len);
    
    % Compute frequency domain representation
    S_freq = fftshift(fft(SSB_LSB));
    
    % Suppress one sideband by setting frequencies outside the desired range to zero
    S_freq(freq >= carrierFreq | freq <= -carrierFreq) = 0;
    
    % Perform inverse FFT to get the time-domain signal
    SSB_LSB = ifft(ifftshift(S_freq));
    
    % Plot the magnitude of the frequency domain representation
    figure;
    plot(freq, abs(S_freq)/len);
    title('Single Side Band in frequency Domain');
end
