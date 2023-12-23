function frequencyDemodulation(modSignal, f_Sampling, timeVector)
    % frequencyDemodulation performs frequency demodulation on a modulated signal
    % Inputs:
    %   modSignal: Modulated signal to be demodulated
    %   f_Sampling: Sampling frequency of the signal
    %   timeVector: Time vector corresponding to the signal

    % Compute the derivative of the modulated signal to demodulate
    demodSignal = diff(modSignal);
    demodSignal = [0; demodSignal]; % Compensate for length difference due to diff function
    
    % Obtain the envelope of the demodulated signal using the Hilbert transform
    envelope = abs(hilbert(demodSignal)) - mean(abs(hilbert(demodSignal))); % Extract envelope
   
    % Plot the spectrum of the frequency-demodulated signal
    S_Freq = fftshift(fft(demodSignal));
    len = length(demodSignal);
    freq = f_Sampling / 2 * linspace(-1, 1, len);
    figure;
    plot(freq, abs(S_Freq));
    title('Spectrum of Frequency Demodulated Signal');
    
    % Plot the demodulated signal envelope over time
    figure;
    plot(timeVector, envelope);
    title("Demodulated Signal");
    ylim([-2*10^-4 2*10^-4]);
    
    % Resample the envelope and play the audio
    envelope = resample(envelope, f_Sampling / 5, f_Sampling);
    % Scale and play the envelope (500 is an arbitrary scaling factor for audio perception)
    sound(500 .* abs(envelope), f_Sampling/5);
end
