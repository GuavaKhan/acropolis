%Author: Parker Temple for http://github.com/kwyjibo1230/acropolis
%Depends on logisticIterate.m
source('logisticIterate.m');

%Inputs:
%	trainingX: matrix of independent variables to train on
%	trainingY: matrix of the dependent variable to train on
% iterations: number of iterations to run stochastic gradient descent
% alpha: learning rate
%Ouputs:
%	w: the weights. number of values = to total number of variables trained on.
function [w, means, ranges] = logisticTraining(trainingX, trainingY, iterations, alpha)
	xnorm = trainingX;
	means = [];
	ranges = [];
	%Normalizes trainingX
	for i = 1:columns(xnorm),
		means(i) = mean(trainingX(:,i));
		ranges(i) = range(trainingX(:,i));
		xnorm(:,i) = (xnorm(:,i)-mean(xnorm(:,i)))/(range(xnorm(:,i)));
	end
	xnorm = [ones(rows(trainingX), 1), xnorm];

	%run stochastic gradient descent
	w = [];
	%adds a columns of weights for each class in trainingY
	for j = 1:columns(trainingY)
		w = horzcat(w, logisticIterate(xnorm, trainingY(:,j), zeros(columns(trainingX)+1,1), iterations, alpha));
	endfor
endfunction
