mat = zeros(500,11);
fid=fopen('data9');
for i=1:500
    [t,N]= fread(fid,[28 28]);
    f = chaincode(t);
    [output,table,feature_hash] = conv_feature(t);
    for j=1:8
        mat(i,j)=f(j);
    end 
    mat(i,9)  =  feature_hash(1,1);
    mat(i,10) = feature_hash(1,2);
    mat(i,11) = feature_hash(1,3);
    k=12;
    zone_hash = zoning(t);
    
    for j=1:49
        mat(i,k) = zone_hash(1,j);
        k=k+1;
    end
    
    projecthist_hash = projectionHist(t);
    
    for j=1:111
        mat(i,k) = projecthist_hash(1,j);
        k=k+1;
    end    
    
    profile_hash = ProfileProjection(t);
    for j=1:112
        mat(i,k) = profile_hash(1,j);
        k=k+1;
    end
    
    cavity_hash = cavity(t);
    
    for j=1:4
        mat(i,k)= cavity_hash(1,j);
        k=k+1;
    end    
end
%xlswrite(file,mat);
%file;