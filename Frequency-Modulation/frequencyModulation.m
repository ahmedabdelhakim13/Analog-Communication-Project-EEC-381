function [modSignal, timeVector] = frequencyModulation(kf, carrierFreq, carrierAmp, signal, f_Sampling)
    % frequencyModulation performs frequency modulation on an input signal
    % Inputs:
    %   kf: Frequency deviation constant (modulation index)
    %   carrierFreq: Carrier frequency of the modulation
    %   carrierAmp: Amplitude of the carrier signal
    %   signal: Input signal to be modulated
    %   f_Sampling: Sampling frequency of the signal

    % Generate the time vector corresponding to the signal
    startTime = 0;
    endTime = startTime + length(signal) / f_Sampling;
    timeVector = linspace(startTime, endTime, length(signal));
    timeVector = timeVector';

    % Perform Frequency Modulation (FM) on the input signal to generate the modulated signal
    modSignal = carrierAmp * cos(2 * pi * carrierFreq * timeVector + 2 * pi * kf * cumsum(signal) ./ f_Sampling);

    % Compute the Fourier transform of the input signal
    len = length(modSignal);
    S_Freq = fftshift(fft(modSignal));
    freq = f_Sampling / 2 * linspace(-1, 1, len);

    % Plot the spectrum of the frequency-modulated signal
    figure;
    plot(freq, S_Freq);
    title('Spectrum of Frequency Modulated Signal');
end
