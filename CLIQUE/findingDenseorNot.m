dataset = load('foo.csv');
si =3;
tau = 0.1;
[N1,edges1] = histcounts(dataset(:,1),si);
[N2,edges2] = histcounts(dataset(:,2),si);
edges1 = 0.5 * (edges1(1:end-1) + edges1(2:end));

edges2 = 0.5 * (edges2(1:end-1) + edges2(2:end));
load('dense_cdates.mat');
cDates_Mid  =[];
for i =1:length(cdates)
   cDates_Mid = [cDates_Mid [edges1(cdates{i}(1,2));edges2(cdates{i}(2,2))]];
    
end
proj = zeros(1,length(cdates));
for idx =1:length(dataset)
 d = sqrt(sum((dataset(idx,:)-cDates_Mid').^2,2));
 [~,ix] = min(d);

 proj(ix) =proj(ix)+1;
end
tau = 0.1;
nPoints = length(dataset);
isDense = proj>tau*nPoints;