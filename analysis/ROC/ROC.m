%Graphs the ROC curve.
%output - the output from the predictor function
%target - the target for the values fed to the predictor
%maxIteration - maximum unmber of iteration for ROC to run
%defualt at 10,000
function ROC(output, target, maxIteration = 1e4)
  clf;
	%Compute data points
	ROCPoints = ROCLoopValues(output, target, maxIteration);
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
