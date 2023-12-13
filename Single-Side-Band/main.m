%% 
clear all;
clc;
%%
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
%% Generating Double-Side-Band-Supprassed-Carrier
carrierFreq = 100000;
Amplitude = max(filteredSignal);
carrierAmp = 2 * Amplitude;

filteredSignal = resample(filteredSignal, 5 * carrierFreq, f_S);
f_S = 5 * carrierFreq;

startTime = 0;
endTime = startTime + length(filteredSignal)/f_S;
timeVector = linspace(startTime, endTime, length(filteredSignal));
timeVector = timeVector';

carrier = generateCarrier(carrierFreq, carrierAmp, timeVector);
DSB_SC = suppressedCarrier(carrier, filteredSignal, f_S);
%% Generating Single-Side-Band-LSB
SSB_LSB = singleSideBand(DSB_SC, f_S, carrierFreq);
%% Demodulating
singleSideBandDemodulation(SSB_LSB, carrierFreq, timeVector, f_S, cutoffFreq);
%% ButterWorth Filter
butterWorthFiltering(cutoffFreq, f_S, SSB_LSB, carrierFreq, timeVector);
%% Coherent Detection With SNR = 0 dB
dB = 0;
phase = 0;
coherentDetection(dB, SSB_LSB, carrierFreq, timeVector, cutoffFreq, f_S, phase);
%% Coherent Detection With SNR = 10 dB
dB = 10;
coherentDetection(dB, SSB_LSB, carrierFreq, timeVector, cutoffFreq, f_S, phase);
%% Coherent Detection With SNR = 30 dB
dB = 30;
coherentDetection(dB, SSB_LSB, carrierFreq, timeVector, cutoffFreq, f_S, phase);
%% Single Side Band Transmitted Carrier
SSBTC = carrier + SSB_LSB;
len = length(SSBTC);
S_freq = fftshift(fft(SSBTC));
freq = f_S/2 * linspace(-1, 1, len);

figure;
plot(freq, abs(S_freq)/len);
title('SSBTC in Frequency Domain');
envelopeDetection(SSBTC, timeVector, f_S);