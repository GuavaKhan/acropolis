function ROC(output, target)
  clf;
	ROCPoints = ROCLoopValues(output, target);
  for i = 1:size(ROCPoints)(1)
   subplot(1, size(target)(2), i);
   hold on;
	 % Plot the data points computed for the ROC.
   plot((1 - ROCPoints{i}(:, 2)), ROCPoints{i}(:, 1), 'r*');
	 % Plot the random line, for reference.
	 plot((0:0.01:1)',(0:0.01:1));
   hold off;
  end
end
