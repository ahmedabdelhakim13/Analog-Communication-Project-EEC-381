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
%% Modulating the Signal
kf = 0.2/(2*pi*max(abs(cumsum(filteredSignal)))./ f_S);
carrierFreq = 100000;
carrierAmp = 1;
filteredSignal = resample(filteredSignal, 5 * carrierFreq, f_S);
f_S = 5 * carrierFreq;
[modSignal, timeVector] = frequencyModulation(kf, carrierFreq, carrierAmp, filteredSignal, f_S);
%% Demodulating the Signal
frequencyDemodulation(modSignal, f_S, timeVector);