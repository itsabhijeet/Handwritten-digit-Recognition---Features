function [output] = chaincode( input )
%UNTITLED ChainCode Extraction
% output contains chaincode
edge_image = edge(input,'canny');   %Detecting Edge 
%figure,imshow(edge_image,'InitialMagnification','fit');
sz = size(edge_image);
pos_of_first = zeros(1,2);
f=0;

% Looking for source
for i=1:sz(1)
    for j=1:sz(2)       
        if edge_image(i,j)==1
            f=1;            
            pos_of_first(1,1)=i;
            pos_of_first(1,2)=j;
            break;
        end
    end
    if f
        break;
    end    
end    

%Neighbours of a point
row = [-1,-1,0,1,1,1,0,-1];
col = [0,1,1,1,0,-1,-1,-1];
%Encoding codes for different neighbours
code= [2,1,0,7,6,5,4,3];
visited = zeros(30,30);
out = zeros(1,100); 

srci = pos_of_first(1,1);
srcj = pos_of_first(1,2);

stackx = zeros(1,800);
stacky = zeros(1,800);
i=1; top=1;
stackx(1,i) = srci; 
stacky(1,i) = srcj;
cnt=0;
%Depth first Search to find chaincode
while(top>=1)
    tpx = stackx(1,top);
    tpy = stacky(1,top);
    top=top-1;   
    visited(tpx,tpy)=1;
    for k=1:8
        x = tpx + row(k);
        y = tpy + col(k);
        if x<=0 || x>28 || y<=0 || y>28
            continue;
        end;
        
        if visited(x,y)==0 && edge_image(x,y)==1
            top=top+1;
            cnt=cnt+1;
            out(1,cnt)=code(k); 
            stackx(top)=x;
            stacky(top)=y;
        end
    end 
end
%storing the count of each code in hash table
hash = zeros(1,8);
for i=1:cnt-1
    hash(1,out(1,i)+1)=hash(1,out(1,i+1)+1)+1;
end
%%plot
x = 0:1:7;
for i=1:8
    y(i)=hash(1,i)./(cnt-1);   %Normalizing
end    
%figure,bar(x,y);   %plotting obtained counts of each bin

output = y; 

