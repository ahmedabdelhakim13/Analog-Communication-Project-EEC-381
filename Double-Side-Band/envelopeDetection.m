function envelopeDetection(signal, time, f_Sampling)
    % envelopeDetection computes and plots the envelope of a signal
    % Inputs:
    %   signal: Input signal for envelope detection
    %   time: Time vector corresponding to the signal
    %   f_Sampling: Sampling frequency in Hz

    % Compute the envelope of the signal using Hilbert transform
    signalEnvelope = abs(hilbert(signal));

    % Plot the original signal and its envelope
    figure;
    plot(time, signal); % Plot the original signal
    hold on;
    plot(time, -signalEnvelope, '-r', time, signalEnvelope, '-r', 'Linewidth', 1.5); % Plot the envelope
    hold off;
    title('Envelope Of Double Side Band Suppressed Carrier'); % Set the title for the plot

    % Resample the signal envelope and play the audio
    signalEnvelope = resample(abs(signalEnvelope), f_Sampling / 5, f_Sampling);
    sound(abs(signalEnvelope), f_Sampling / 5); % Play the resampled signal envelope
end
