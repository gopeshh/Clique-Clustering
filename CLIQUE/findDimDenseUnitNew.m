function denseUnits = findDimDenseUnitNew(prevDimDenseUnits,nextDim)
if (nextDim ==2)
    combs = combnk(prevDimDenseUnits,2)';
    combs1 = [combs{1,:};combs{2,:}];
    if(~isempty(combs1))
    combs2 = mat2cell(combs1,2^(nextDim-1),2*ones(1,size(combs,2)));
    denseU = cellfun(@(x) newDense(x,nextDim), combs2,'UniformOutput',false);
    denseU( cellfun('isempty', denseU ) ) = [];
    denseUnits = findRepeatUnit(denseU);
    else
       denseUnits =[]; 
    end
    
else
    denseUnitCombo = nchoosek(prevDimDenseUnits,2);
    denseUnits = cell(1,size(denseUnitCombo,1));
    if(~isempty(denseUnitCombo))
        denseUnitDims = zeros(size(denseUnitCombo,1),numel(union(denseUnitCombo{1,1}{1},denseUnitCombo{1,2}{1})));
        
        for k=1:size(denseUnitCombo,1)
            if( numel(union(denseUnitCombo{k,1}{1},denseUnitCombo{k,2}{1})) ==nextDim)
                mergeDim = [denseUnitCombo{k,1}{1},denseUnitCombo{k,2}{1}];
                [~,~,ib] = unique(mergeDim,'stable');
                existVectLogical = ismember(mergeDim,mergeDim(find(hist(ib,unique(ib))>1)));
                existVect = find(existVectLogical);
                keepDims1 = denseUnitCombo{k,1}{2}(:,existVect(1:length(existVect)/2));
                keepDims2 = denseUnitCombo{k,2}{2}(:,existVect(length(existVect)/2+1:end)-length(mergeDim)/2);
                [i,j] = find(pdist2(keepDims1,keepDims2,'cityblock')==0);
                %     [i,j] = find(d==0);
                removeVect = existVectLogical(length(existVectLogical)/2+1:end);
                colOrder = union(denseUnitCombo{k,1}{1},denseUnitCombo{k,2}{1},'stable');
                denseBins =[denseUnitCombo{k,1}{2}(i,:), denseUnitCombo{k,2}{2}(j,~removeVect)];
                [~,~, idy] = intersect(union(denseUnitCombo{k,1}{1},denseUnitCombo{k,2}{1}),colOrder,'stable');
                denseUnits{k} = {union(denseUnitCombo{k,1}{1},denseUnitCombo{k,2}{1}),denseBins(:,idy)};
                if(any(ismember(union(denseUnitCombo{k,1}{1},denseUnitCombo{k,2}{1}),denseUnitDims,'rows')))
                    [~,lb] = ismember(union(denseUnitCombo{k,1}{1},denseUnitCombo{k,2}{1}),denseUnitDims,'rows');
                    denseUnits{lb}{2} = [denseUnits{lb}{2}; denseUnits{k}{2}];
                    denseUnits{k} = [];
                else
                    denseUnitDims(k,:) = union(denseUnitCombo{k,1}{1},denseUnitCombo{k,2}{1});
                end
            else
                continue;
            end
            
        end
        denseUnits( cellfun('isempty', denseUnits ) ) = [];
            denseUnits = cellfun(@(x) removeRepeatingUnits(x,nextDim),denseUnits,'UniformOutput',false);
    end
end
end

function denseUnit = removeRepeatingUnits(denseUnit, nextDim)

if(~isempty(denseUnit))
    [~,x,y] = unique(denseUnit{2},'rows');
    denseUnit{2}= denseUnit{2}(x(accumarray(y,1)==nextDim*(nextDim-1)/2),:);    
end

end
