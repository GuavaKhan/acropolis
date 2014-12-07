load AXP_open.txt; 
edit AXP_open.txt;
open = AXP_open(:,1);
A = size(AXP_open)

load AXP_close.txt; 
edit AXP_close.txt;
close= AXP_close(:,1);

load AXP_high.txt; 
edit AXP_high.txt;
high= AXP_high(:,1);

load AXP_low.txt; 
edit AXP_low.txt;
low= AXP_low(:,1);

X = [ones(3746,1) open, close, high, low];

% Me doing OLS for the heck of it. we prolly wont use this. 
Weights = ((inv(X' * X) * X') * open);

% Lasso regression technique and cross validation plotting
[A,FitInfo] = lasso(X, open, 'Alpha', 1, 'CV', 10);
lassoPlot(A,FitInfo,'PlotType','CV');

% Elastic net regression technique and cross validation plotting
[B,FitInfo] = lasso(X, open, 'Alpha', 0.5, 'CV', 10);
lassoPlot(B,FitInfo,'PlotType','CV');

% Ridge regression technique and cross validation plotting
[C,FitInfo] = lasso(X, open, 'Alpha', realmin, 'CV', 10);
lassoPlot(C,FitInfo,'PlotType','CV');
