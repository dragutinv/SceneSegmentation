function [ difference ] = getDifference( pixel, meanIntensity )
%GETDIFFERENCE Get difference between mean values in region and current
%pixel

if (length(pixel) > 1)
    %MORE DIMENSIONS
    sum = 0;
    for i = 1:length(pixel)
        sum = sum + (double(pixel(i))-meanIntensity(i))^2;
    end
    difference = sqrt(sum);
else
    %GRAYSCALE
    difference = abs(pixel-meanIntensity); 
end



end

