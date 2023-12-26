clear all;
clc
%% Reading Audio File
[signal, f_S, S_freq, freq] = start('eric.wav');
%% Filtering the Input Signal
cutoffFreq = 4000;
filteredSignal = filtering(cutoffFreq, S_freq, freq, f_S);

startTime = 0;
endTime = startTime + length(filteredSignal) / f_S;
timeVector = linspace(startTime, endTime, length(filteredSignal));
timeVector = timeVector';

figure; 
plot(timeVector, filteredSignal); 
title('Filtered Signal Time Domain');

sound(abs(filteredSignal), f_S);
pause(8);
%% Modulating the Signal
carrierFreq = 100000;
carrierAmp = 1;
kf = 0.1;
[modSignal, freq, modFactor] = frequencyModulation(filteredSignal, carrierFreq, f_S, kf, carrierAmp);
%% Demodulating the Signal
frequencyDemodulation(modSignal, f_S, modFactor);