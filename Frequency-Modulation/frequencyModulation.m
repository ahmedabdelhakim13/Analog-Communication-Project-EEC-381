% Function to perform Frequency Modulation (FM)
% Inputs:
%   - signal: Input signal to be frequency modulated
%   - carrierFreq: Carrier frequency for modulation
%   - f_Sampling: Sampling frequency
%   - Kf: Frequency modulation factor
%   - A: Amplitude of the modulated signal
% Outputs:
%   - modSignal: Frequency modulated signal
%   - freq: Frequency axis of the modulated signal spectrum
%   - modFactor: Modulation factor used
function [modSignal, freq, modFactor] = frequencyModulation(signal, carrierFreq, f_Sampling, Kf, A)

% Adjust the sampling frequency to be 5 times the carrier frequency
f_Sampling = 5 * carrierFreq;

% Resample the signal to the new sampling frequency
signal = resample(signal, f_Sampling, f_Sampling / 5);

% Generate a time vector based on the new sampling frequency
startTime = 0;
endTime = startTime + length(signal) / f_Sampling;
timeVector = linspace(startTime, endTime, length(signal));
timeVector = timeVector';

% Calculate the modulation factor
modFactor = Kf * max(signal);

% Perform frequency modulation
modSignal = A .* cos(2 * pi * carrierFreq * timeVector) - (Kf .* cumsum(signal) .* sin(2 * pi * carrierFreq * timeVector));

% Calculate the spectrum of the modulated signal
S_Freq = fftshift(fft(real(modSignal)));

% Generate the frequency axis for the spectrum
freq = linspace(-f_Sampling / 2, f_Sampling / 2, length(S_Freq));

% Plot the spectrum of the frequency modulated signal
figure;
plot(freq, abs(S_Freq));
title("Spectrum of Frequency Modulated Signal");

end
