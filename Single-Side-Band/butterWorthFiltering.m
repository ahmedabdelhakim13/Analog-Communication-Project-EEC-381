function butterWorthFiltering(cutoffFreq, f_S, signal, carrierFreq, timeVector)
    % butterWorthFiltering - Applies Butterworth filtering and demodulation to a signal.
    % Inputs:
    %   cutoffFreq: Cutoff frequency of the Butterworth filter.
    %   f_S: Sampling frequency of the input signal.
    %   signal: Input signal to be processed.
    %   carrierFreq: Carrier frequency for demodulation.
    %   timeVector: Time vector corresponding to the signal.
    
    % Design the Butterworth filter
    [b, a] = butter(4, cutoffFreq * 2/f_S);
    modIndex = 0.5;
    % Demodulate the signal
    demodSignal = signal/modIndex .* cos(2 * pi * carrierFreq * timeVector);
    
    % Apply the Butterworth filter using filtfilt
    demodSignal = filtfilt(b, a, demodSignal);
    
    % Plot the filtered signal in the time domain
    figure;
    plot(timeVector, demodSignal);
    title('Butterworth Filtered Signal in Time Domain');
    
    % Calculate frequency domain representation
    len = length(demodSignal);
    freq = f_S/2 * linspace(-1, 1, len);
    S_freq = fftshift(fft(demodSignal));
    
    % Plot the demodulated signal in the frequency domain
    figure;
    plot(freq, abs(S_freq));
    title('Demodulated Signal in Frequency Domain Using Butterworth filter');
    
    % Resample the signal and play the sound
    demodSignal = resample(abs(demodSignal), f_S/5, f_S);
    sound(abs(demodSignal), f_S/5);
end
