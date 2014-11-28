function ROC(output, target)
  clf;
  % Source analysisTools directory
  source("../analysisTools/confusionMatrix.m");
	ROCPoints = ROCLoopValues(output, target);
  for i = 1:size(ROCPoints)(1)
   subplot(size(target)(2), 1, i);
   hold on;
   plot((1 - ROCPoints{i}(:, 2)), ROCPoints{i}(:, 1), 'r*');
	 plot((0:0.01:1)',(0:0.01:1));
   hold off;
  end
end
