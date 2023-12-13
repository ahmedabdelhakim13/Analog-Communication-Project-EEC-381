function DSB_TC = transmittedCarrier(carrier, signal, modIndex, f_Sampling)
    % transmittedCarrier generates a Double Side Band Transmitted Carrier (DSB-TC) signal
    % Inputs:
    %   carrier: Carrier signal
    %   signal: Input signal
    %   modIndex: Modulation index
    %   f_Sampling: Sampling frequency in Hz

    % Determine the amplitude of the input signal
    amplitude = max(signal);

    % Generate the DSB-TC signal by modulating the carrier with the input signal
    DSB_TC = (1 + modIndex * signal / amplitude) .* carrier;

    % Compute the length of the DSB-TC signal
    len = length(DSB_TC);

    % Compute the frequency spectrum of the DSB-TC signal
    DSB_TC_Freq = fftshift(fft(DSB_TC));
    freq = f_Sampling / 2 * linspace(-1, 1, len);

    % Plot the frequency spectrum of the DSB-TC signal
    figure;
    plot(freq, abs(DSB_TC_Freq) / len);
    title('Double Side Band Transmitted Carrier'); % Set the title for the plot
end
