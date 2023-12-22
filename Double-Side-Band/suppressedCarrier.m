function DSB_SC = suppressedCarrier(carrier, signal, f_Sampling)
    % suppressedCarrier generates a Double Side Band Suppressed Carrier (DSB-SC) signal
    % Inputs:
    %   carrier: Carrier signal
    %   signal: Input signal
    %   f_Sampling: Sampling frequency in Hz

    % Generate the DSB-SC signal by modulating the input signal with the carrier
    DSB_SC = signal .* carrier;

    % Compute the length of the DSB-SC signal
    len = length(DSB_SC);

    % Compute the frequency spectrum of the DSB-SC signal
    DSB_SC_Freq = fftshift(fft(DSB_SC));
    freq = f_Sampling / 2 * linspace(-1, 1, len);

    % Plot the frequency spectrum of the DSB-SC signal
    figure;
    plot(freq, abs(DSB_SC_Freq));
    title('Double Side Band Suppressed Carrier'); % Set the title for the plot
end
