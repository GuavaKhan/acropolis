%Author: Parker Temple for http://github.com/kwyjibo1230/acropolis
%Depends on sigm.m
source('sigm.m');

%Inputs:
%	xnorm: matrix of normalized independent variables to train on
%	trainingY: matrix of the dependent variable to train on
% initialized array of weights
% iterations: number of iterations to run stochastic gradient descent
% alpha: learning rate
%Ouputs:
%	w: the weights. number of values = to total number of variables trained on.
function [w] = logisticIterate(xnorm, trainingY, w, iterations, alpha)
	for k = 1:iterations,
		wold = w;
	  for i = 1:rows(xnorm),
			for j = 1:rows(w),
			  w(j) = w(j) + (alpha * sum((trainingY(i) - g(xnorm(i,:),wold)') * xnorm(i,j)));
			end 
	  end 
	end 
endfunction
