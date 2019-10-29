function bestcDates = possibleCandidates_new(combs,nextDim)

% combs1 = [combs{1,:};combs{2,:}];
% combs2 = mat2cell(combs1,2,2*ones(1,size(combs,2)));

% goodcDates = [dense1{1}; dense2{1}];

isgood1 = size(unique(combs,'rows'),1) == nextDim;
isgood2 = numel(unique(combs(:,1))) == nextDim;

if isgood1 && isgood2
    bestcDates = combs;
else
    bestcDates = {};
end

end