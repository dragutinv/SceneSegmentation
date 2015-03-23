function [ features ] = Features( window )
%FEATURES Summary of this function goes here

x = graycoprops(graycomatrix(window, 'offset', [0 1], 'Symmetric', true),'Energy');
features = x.Energy;
% x = graycoprops(graycomatrix(window, 'offset', [0 1], 'Symmetric', true),'Homogeneity');
% featuresH = x.Homogeneity;
% x = graycoprops(graycomatrix(window, 'offset', [0 1], 'Symmetric', true),'Correlation');
% featuresCo = x.Correlation;
% x = graycoprops(graycomatrix(window, 'offset', [0 1], 'Symmetric', true),'Contrast');
% featuresC = x.Contrast;

end

