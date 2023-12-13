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
%subplot(1,2,1);
%plot(t,y);
%title('time domain');
%xlabel('time');
%ylabel('Amplitude');
%frequency domain
nfft = length(y);
f=linspace(0,Fs,nfft);
Y=abs(fftshift(fft(y,nfft)));
%%subplot(1,2,2);
plot(f,Y);
title('frequency domain');
xlabel('frequency');
ylabel('Amplitude');
%%dseign ideal low pass filter
d=designfilt('lowpassfir','FilterOrder',5,'cutoffFrequency',4000,'samplerate',Fs);
z=filter(d,Y);
figure;
plot(Y);
title('frequency filtered domain');
xlabel('frequency');
ylabel('Amplitude');
%plot(abs(fft(y)),Fs); %plot  %subplot %xlabel %ylabel %title %sound(y,Fs);
