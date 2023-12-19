function carrier = generateCarrier(carrierFreq, carrierAmp, time)
    % generateCarrier generates a carrier signal with specified parameters
    % Inputs:
    %   carrierFreq: Carrier frequency of the signal in Hz
    %   carrierAmp: Amplitude of the carrier signal
    %   time: Time vector for the carrier signal
    
    % Generate the carrier signal using the cosine function
    carrier = carrierAmp .* cos(2 * pi * carrierFreq * time);
end
