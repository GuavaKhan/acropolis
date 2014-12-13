%Author: Parker Temple for http://github.com/kwyjibo1230/acropolis
%Depends on sigm.m
source('sigm.m');

%Inputs:
%	sample: matrix of samples to predict
%	w: array of weights from logisticTraining
%	means: array of means from logisticTraining
%	ranges: array of ranges from logisticTraining
%Ouputs:
%	prediction: array of predictions for each sample
function [prediction] = logisticPredict(sample, w, means, ranges, numClasses)
	%normalize the sample the same as the trainingX
	for i = 2:columns(sample),
		sample(i) = (sample(i)-means(i-1))/ranges(i-1);
	end
	%predict our sample(s)
	rowCount = size(sample)(1);
	sample = horzcat(ones(rowCount, 1), sample);
	sample
	prediction = g(sample, w);
endfunction
