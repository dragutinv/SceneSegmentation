function [ meanIntensity ] = getMean( pixel, previousMeanIntesity, counter)
%getMEAN Return mean value for rgb and grayscale image

if (length(pixel) > 1)
    %RGB
    meanIntensity(1) = (double(pixel(1))+ previousMeanIntesity(1)*counter)/(counter+1);
    meanIntensity(2) = (double(pixel(2))+ previousMeanIntesity(2)*counter)/(counter+1);
    meanIntensity(3) = (double(pixel(3))+ previousMeanIntesity(3)*counter)/(counter+1);
else
    %GRAYSCALE
    meanIntensity = (double(pixel)+ double(previousMeanIntesity*counter))/(counter+1);
end

end

