%This function generates the ROC data points to graph. 
%Output-the actual output from the predictor (this is raw value
%	meaning not 0's and 1's but the actual percentages given by the predictor.
%Target- the actual class the corespond to the output, this vector is in 0's and 1'
%numberOfIteration- number of iteration to use as maximum when incrementing threshold.
%default at 10,000;
function [ROCPoints] = ROCLoopValues(output, target, maxIteration = 1e4)
  minimum = min(output);
  maximum = max(output);
	thresholds = zeros(1, size(target)(2));
	% Find the minimum differece in the threshold.
	% For each column
	for i = 1:size(target)(2)
		currentOutput = output(:,i);
		% Compute min interval to use in case the smallest different
		% is very small and impractical.
		minInterval = (maximum(1, i) - minimum(1, i)) / maxIteration; 
		% Find the smallest difference.
		minThershold = min(abs(diff(sort(currentOutput))));
		if (minThershold < minInterval)
			minThershold = minInterval;
		end
		thresholds(1, i) = minThershold;
	end
  %Create number of cells as the number of ROC graphs
	ROCPoints = cell(size(target)(2), 1);
	for i = 1:size(target)(2)
		% Init threshold.
		threshold = minimum(1, i);
		% NumberOfValues to compute for ROC graph.
		numberOfValues = ceil(((maximum(1, i) - minimum(1, i)) / thresholds(1, i)));
		values = zeros(numberOfValues, 2);
		%Initiate for loop
		thresholdOutput = output(:, i) > threshold;
		valueCount = 0;
		% Go till maximum value or a bit above.
		while (threshold <= (maximum(1, i) + thresholds(1, i)))
			valueCount += 1;
			%Compute confusion matrix
			confusionM = confusionMatrix(target(:, i), thresholdOutput);
			% Compute points for that threshold
			sensativity = confusionM(1, 1) / (confusionM(1, 1) + confusionM(1, 2));
      specificity = confusionM(2, 2) / (confusionM(2, 1) + confusionM(2, 2));
			values(valueCount,:) = [specificity, sensativity];
			%Increment threshold by minimum amount
			threshold = threshold + thresholds(1, i);
			thresholdOutput = output(:, i) > threshold;
		end
		% add ROCPoints set
		ROCPoints{i} = values;
	end

end
