function [featuresE, featuresH, featuresCo, featuresC ] = textureSegmentation(imageFile)
%PARAMETERS
windowSize = 21; %must be odd number, window size is windowSize x windowSize square

im = imread(imageFile);

%convert to grayscale
im = rgb2gray(im);

imgSize = size(im);

[featuresE] = nlfilter(im,[20 20],@Features);
[featuresH] = nlfilter(im,[20 20],@Features);
[featuresCo] = nlfilter(im,[20 20],@Features);
[featuresC] = nlfilter(im,[20 20],@Features);
%imshow(label2rgb(uint8(imResult*255)));
%imshow(uint8(imResult*255));