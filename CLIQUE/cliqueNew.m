function clusters = cliqueNew(dataset,tau,si)
dUnits = findOneDimDenseUnit(dataset,tau,si);
for i=1:size(dataset,2)
   dataset(:,i) = discretize(dataset(:,i),si); 
end
clusters = findClustersOneDim(dUnits);
nextDim =2;
featureDim = size(dataset,2);
while((nextDim <= featureDim)&& (~isempty(dUnits)))
    disp(['We reached ',num2str(nextDim),'D space']);
    tdUnits = findDimDenseUnitNew(dUnits,nextDim);
    [tempClusters,dUnits] = findClustersIfDense(tdUnits,dataset,tau);
    clusters = [clusters, tempClusters];
    nextDim = nextDim+1;   
end
end