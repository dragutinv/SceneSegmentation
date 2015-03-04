%PARAMETERS
windowSize = 21; %must be odd number, window size is windowSize x windowSize square

im = imread('P2_seg/feli.tif');

%convert to grayscale
im = rgb2gray(im);

imgSize = size(im);

imResult = nlfilter(im,[11 11],@Features);

imshow(label2rgb(uint8(imResult*255)));