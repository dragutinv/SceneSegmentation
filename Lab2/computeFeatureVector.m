function v = computeFeatureVector(im, props)
%
% Describe an image A using texture features.
%   A is the image
%   v is a 1xN vector, being N the number of features used to describe the
% image
%

if size(im,3) > 1,
	A = rgb2gray(im);
end

e = graycoprops(graycomatrix(A, 'offset', [0 1; -1 1; -1 0; -1 -1], 'Symmetric', true),'Energy');
c = graycoprops(graycomatrix(A, 'offset', [0 1; -1 1; -1 0; -1 -1], 'Symmetric', true),'Contrast');
h = graycoprops(graycomatrix(A, 'offset', [0 1; -1 1; -1 0; -1 -1], 'Symmetric', true),'Homogeneity');
cc = graycoprops(graycomatrix(A, 'offset', [0 1; -1 1; -1 0; -1 -1], 'Symmetric', true),'Correlation');

v = [];

%contrast
if (props(1) == 1)
    v = [v c.Contrast];
end

%energy
if (props(2) == 1)
    v = [v e.Energy];
end

%homogeneity
if (props(3) == 1)
    v = [v h.Homogeneity];
end

%entropy
if (props(4) == 1)
    v = [v cc.Correlation];
end

%use color
v = [v im(:,:, 1) im(:,:, 2) im(:,:, 3)];
