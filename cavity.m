function [ output] = cavity(input)
%CAVITIES Detect East, West, South 
%   and central cavity, if present in handwritten digits

input = im2bw(input);
size1 = 28;  %rows in input
size2 = 28;  %columns in input
prestoreTop = zeros(28,28);  
prestoreLeft = zeros(28,28);  
prestoreBottom = zeros(28,28);  
prestoreRight = zeros(28,28);  

%From top

for j=1:size2
    for i=2:size1
        if input(i,j)==1
            prestoreTop(i,j)=1;
        else
            prestoreTop(i,j)=prestoreTop(i-1,j);
        end
    end
end

%From Left
for i=1:size1
    for j=2:size2
        if input(i,j)==1
            prestoreLeft(i,j)=1;
        else
            prestoreLeft(i,j)=prestoreLeft(i,j-1);
        end
    end
end

%From Bottom

for j=1:size2
    for i=size1-1:-1:1
        if input(i,j)==1
            prestoreBottom(i,j)=1;
        else
            prestoreBottom(i,j)=prestoreBottom(i+1,j);
        end
    end
end

%From Right

for i=1:size1
    for j=size2-1:-1:1
        if input(i,j)==1
            prestoreRight(i,j)=1;
        else
            prestoreRight(i,j)=prestoreRight(i,j+1);
        end
    end
end


% Prestore matrices are now storing whether there is any black pixel 
% above , below , right or left in respective matrices namely, 
% prestoreTop, prestoreBottom , prestoreRight, prestoreLeft.
% These matrices can now be used to check at every point, possibilites 
% of cavities.

Flag = zeros(1,4);       % 1-> central cavity presence, 2->east, 3-> west, 4->south
                         

for i=1:size1
    for j=1:size2
        if input(i,j)==0
            if prestoreTop(i,j) && prestoreRight(i,j) && prestoreLeft(i,j) && prestoreBottom(i,j)              
               Flag(1,1) = 1;    % CENTRAL   
            
            elseif prestoreTop(i,j) && prestoreLeft(i,j) && prestoreBottom(i,j)              
               Flag(1,2) = 1;     % EAST           
            
            elseif prestoreTop(i,j) && prestoreRight(i,j) && prestoreBottom(i,j)              
               Flag(1,3) = 1; % WEST            
            
            elseif prestoreTop(i,j) && prestoreRight(i,j) && prestoreLeft(i,j)              
               Flag(1,4) = 1;   % SOUTH
            end   
        end
    end   
end    
            
            
output = Flag;                
end

