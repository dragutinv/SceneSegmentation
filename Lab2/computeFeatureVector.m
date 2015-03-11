function v = computeFeatureVector(A)
%
% Describe an image A using texture features.
%   A is the image
%   v is a 1xN vector, being N the number of features used to describe the
% image
%

if size(A,3) > 1,
	A = rgb2gray(A);
end

e = graycoprops(graycomatrix(A, 'offset', [0 1; -1 1; -1 0; -1 -1], 'Symmetric', true),'Energy');
c = graycoprops(graycomatrix(A, 'offset', [0 1; -1 1; -1 0; -1 -1], 'Symmetric', true),'Contrast');
h = graycoprops(graycomatrix(A, 'offset', [0 1; -1 1; -1 0; -1 -1], 'Symmetric', true),'Homogeneity');
cc = graycoprops(graycomatrix(A, 'offset', [0 1; -1 1; -1 0; -1 -1], 'Symmetric', true),'Correlation');

v = [e.Energy c.Contrast h.Homogeneity cc.Correlation];
%v = mean(A);
