function [ output ] = ProfileProjection( input )
%PROFILE PROJECTION From left, right, top and bottom
%   it calculates count of pixels until a black pixel is found.

input = im2bw(input);

hash = zeros(1,112);

idx=1;
size1 = 28;
size2 = 28;

%From top

for j=1:size2
    count=0;
    for i=1:size2
        if input(i,j)==1
            break;
        end    
         count = count+1;    
    end
    hash(1,idx) = count;
    idx = idx+1; 
end    
  
%For right  (<---)

for i=1:size1
    count=0;
    for j=size2:-1:1
        if input(i,j)==1
            break;
        end   
        count=count+1;
    end
    hash(1,idx) = count;
    idx = idx+1;
end

%For bottom
for j=1:size2
    count=0;
    for i=size1:-1:1
        if input(i,j)==1
            break;
        end
        count = count+1;
    end
    hash(1,idx)=count;
    idx=idx+1;
end
%For left(--->)

for i=1:size1
    count=0;
    for j=1:size2
        if input(i,j)==1
            break;
        end
        count=count+1;
    end
    hash(1,idx)=count;
    idx=idx+1;
end


output = hash;

end


