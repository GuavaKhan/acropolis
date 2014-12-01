%Graphs the PR curve.
%output - the output from the predictor function
%target - the target for the values fed to the predictor
%maxIteration - maximum unmber of iteration for PR to run
%defualt at 10,00;
function PR(output, target, maxIteration = 1e4)
  clf;
	PRPoints = PRLoopValues(output, target, maxIteration);
  for i = 1:size(PRPoints)(1)
   subplot(1, size(target)(2), i);
   hold on;
	 % Plot the data points computed for the PR.
   plot(PRPoints{i}(:, 1), PRPoints{i}(:, 2), 'r*');
   hold off;
  end
end
