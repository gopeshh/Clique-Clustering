function clusters = findClustersOneDim(denseUnits)
g = sketchGraph(denseUnits);
[bins,binsizes] = conncomp(graph(g));
clusters = [];
for i=1:length(binsizes)
clusterDenseUnits = denseUnits(:,bins ==i);
dimensions =[];
    for j=1:length(clusterDenseUnits)
        if(ismember(clusterDenseUnits{j}(:,1),dimensions))
            continue;            
        else
            dimensions = union(dimensions,clusterDenseUnits{j}(:,1));
        end

    end
    clusters(i).subspace = dimensions;
    clusters(i).denseUnits = clusterDenseUnits;
end
end
 