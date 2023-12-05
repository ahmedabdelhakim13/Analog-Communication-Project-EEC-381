function carrier = generateCarrier(carrierFreq, carrierAmp, time)
    carrier = carrierAmp .* cos(2 * pi * carrierFreq * time);
end