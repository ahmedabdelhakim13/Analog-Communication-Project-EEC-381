function singleSideBandDemodulation(SSB, carrierFreq, timeVector, f_S, cutoffFreq)
    % singleSideBandDemodulation - Performs demodulation of Single Side Band (SSB) signal.
    % Inputs:
    %   SSB: Single Side Band modulated signal.
    %   carrierFreq: Carrier frequency used in modulation.
    %   timeVector: Time vector corresponding to the signal.
    %   f_S: Sampling frequency of the signal.
    %   cutoffFreq: Cutoff frequency used for demodulation.
  
    modIndex = 0.5;
    % Demodulate the SSB signal
    demodSignal = SSB/modIndex .* cos(2 * pi * carrierFreq * timeVector);
    
    % Calculate length and frequency vectors
    len = length(SSB);
    freq = f_S/2 * linspace(-1, 1, len);
    
    % Compute frequency domain representation of the demodulated signal
    demodFreq = fftshift(fft(demodSignal));
    
    % Filter out frequencies outside the desired range for demodulation
    demodFreq(freq >= cutoffFreq | freq <= -cutoffFreq) = 0;
    
    % Perform inverse FFT to obtain the demodulated signal in time domain
    demodSignal = ifft(ifftshift(demodFreq));
    
    % Plot the demodulated signal in the time domain
    figure;
    plot(timeVector, demodSignal);
    title('Demodulated Signal in Time Domain');
    
    % Obtain the frequency domain representation of the demodulated signal
    len = length(demodSignal);
    freq = f_S/2 * linspace(-1, 1, len);
    S_freq = fftshift(fft(demodSignal));
    
    % Plot the demodulated signal in the frequency domain
    figure;
    plot(freq, abs(S_freq));
    title('Demodulated Signal in Frequency Domain');
    
    % Resample and play the demodulated signal
    demodSignal = resample(abs(demodSignal), f_S/5, f_S);
    sound(abs(demodSignal), f_S/5);
end
