function denseUnits = findDimDenseUnit(dataset, prevDimDenseUnits, nextDim,tau)

cdates = findPrunedDenseUnitCandidates(prevDimDenseUnits,nextDim);
proj = zeros(length(cdates),1);
nPoints = size(dataset,1);
for idx=1:nPoints
    for i =1:length(cdates)
        if(binningData(dataset(idx,:),cdates{i}))
            proj(i) = proj(i)+1;
        end   
    end
end
isDense = proj>tau*nPoints;

denseUnits = cdates(isDense);
    
end

function boolValue = binningData(data,candidate)
boolValue = true;
for i=1:size(candidate,1)
   element = data(candidate(i,1));
   if(element~=candidate(i,2))
%    if ~all(ismember(element,candidate(:,2)))
      boolValue = false;
      break;
%    else
%        boolValue = true;
   end
end
end
