
im = imread('feli.tif');
% im = imread('hand2.tif');
%im = imread('mosaic8.tif');
% im = imread('pingpong2.tif');

im = rgb2gray(im);


[sizeX, sizeY] = size(im);

windowX = 9;
windowY = 9;

%zero-padding
im = padarray(im,[(windowX-1)/2 (windowY-1)/2],0);
outputImageEnergy = zeros(size(im));
outputImageContrast = zeros(size(im));
outputImageCorrelation = zeros(size(im));
outputImageHomogeneity = zeros(size(im));

for i = (windowX-1)/2+1:sizeX
    for j = (windowY-1)/2+1:sizeY     
        localPixel = im(i-(windowX-1)/2:i+(windowY-1)/2,j-(windowX-1)/2:j+(windowY-1)/2);
        coMatrix = graycomatrix(localPixel);
        descriptor = graycoprops(coMatrix,'all');
        outputImageEnergy(i,j) = descriptor.Energy;
        outputImageContrast(i,j) = descriptor.Contrast;
        outputImageCorrelation(i,j) = descriptor.Correlation;
        outputImageHomogeneity(i,j) = descriptor.Homogeneity;
    end
end

subplot(1,5,1), imshow(im), title('Original Image');
subplot(1,5,2), imshow(outputImageEnergy), title('Energy Descriptor');
subplot(1,5,3), imshow(outputImageContrast), title('Contrast Descriptor');
subplot(1,5,4), imshow(outputImageCorrelation), title('Correlation Descriptor');
subplot(1,5,5), imshow(outputImageHomogeneity), title('Homogeneity Descriptor');

    
