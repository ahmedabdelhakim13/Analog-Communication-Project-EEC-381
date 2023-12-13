clear all;
clc;
%% Reading the Signal
Fs=48000;                           %defining the frequency of the signal
T=1/Fs;                              %defining the periodic time for the signal
[y,Fs] = audioread('eric.wav');
%%
%plotting the signal in time and frequency domain
%time domain
t=linspace(0,length(y)/Fs,length(y));
figure;
subplot(1,2,1);
plot(y,t);
title('time domain');
xlabel('time');
ylabel('Amplitude');
%frequency domain
nfft = 2048
f=linspace(0,Fs,nfft);
Y=abs(fftshift(fft(y,nfft)));
subplot(1,2,2);
plot(Y,f);
title('frequency domain');
xlabel('frequency');
ylabel('Amplitude');
%plot(abs(fft(y)),Fs); %plot  %subplot %xlabel %ylabel %title %sound(y,Fs);
