function envelopeDetection(signal, time, f_Sampling)
    signalEnvelope = abs(hilbert(signal));
    figure;
    plot(time, signal);
    hold on;
    plot(time, - signalEnvelope, '-r', time, signalEnvelope, '-r', 'Linewidth', 1.5);
    hold off;
    title('Envelope Of Double Side Band Suppressed Carrier');

    signalEnvelope = resample(abs(signalEnvelope), f_Sampling/5, f_Sampling);
    sound(abs(signalEnvelope), f_Sampling/5);
end