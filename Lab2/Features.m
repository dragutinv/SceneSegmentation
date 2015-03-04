function [ features ] = Features( window )
%FEATURES Summary of this function goes here

x = graycoprops(graycomatrix(window, 'offset', [0 1], 'Symmetric', true),'Energy');
features = x.Energy;

end

