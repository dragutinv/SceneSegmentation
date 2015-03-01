function [ result ] = findNeighbours( currentPixel, connectivity, imSize )
%FINDNEIGHBOURS Function returns indexes of neighbours

result = [];

if (connectivity == 4)
       %add top neigbour
       if (currentPixel(2) - 1 > 0)
           result = [result  currentPixel(1) currentPixel(2)-1];
       end
       
        %add right neigbour
       if (currentPixel(1) + 1 <= imSize(1))
           result = [result  currentPixel(1)+1 currentPixel(2)];
       end
       
        %add bottom neigbour
       if (currentPixel(2) + 1 <= imSize(2))
           result = [result  currentPixel(1) currentPixel(2)+1];
       end
       
        %add left neigbour
       if (currentPixel(1) - 1 > 0)
           result = [result  currentPixel(1)-1 currentPixel(2)];
       end
elseif (connectivity == 8)
       %add top left neigbour
       if (currentPixel(1) - 1 > 0 && currentPixel(2) - 1 > 0)
           result = [result  currentPixel(1)-1 currentPixel(2)-1];
       end
       
       %add top neigbour
       if (currentPixel(2) - 1 > 0)
           result = [result  currentPixel(1) currentPixel(2)-1];
       end
       
       %add top right neigbour
       if (currentPixel(1) + 1 <= imSize(1) && currentPixel(2) - 1 > 0)
           result = [result  currentPixel(1)+1 currentPixel(2) - 1];
       end
       
        %add right neigbour
       if (currentPixel(1) + 1 <= imSize(1))
           result = [result  currentPixel(1)+1 currentPixel(2)];
       end
       
       %add bottom right neigbour
       if (currentPixel(1) + 1 <= imSize(1) && currentPixel(2) + 1 <= imSize(2))
           result = [result  currentPixel(1)+1 currentPixel(2)+1];
       end
       
        %add bottom neigbour
       if (currentPixel(2) + 1 <= imSize(2))
           result = [result  currentPixel(1) currentPixel(2)+1];
       end
       
       %add bottom left neigbour
       if (currentPixel(1) - 1 > 0 && currentPixel(2) + 1 <= imSize(2))
           result = [result  currentPixel(1)-1 currentPixel(2)+1];
       end
       
        %add left neigbour
       if (currentPixel(1) - 1 > 0)
           result = [result  currentPixel(1)-1 currentPixel(2)];
       end
end

