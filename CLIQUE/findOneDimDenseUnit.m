function oneDUnits = findOneDimDenseUnit(dataset,tau,si)
nPoints = size(dataset,1);
nFeatures = size(dataset,2);
oneDUnits ={};
nDenseUnits = [];
for i=1:nFeatures
    dataPts= discretize(dataset(:,i),si);
    N = countCategories(dataPts,si);
    nDenseUnits = [nDenseUnits N];
    isDense = nDenseUnits>tau*nPoints;
    for j=1:si
        if(isDense(j,i))
            oneDUnits = [oneDUnits [i,j]];
        end
    end
end
end
function numCats = countCategories(catData,numDiv)

numCats = zeros(numDiv,1);
for i=1:numDiv
    numCats(i)= sum(catData==i);
end
end