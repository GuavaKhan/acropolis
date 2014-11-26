%Author: Parker Temple for http://github.com/kwyjibo1230/acropolis
%Depends on sigm.m
source('sigm.m');

%Inputs:
%	trainingX: matrix of independent variables to train on
%	trainingY: matrix of the dependent variable to train on
% iterations: number of iterations to run stochastic gradient descent
% alpha: learning rate
%Ouputs:
%	w: the weights. number of values = to total number of variables trained on.
function [w, means, ranges] = logisticTraining(trainingX, trainingY, iterations, alpha)
	w = zeros(columns(trainingX)+1, 1);
	xnorm = trainingX;
	means = [];
	ranges = [];
	%Normalizes the xmatrix
	for i = 1:columns(xnorm),
		means(i) = mean(trainingX(:,i));
		ranges(i) = range(trainingX(:,i));
		xnorm(:,i) = (xnorm(:,i)-mean(xnorm(:,i)))/(range(xnorm(:,i)));
	end
	xnorm = [ones(rows(trainingX), 1), xnorm]
	%run stochastic gradient descent
	for k = 1:iterations,
		wold = w;
		for i = 1:rows(xnorm),
			for j = 1:rows(w),
				w(j) = w(j) + (alpha * sum((trainingY(i) - g(xnorm(i,:),wold)') * xnorm(i,j)));
			end
		end
	end
endfunction
