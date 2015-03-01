function [ regions, regionNumber, executionTime] = growingRegion( image, connectivity, threshold)
%GROWINGREGION Function performs scene segmentation using growing regions
%algorithm

tic;%measure execution time of region growing

dim = size(image);
visitedPixels = zeros(dim(1), dim(2));

%threshold
regionNumber = 0;

for row = 1:dim(1)
    for column = 1:dim(2) %for every pixel in the image 
        if (visitedPixels(row, column) == 0)
            %%NEW REGION
            meanIntensity = double(image(row, column, :));
            regionNumber = regionNumber+1;
            neighbours = [];
            queue = [row, column];%seed point
            visitedPixels(queue(1), queue(2)) = regionNumber; 
            counter = 1;
            
            while (isempty(queue) == 0)
                    %GROW REGION        
                    neighbours = findNeighbours([queue(1) queue(2)], connectivity,dim);
                    queue = queue(3:end);%remove seed, add neighbours to queue
                    
                    %ADD ALL NEIBOURHOOD PIXELS THAT BELONG TO THE SAME REGION
                    for i = 1:2:length(neighbours)
                        
                        if (visitedPixels(neighbours(i),neighbours(i+1)) == 0) ...
                            && getDifference(image(neighbours(i),neighbours(i+1), :), meanIntensity) < threshold
                        
                            queue = [queue neighbours(i),neighbours(i+1)];
                            visitedPixels(neighbours(i),neighbours(i+1)) = regionNumber; 
                            counter = counter + 1;
                            meanIntensity = getMean(image(neighbours(i),neighbours(i+1),:), meanIntensity, counter);
                        end
                    end
            end
        end
    end   
end

regions = label2rgb(visitedPixels);
executionTime = toc; %measure elapsed time of region growing

end

