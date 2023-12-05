function frequencyDemodulation(modSignal, f_Sampling, timeVector)
    demodSignal = diff(modSignal);
    demodSignal = [0; demodSignal];
    envelope = abs(hilbert(demodSignal)) - mean(abs(hilbert(demodSignal)));
    figure;
    plot(timeVector, envelope);
    title("Demodulated Signal");
    
    envelope = resample(envelope, f_Sampling / 5, f_Sampling);
    sound(500 .* abs(envelope), f_Sampling/5);
end