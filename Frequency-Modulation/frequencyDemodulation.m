function frequencyDemodulation(modSignal, f_Sampling, modFactor)
    % frequencyDemodulation performs frequency demodulation on a modulated signal
    % Inputs:
    %   modSignal: Modulated signal to be demodulated
    %   f_Sampling: Sampling frequency of the modulated signal
    %   modFactor: Modulation factor used in the modulation process

    % Calculate the envelope of the modulated signal using the Hilbert transform
    envelope = abs(hilbert(modSignal)) - mean(abs(hilbert(modSignal)));

    % Demodulate the signal by computing its derivative
    demodSignal = zeros(length(modSignal), 1);
    demodSignal(2:end) = diff(envelope);

    % Resample the demodulated signal to the original sampling frequency
    demodSignal = resample(demodSignal, f_Sampling / 5, f_Sampling);
    
    % Normalize the demodulated signal by the modulation factor
    demodSignal = demodSignal / modFactor;

    % Compute and plot the spectrum of the demodulated signal
    S_Freq = fftshift(fft(demodSignal));
    len = length(demodSignal);
    freq = f_Sampling / 2 * linspace(-1, 1, len);
    figure;
    plot(freq, abs(S_Freq));
    title('Spectrum of Frequency Demodulated Signal');

    % Apply frequency filtering to remove high-frequency components
    S_Freq(freq >= 4000 | freq <= -4000) = 0;
    demodSignal = ifft(ifftshift(S_Freq));

    % Compute and plot the spectrum of the filtered demodulated signal
    len = length(demodSignal);
    S_Freq = fftshift(fft(demodSignal));
    freq = f_Sampling / 2 * linspace(-1, 1, len);
    figure;
    plot(freq, abs(S_Freq));
    title('Spectrum of Filtered Frequency Demodulated Signal');

    % Generate a time vector corresponding to the demodulated signal
    startTime = 0;
    endTime = startTime + length(demodSignal) / f_Sampling;
    timeVector = linspace(startTime, endTime, length(demodSignal));
    timeVector = timeVector';

    % Plot the demodulated signal in the time domain
    figure;
    plot(timeVector, demodSignal);
    title("Demodulated Signal in Time Domain");
    ylim([-2 2]);
    xlim([0 8]);

    % Play the audio of the demodulated signal (envelope)
    sound(abs(demodSignal), f_Sampling);
end
