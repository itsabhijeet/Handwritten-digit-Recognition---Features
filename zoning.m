function [ output ] = zoning( input )
%ZONING Dividing input image into regions
%   In each divided region we calculate number of foreground pixels in it.


%uli-> upper left i ulj-> upper left j lri->lower right i lrj-> lower rightj

input = im2bw(input);

uli = 1; ulj=1; lri= 7; lrj=7;
hash = zeros(1,49);
idx=1;
while uli<28
    cnt=0;    
    
    for i=uli:lri
        for j=ulj:lrj
            if input(i,j)==1
                cnt=cnt+1;
            end 
        end
    end
    
    ulj = ulj +7;
    
    if ulj>28
        uli = uli + 7;
        ulj=1;
    end
    lrj = lrj + 7;
    
    if lrj>28
        lri=  lri+7;     
        lrj=7;
    end
    
    %For every zone cnt stores the number of foreground pixel and we are
    %storing it in hash.
    
    hash(1,idx) = cnt/49;
    idx = idx +1;
end    
output= hash;
end

