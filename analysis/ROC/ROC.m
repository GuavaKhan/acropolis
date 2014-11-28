function ROC(output, target)
  clf;
  % Source analysisTools directory
  source("../analysisTools/confusionMatrix.m");
	ROCPoints = ROCLoopValues(output, target);
  for i = 1:size(ROCPoints)(1)
   subplot(size(target)(2), 1, i);
   hold on;
   plot((1 - ROCPoints{i}(:, 2)), ROCPoints{i}(:, 1), 'r*');
   hold off;
  ends
end
