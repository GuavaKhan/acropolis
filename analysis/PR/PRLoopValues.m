%This function generates the PR data points to graph. 
%output-the actual output from the predictor (this is raw value
%	meaning not 0's and 1's but the actual percentages given by the predictor.
%target- the actual class the corespond to the output, this vector is in 0's and 1'
%maxIteration -  number of iteration to use as maximum when incrementing threshold.
%default at 10,000;
function [PRPoints] = PRLoopValues(output, target, maxIteration = 1e4)
  minimum = min(output);
  maximum = max(output);
	thresholds = zeros(1, size(target)(2));
	% Find the minimum differece in the threshold.
	% For each column
	for i = 1:size(target)(2)
		currentOutput = output(:,i);
		% Compute min-interval to use in case the smallest difference
		% is very small and impractical.
		minInterval = (maximum(1, i) - minimum(1, i)) / maxIteration; 
		% Find the smallest difference.
		minThershold = min(abs(diff(sort(currentOutput))));
		% If too small use min-interval.
		if (minThershold < minInterval)
			minThershold = minInterval;
		end
		thresholds(1, i) = minThershold;
	end
  %Create number of cells as the number of PR graphs
	PRPoints = cell(size(target)(2), 1);
	for i = 1:size(target)(2)
		% Init threshold.
		threshold = minimum(1, i);
		% NumberOfValues to compute for ROC graph.
		%Initiate for loop
		thresholdOutput = output(:, i) > threshold;
		valueCount = 0;
		if(thresholds(1, i) == 0)
			values = ones(1, 2);
			values(valueCount + 1,:) = [0, 0];
		else
			numberOfValues = ceil(((maximum(1, i) - minimum(1, i)) / thresholds(1, i)));
			values = zeros(numberOfValues, 2);
			% Go till maximum value or a bit above.
			while (threshold <= (maximum(1, i) + thresholds(1, i)))
				valueCount += 1;
				%Compute confusion matrix
				confusionM = confusionMatrix(target(:, i), thresholdOutput);
				% Compute points for that threshold
				sensativity = confusionM(1, 1) / (confusionM(1, 1) + confusionM(1, 2));
				precision = confusionM(1, 1) / (confusionM(1, 1) + confusionM(2, 1));
				values(valueCount,:) = [sensativity, precision];
				%Increment threshold by minimum amount
				threshold = threshold + thresholds(1, i);
				thresholdOutput = output(:, i) > threshold;
			end
		end
		% add PRPoints set
		PRPoints{i} = values;
	end

end
