function clusters = clique(dataset,tau,si)

dUnits = findOneDimDenseUnit(dataset,tau,si);
for i=1:size(dataset,2)
   dataset(:,i) = discretize(dataset(:,i),si); 
end
clusters = findClusters(dUnits);
nextDim =2;
featureDim = size(dataset,2);
while((nextDim <= featureDim)&& (~isempty(dUnits)))
    disp(['We reached ',num2str(nextDim),'D space']);
    dUnits = findDimDenseUnit(dataset,dUnits, nextDim, tau);
%    dUnits = findDimDenseUnitNew(dUnits,nextDim);
    tempClusters = findClusters(dUnits);
    clusters = [clusters, tempClusters];
    nextDim = nextDim+1;   
end
end
