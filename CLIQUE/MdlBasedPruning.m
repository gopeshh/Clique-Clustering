function denseUnits = MdlBasedPruning(denseUnits,data,tau)
coverage = zeros(1,size(denseUnits,2));
for i=1:size(denseUnits,2)
    [~, resultIdx] = ismember(data(:,denseUnits{i}{1}),denseUnits{i}{2},'rows');
    countVal = accumarray(resultIdx(resultIdx>0),1);
    isDense = countVal>tau*size(data(:,denseUnits{i}{1}),1);
    denseUnits{i}{2} = denseUnits{i}{2}(isDense,:);
   countValActual = countVal(isDense);
%    coverage(i) = sum(countValActual)/size(data(:,denseUnits{i}{1}),1);
   coverage(i) = sum(countValActual);
end
[covDescend, descendIdx] = sort(coverage,'descend');
% subspaceOrdered = 
i = optimizableVariable('i',[1,size(denseUnits,2)],'Type','integer');
 CL =    @(v)arrayfun(@(i)log2(max(1,mean(v(1:i))))+sum(log2(max(1,abs(mean(v(1:i))-v(1:i)))))+log2(max(1,mean(v(i+1:end))))+sum(log2(max(1,abs(mean(v(i+1:end))-v(i+1:end))))),1:numel(v));
figure;plotyy(1:numel(covDescend),covDescend,1:numel(covDescend),CL(covDescend)); legend('coverage','CL')

fun = @(x) log2(sum(covDescend(1:x.i))/x.i) + log2(sum(covDescend(x.i+1:end))/(size(denseUnits,2)-x.i)) + ...
      sum(log2(abs(covDescend- sum(covDescend(1:x.i))/x.i))) + ... 
      sum(log2(abs(covDescend - sum(covDescend(x.i+1:end))/(size(denseUnits,2)-x.i))));
  results = bayesopt(fun,i,'IsObjectiveDeterministic',1,'PlotFcn',@plotConstrainedModels);
  
end