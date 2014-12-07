function [X, Y, results, times] = vronskyregularizedregressions()
	companies = dir('../../companiesData/');
	numberOfCompanies = size(companies);
	numberOfCompanies = numberOfCompanies(1);
	base = '../../companiesData/';
	results = ones(28, 5);
    times = zeros(1,5);
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
		% Me doing OLS for the heck of it. we prolly wont use this.
        tic;
		Weights = ((inv(X' * X) * X') * Y);
		results(i - 2, 1) = mean(power((Y - X * Weights), 2));
        runTime = toc;
        times(1, 1) = times(1, 1) + runTime;
		% Lasso regre jkjkiission technique and cross validation plotting
        tic;
		[A,FitInfo] = lasso(X, Y, 'Alpha', 1, 'CV', 10);
        runTime = toc;
		%lassoPlot(A,FitInfo,'PlotType','CV');
		results(i - 2, 2) = FitInfo.SE(FitInfo.IndexMinMSE);
        times(1, 2) = times(1, 2) + runTime;
		% Elastic net regression technique and cross validation plotting
        tic;
		[B,FitInfo] = lasso(X, Y, 'Alpha', 0.5, 'CV', 10);
        runTime = toc;
		%lassoPlot(B,FitInfo,'PlotType','CV');
		results(i - 2, 3) = FitInfo.SE(FitInfo.IndexMinMSE);
        times(1, 3) = times(1, 3) + runTime;
		% Ridge regression technique and cross validation plotting
		tic;
        [C,FitInfo] = lasso(X, Y, 'Alpha', realmin, 'CV', 10);
		runTime = toc;
        %lassoPlot(C,FitInfo,'PlotType','CV');
		results(i - 2, 4) = FitInfo.SE(FitInfo.IndexMinMSE);
        times(1, 4) = times(1, 4) + runTime;
        %nng
        tic;
        [beta, s, perror, se] = nng_finds(X, Y, {'nfolds', 10});
        runTime = toc;
        results(i - 2, 5) = min(perror);
        times(1, 5) = times(1, 1) + runTime;
    end
    times = times ./ 28;
    %output format each row is a company columns=[ols,lasso, elastic, ridge,
    %nng]
    dlmwrite('./MSE.txt', results);
    %outout format each colum is the averge running time for each algorithm
    %col = [ols, lasso, elastic, ridge, nng]
    dlmwrite('./times.txt', times);
end
