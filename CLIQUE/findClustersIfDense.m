function  [clusters,denseUnits] = findClustersIfDense(denseUnits,data,tau)
clusters = struct([]);
for i=1:size(denseUnits,2)
    [~, resultIdx] = ismember(data(:,denseUnits{i}{1}),denseUnits{i}{2},'rows');
    countVal = accumarray(resultIdx(resultIdx>0),1);
    isDense = countVal>tau*size(data(:,denseUnits{i}{1}),1);
    denseUnits{i}{2} = denseUnits{i}{2}(isDense,:);
    dist =squareform(internal.stats.pdistmex(denseUnits{i}{2}','cit'));
    d = dist==1;
    clusters = [clusters,findClustersNew(denseUnits{i},d)];

end
end

function clusters = findClustersNew(denseUnits,d)

[bins,binsizes] = conncomp(graph(d));
clusters = [];
for i=1:length(binsizes)
clusterDenseUnits = denseUnits{2}(bins ==i,:);
    clusters(i).subspace = denseUnits{1};
    clusters(i).denseUnits = clusterDenseUnits;
end
end