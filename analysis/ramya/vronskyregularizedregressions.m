function [X, Y, results] = vronskyregularizedregressions()
	companies = dir('../../companiesData/');
	numberOfCompanies = size(companies);
	numberOfCompanies = numberOfCompanies(1);
	base = '../../companiesData/';
	results = ones(28, 5);
	for i = 3:28
		i
		company = companies(i).name;
		open = load(strcat(base, company, '/', company, '_open.txt')); 
		close = load(strcat(base, company, '/', company, '_close.txt')); 
		high = load(strcat(base, company, '/', company, '_high.txt')); 
		low = load(strcat(base, company, '/', company, '_low.txt')); 
		volume = load(strcat(base, company, '/', company, '_volume.txt')); 
		%size(open)
		%size(close)
		%size(high)
		%size(low)
		%size(volume)
		X = [ones(3746,1), open, close, high, low];
		Y = load(strcat(base, company, '/', company, '_dailyTrailing.txt')); 
		% Me doing OLS for the heck of it. we prolly wont use this. 
		Weights = ((inv(X' * X) * X') * Y);
		results(i - 2, 1) = mean(power((Y - X * Weights), 2));
		% Lasso regre jkjkiission technique and cross validation plotting
		[A,FitInfo] = lasso(X, Y, 'Alpha', 1, 'CV', 10);
		%lassoPlot(A,FitInfo,'PlotType','CV');
		results(i - 2, 2) = FitInfo.SE(FitInfo.IndexMinMSE);
		% Elastic net regression technique and cross validation plotting
		[B,FitInfo] = lasso(X, Y, 'Alpha', 0.5, 'CV', 10);
		%lassoPlot(B,FitInfo,'PlotType','CV');
		results(i - 2, 3) = FitInfo.SE(FitInfo.IndexMinMSE);

		% Ridge regression technique and cross validation plotting
		[C,FitInfo] = lasso(X, Y, 'Alpha', realmin, 'CV', 10);
		%lassoPlot(C,FitInfo,'PlotType','CV');
		results(i - 2, 4) = FitInfo.SE(FitInfo.IndexMinMSE);		
	end
	results
end
