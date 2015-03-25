function [ meanIntensity ] = getMean( pixel, previousMeanIntesity, counter)
%getMEAN Return mean value for rgb and grayscale image

if (length(pixel) > 1)
    %multi dimensions
    meanIntensity = zeros(1,1, length(pixel));    
    for i = 1:length(pixel)
        meanIntensity(1,1, i) = (double(pixel(1,1, i))+ previousMeanIntesity(i)*counter)/(counter+1);
    end
else
    %GRAYSCALE
    meanIntensity = (double(pixel)+ double(previousMeanIntesity*counter))/(counter+1);
end

end

