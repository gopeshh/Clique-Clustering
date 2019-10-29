function cDates = findPrunedDenseUnitCandidates(prevDimDenseUnits,nextDim)
% cDates = {};
if(length(prevDimDenseUnits)>1)
    combs = combnk(prevDimDenseUnits,2)';
    combs1 = [combs{1,:};combs{2,:}];
    combs2 = mat2cell(combs1,2^(nextDim-1),2*ones(1,size(combs,2)));
    cDates = cellfun(@(x) possibleCandidates_new(x,nextDim), combs2,'UniformOutput',false);
    cDates( cellfun( @isempty, cDates ) ) = [];
else
    cDates = possibleCandidates_new(prevDimDenseUnits{:},nextDim);
end

% for i=1:length(prevDimDenseUnits)
%     for j=i+1:length(prevDimDenseUnits)
%         cDates = [cDates possibleCandidates(prevDimDenseUnits(i),prevDimDenseUnits(j),nextDim)];
%     end
% end

if(nextDim >=3)
idx =[];
% c=cell2mat(cellfun(@(x) reshape(sortrows(unique(x,'rows')),2*nextDim,1),cDates,'UniformOutput',false))';
c=cell2mat(cellfun(@(x) reshape(unique(x,'rows'),2*nextDim,1),cDates,'UniformOutput',false))';
d = unique(c,'rows');
for i=1:size(d,1)
    [~,k] = ismember(c,d(i,:),'rows');
%     [~,k] = builtin('_ismemberhelper',c, d(i,:),'rows');
    a1 = nnz(k) ;
    if(a1==nextDim*(nextDim-1)/2)
        idx =  [idx; find(k,1)];
    end
end
if(~isempty(idx))
    cDates = cDates(idx);
end

end
end


function bestcDates = possibleCandidates(dense1,dense2,nextDim)

goodcDates = [dense1{1}; dense2{1}];

isgood1 = size(unique(goodcDates,'rows'),1) == nextDim;
isgood2 = numel(unique(goodcDates(:,1))) == nextDim;

if isgood1 && isgood2
    bestcDates = {goodcDates};
else
    bestcDates = {};
end

end


% function cDates = findPrunedDenseUnitCandidates(prevDimDenseUnits,nextDim)
% cDates = {};
% 
% 
% end
