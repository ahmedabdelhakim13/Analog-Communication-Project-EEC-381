clear all;
clc;
%% Reading the Signal
[signal, f_S, S_freq, freq] = start('eric.wav');
%% Filtered Signal in Frequency Domain
cutoffFreq = 4000;
filteredSignal = filtering(cutoffFreq, S_freq, freq, f_S);
%% Filtered Signal in Time Domain
startTime = 0;
endTime = startTime + length(filteredSignal)/f_S;
timeVector = linspace(startTime, endTime, length(filteredSignal));
timeVector = timeVector';
figure;
plot(timeVector, filteredSignal);
title('Filtered Signal in Time Domain');
sound(abs(filteredSignal));
%% Double-Side-Band-Suppressed-Carrier
carrierFreq = 100000;
carrierAmp = amplitude / modIndex;

filteredSignal = resample(filteredSignal, 5 * carrierFreq, f_S);
f_S = 5 * carrierFreq;

startTime = 0;
endTime = startTime + length(filteredSignal)/f_S;
timeVector = linspace(startTime, endTime, length(filteredSignal));
timeVector = timeVector';

carrier = generateCarrier(carrierFreq, carrierAmp, timeVector);
DSB_SC = supprassedCarrier(carrier, filteredSignal, f_S);
%% Double-Side-Band-Transmitted-Carrier
modIndex = 0.5;
DSB_TC = transmittedCarrier(carrier, filteredSignal, modIndex, f_S);
%% Envelope Detection DSB-SC
envelopeDetection(DSB_SC, timeVector, f_S);
%% Envelope Detection DSB_TC
envelopeDetection(DSB_TC, timeVector, f_S);
%% Coherent Detection with SNR = 0 dB
dB = 0;
phase = 0;
coherentDetection(dB, DSB_SC, carrierFreq, timeVector, cutoffFreq, f_S, phase);
%% Coherent Detection with SNR = 10 dB
dB = 10;
coherentDetection(dB, DSB_SC, carrierFreq, timeVector, cutoffFreq, f_S, phase); 
%% Coherent Detection with SNR = 30 dB
dB = 30;
coherentDetection(dB, DSB_SC, carrierFreq, timeVector, cutoffFreq, f_S, phase); 
%% Coherent Detection With Frequency Error and SNR = 0 dB
carrierFreq = 100100;
dB = 0;
coherentDetection(dB, DSB_SC, carrierFreq, timeVector, cutoffFreq, f_S, phase); 
%% Coherent Detection With Frequency Error and SNR = 10 dB
dB = 10;
coherentDetection(dB, DSB_SC, carrierFreq, timeVector, cutoffFreq, f_S, phase); 
%% Coherent Detection With Frequency Error and SNR = 30 dB
dB = 30;
coherentDetection(dB, DSB_SC, carrierFreq, timeVector, cutoffFreq, f_S, phase); 
%% Coherent Detection With Phase Error and SNR = 0 dB
carrierFreq = 100000;
phase = 20 * pi/180;
dB = 0;
coherentDetection(dB, DSB_SC, carrierFreq, timeVector, cutoffFreq, f_S, phase); 
%% Coherent Detection With Phase Error and SNR = 10 dB
carrierFreq = 100000;
phase = 20 * pi/180;
dB = 10;
coherentDetection(dB, DSB_SC, carrierFreq, timeVector, cutoffFreq, f_S, phase); 
%% Coherent Detection With Phase Error and SNR = 30 dB
carrierFreq = 100000;
phase = 20 * pi/180;
dB = 30;
coherentDetection(dB, DSB_SC, carrierFreq, timeVector, cutoffFreq, f_S, phase);