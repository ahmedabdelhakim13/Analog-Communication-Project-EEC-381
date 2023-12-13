function [signal, f_Sampling, S_freq, freq] = start(filename)
    % start analyzes the input audio file and computes its spectrum
    % Inputs:
    %   filename: Name of the audio file to be analyzed

    % Read the audio file and extract the signal and sampling frequency
    [signal, f_Sampling] = audioread(filename);

    % Compute the length of the signal
    len = length(signal);

    % Compute the frequency spectrum of the signal
    S_freq = fftshift(fft(signal));
    freq = (f_Sampling / 2) * linspace(-1, 1, len);

    % Plot the spectrum of the signal
    figure;
    plot(freq, abs(S_freq) / len);
    title('Signal Spectrum'); % Set the title for the plot
end