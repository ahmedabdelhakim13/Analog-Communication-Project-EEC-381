function [modSignal, timeVector] = frequencyModulation(kf, carrierFreq, carrierAmp, signal, f_Sampling)
    startTime = 0;
    endTime = startTime + length(signal) / f_Sampling;
    timeVector = linspace(startTime, endTime, length(signal));
    timeVector = timeVector';

    %FM modulated signal
    modSignal = carrierAmp * cos(2 * pi * carrierFreq * timeVector + 2 * pi * kf * cumsum(signal)./ f_Sampling);

    % Fourier transform
    len = length(signal);
    S_Freq = fftshift(fft(signal));
    freq = f_Sampling / 2 * linspace(-1,1,len);
    figure; 
    plot(freq, S_Freq);
    title('Spectrum of Frequecny Modulated Signal');
end