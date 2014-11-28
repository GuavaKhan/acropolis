%Compute area under the curve of an ROC graph
%Output - of the predictor (to be used for ROC computation)
%target - the target values of the predictor for the ROC
%returns a list of all the AUC computed
function area = AUC(output, target)
  %Add other directories
  addpath("../.");
  ROCPoints = ROCLoopValues(output, target);
  area = ones(1, size(ROCPoints)(1));
  %Compute AUC for each ROC curve computed
  for i = 1:size(ROCPoints)(1)
    values = ROCPoints{i};
    a = values(2:end ,:);
    b = values(1:(end - 1) ,:);
    h = a(:,1) - b(:,1);
    area(1, i) = sum(trapeziodArea(a(:,2), b(:,2), h));
  end
end
