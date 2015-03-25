function [ difference ] = getDifference( pixel, meanIntensity )
%GETDIFFERENCE Get difference between mean values in region and current
%pixel

%size(meanIntensity)

if (length(pixel) > 1)
    %MORE DIMENSIONS
    sum = 0;
    for i = 1:length(pixel)
        sum = sum + (double(pixel(1,1, i))-meanIntensity(1,1, i))^2;
    end
    difference = sqrt(sum/length(pixel));
else
    %GRAYSCALE
    difference = abs(pixel-meanIntensity); 
end



end

