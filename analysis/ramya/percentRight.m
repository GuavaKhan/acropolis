function [X, Y, Xtrain, Ytrain, Weights, posnev, inRange] = percentRight(thresholdRange)
	companies = dir('../../companiesData/');
	numberOfCompanies = size(companies);
	numberOfCompanies = numberOfCompanies(1);
	base = '../../companiesData/';
	posnev = zeros(26, 5);
    	inRange = zeros(26,5);
	for i = 3:28
		i
		company = companies(i).name;
		open = load(strcat(base, company, '/', company, '_open.txt')); 
		close = load(strcat(base, company, '/', company, '_close.txt')); 
		high = load(strcat(base, company, '/', company, '_high.txt')); 
		low = load(strcat(base, company, '/', company, '_low.txt'));  
		%size(open)
		%size(close)
		%size(high)
		%size(low)
		%size(volume)
		X = [ones(3746,1), open, close, high, low];
		Y = load(strcat(base, company, '/', company, '_dailyTrailing.txt'));
		shuffleBy = randperm(length(Y));
		X = X(shuffleBy,:);
		Y = Y(shuffleBy,:);
		trainRange = floor(length(X) * 0.10);
		Xtrain = X(1:trainRange,:);
		Ytrain = Y(1:trainRange,:);
		X = X(trainRange + 1:end, :);
		Y = Y(trainRange + 1:end, :);
		% Me doing OLS for the heck of it. we prolly wont use this.
		Weights = ((inv(X' * X) * X') * Y);
		predicted = Xtrain * Weights;
		predicted = abs(predicted - Ytrain) < thresholdRange;
		r = sum(predicted) / length(Ytrain);
		inRange(i - 2, 1) = r;
		posnev(i - 2, 1) = ...
			sum((predicted > 0) == (Ytrain > 0)) / length(Ytrain);
		% Lasso regre technique and cross validation plotting
		[A,FitInfo] = lasso(X, Y, 'Alpha', 1, 'CV', 10);
		predicted = Xtrain * A(:, FitInfo.IndexMinMSE);
		predicted = abs(predicted - Ytrain) < thresholdRange;
		r = sum(predicted) / length(Ytrain);
		inRange(i - 2, 2) = r;
		posnev(i - 2, 2) = ...
			sum((predicted > 0) == (Ytrain > 0)) / length(Ytrain);
		% Elastic net regression technique and cross validation plotting
		[B,FitInfo] = lasso(X, Y, 'Alpha', 0.5, 'CV', 10);
		predicted = Xtrain * B(:, FitInfo.IndexMinMSE);
		predicted = abs(predicted - Ytrain) < thresholdRange;
		r = sum(predicted) / length(Ytrain);
		inRange(i - 2, 3) = r;
		posnev(i - 2, 3) = ...
			sum((predicted > 0) == (Ytrain > 0)) / length(Ytrain);
		% Ridge regression technique and cross validation plotting
		[C,FitInfo] = lasso(X, Y, 'Alpha', realmin, 'CV', 10);
		predicted = Xtrain * C(:, FitInfo.IndexMinMSE);
		predicted = abs(predicted - Ytrain) < thresholdRange;
		r = sum(predicted) / length(Ytrain);
		inRange(i - 2, 4) = r;
		posnev(i - 2, 4) = ...
			sum((predicted > 0) == (Ytrain > 0)) / length(Ytrain);
		%nng
		[beta, s, perror, se] = nng_finds(X, Y, {'nfolds', 10});
		predicted = Xtrain * beta;
		predicted = abs(predicted - Ytrain) < thresholdRange;
		r = sum(predicted) / length(Ytrain);
		inRange(i - 2, 5) = r;
		posnev(i - 2, 5) = ...
			sum((predicted > 0) == (Ytrain > 0)) / length(Ytrain);
    		
	end
	dlmwrite('./posnev.txt', posnev);
	dlmwrite('./inRange.txt', inRange);
end
