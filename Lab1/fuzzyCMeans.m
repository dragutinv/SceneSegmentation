function [ regions, executionTime ] = fuzzyCMeans( image, numberOfClusters, maxIterations )
%FUZZYCMEANS Scene segmentation using fuzzy C-Means algorithm

tic;%measure execution time of c-means

image = double(image); 

data = []; 

for i = 1:size(image,3) 
    plane = image(:,:,i); 
    data = [data plane(:)]; 
end

opts = [nan;maxIterations;nan;0];
[~, U, ~] = fcm(data,numberOfClusters, opts);

visitedData = zeros(1,size(data,1)); 
for i= 1 : length(U) 
    [~, maxIndex] = max(U(:,i)); 
    visitedData(i) = maxIndex; 
end

regions = label2rgb(reshape(visitedData,[size(image,1) size(image,2)]));
executionTime = toc; %measure elapsed time of fuzzy C-Means

end

