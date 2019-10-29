subspaceOrdered = [];
subspaceOrdered = [subspaceOrdered;cellfun(@(x) x{1},denseUnits(descendIdx),'UniformOutput',false)];
t3 = table(subspaceOrdered',covDescend');
t3.Properties.VariableNames{1} = 'Subspace';
t3.Properties.VariableNames{2} = 'Coverage';
for i = 1:size(denseUnits,2)
var1(i) = log2(sum(covDescend(1:i))/i);
var2(i) = log2(sum(covDescend(i+1:end))/(size(denseUnits,2)-i));
var3Tmp = log2(abs(covDescend- var1(i)));
var3(i) = sum(var3Tmp(1:i));
var4Tmp = log2(abs(covDescend - var2(i)));
var4(i) = sum(var4Tmp(i+1:end));
fcov1(i) = var1(i) + var2(i) + ...
var3(i) + ...
var4(i);
end

t3.Var1 = var1';
t3.Var2 = var2';
t3.Var3 = var3';
t3.Var4 = var4';
t3.CL = fcov1';