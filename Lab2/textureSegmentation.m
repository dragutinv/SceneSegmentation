function [outputImageContrast, outputImageEnergy, outputImageHomogeneity, outputImageEntropy] = textureSegmentation(imageFile, props, windowSize)

im = imread(imageFile);

%convert to grayscale
im = rgb2gray(im);

%featuresFun = @(x) cell2mat(struct2cell(graycoprops(graycomatrix(x, 'offset', [0 1], 'Symmetric', true),props)));
%[features] = nlfilter(im,[windowSize windowSize],featuresFun);

[sizeX, sizeY] = size(im);

if (mod(windowSize,2)) == 0
    windowSize = windowSize + 1;
end

%zero-padding
im = padarray(im,[(windowSize-1)/2 (windowSize-1)/2],0);
outputImageEnergy = zeros(size(im));
outputImageContrast = zeros(size(im));
outputImageEntropy = zeros(size(im));
outputImageHomogeneity = zeros(size(im));

for i = (windowSize-1)/2+1:sizeX
    for j = (windowSize-1)/2+1:sizeY     
        localPixel = im(i-(windowSize-1)/2:i+(windowSize-1)/2,j-(windowSize-1)/2:j+(windowSize-1)/2);
        coMatrix = graycomatrix(localPixel);
        descriptor = graycoprops(coMatrix,'all');
        outputImageEnergy(i,j) = descriptor.Energy;
        outputImageContrast(i,j) = descriptor.Contrast;
        outputImageEntropy(i,j) = descriptor.Correlation;
        outputImageHomogeneity(i,j) = descriptor.Homogeneity;
    end
end


%imshow(label2rgb(uint8(imResult*255)));
%imshow(uint8(imResult*255));