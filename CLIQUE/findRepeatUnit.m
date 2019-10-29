function denseU = findRepeatUnit(denseU)
subspaceDim = denseU{1}{1};
n = length(denseU);
idxList = [];
for i=2:n
    if any(ismember(subspaceDim, denseU{i}{1},'rows')) 
        idx = find(ismember(subspaceDim, denseU{i}{1},'rows'));
        idxList = [idxList i];
        denseU{idx}{2}= [denseU{idx}{2};denseU{i}{2}];
        denseU{i} ={zeros(1,length(denseU{1}{1})),zeros(1,length(denseU{1}{1}))};
        subspaceDim = [subspaceDim; zeros(size(denseU{1}{1}))];
    else
        subspaceDim = [subspaceDim; denseU{i}{1}];
    end
    
end
denseU(idxList) =[];
end