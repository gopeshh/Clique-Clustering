function denseU = newDense(xUnit,nextDim)
isgood1 = size(unique(xUnit,'rows'),1) == nextDim;
isgood2 = numel(unique(xUnit(:,1))) == nextDim;

% mObj = containers.Map;
% if (isKey(mObj,xUnit(:,1)))
%     oldUnit = mObj(xUnit(:,1));
%     mObj(xUnit(:,1)) = {[oldUnit; xUnit(:,2)]};
% else    
%  mObj(xUnit(:,1)) = {xUnit(:,2)};   
% end
if(isgood1&&isgood2)
 denseU = {xUnit(:,1)', xUnit(:,2)'};
else
    denseU = {};
%     denseU = {zeros(1,length(xUnit)),zeros(1,length(xUnit))};
end