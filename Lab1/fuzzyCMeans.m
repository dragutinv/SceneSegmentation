function [ regions, executionTime ] = fuzzyCMeans( image, numberOfClusters, maxIterations )
%FUZZYCMEANS Scene segmentation using fuzzy C-Means algorithm

tic;%measure execution time of c-means

image = double(image); 

data = []; 


%vectorize image in order to perform for fuzzy c-means
for i = 1:size(image,3) 
    plane = image(:,:,i); 
    data = [data plane(:)]; 
end

%perform fuzzy c-mean with limited maxIterations and numberOfClusters
opts = [nan;maxIterations;nan;0];
[~, U, ~] = fcm(data,numberOfClusters, opts);

%for each pixel find its belonging cluster
visitedData = zeros(1,size(data,1)); 
for i= 1 : length(U) 
    [~, maxIndex] = max(U(:,i)); 
    visitedData(i) = maxIndex; 
end

%show regions based on fuzzy C-Means segmentation
regions = label2rgb(reshape(visitedData,[size(image,1) size(image,2)]));
executionTime = toc; %measure elapsed time of fuzzy C-Means

end

