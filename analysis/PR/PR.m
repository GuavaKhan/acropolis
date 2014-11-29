function PR(output, target)
  clf;
	PRPoints = PRLoopValues(output, target);
  for i = 1:size(PRPoints)(1)
   subplot(1, size(target)(2), i);
   hold on;
	 % Plot the data points computed for the PR.
   plot(PRPoints{i}(:, 1), PRPoints{i}(:, 2), 'r*');
   hold off;
  end
end
