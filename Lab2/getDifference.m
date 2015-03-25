function [ difference ] = getDifference( pixel, meanIntensity )
%GETDIFFERENCE Get difference between mean values in region and current
%pixel

if (length(pixel) > 1)
    %RGB
    difference = sqrt((double(pixel(1))-meanIntensity(1))^2 + (double(pixel(2))-meanIntensity(2))^2 + (double(pixel(3))-meanIntensity(3))^2); 
else
    %GRAYSCALE
    difference = abs(pixel-meanIntensity); 
end



end

