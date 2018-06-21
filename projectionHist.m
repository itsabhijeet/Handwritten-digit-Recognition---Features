function [ output ] = projectionHist(input)
%PROJECTION HISTOGRAM For each row, column
%   and diagnol parallel to stanard diagnol we 
%   calculate count to foreground pixels.

input = im2bw(input);  %image binarize
hash = zeros(1,111); % 28 row + 28 col + 55 diagnols
idx=1;
sz1 = 28; 
sz2 = 28;
%For ROW Starts here
for i=1:sz1
    
    cnt=0;
    for j=1:sz2             
        if input(i,j)==1
            cnt=cnt+1;
        end        
    end    
    hash(1,idx)=cnt;
    idx=idx+1;
end
    
%For column starts here.
for j=1:sz2
    cnt=0;
    for i=1:sz1                
         if input(i,j)==1
             cnt=cnt+1;
         end
    end    

    hash(1,idx)=cnt;
    idx=idx+1;
end

%For diagnols starts here
%for right side of principal diagnol

 si=1; sj=1;
 
 while sj<=28
     
      i=si; j=sj;
      cnt=0;
      while j<=28
          if input(i,j)==1
              cnt=cnt+1;
          end
          i=i+1;
          j=j+1;            
         
      end
      hash(1,idx) = cnt;
      idx = idx+1;
      sj = sj+1;
 end      

%For left side of principal diagnol

 si=2; sj=1;
 
 while si<=28
     i=si; j=sj;
     cnt=0;
     while i<=28
         if input(i,j)==1
             cnt=cnt+1;
         end
         i=i+1;
         j=j+1;
     end 
     hash(1,idx) =cnt;
     idx = idx + 1;
     si=si+1;
 end     
     
    output = hash;
end



