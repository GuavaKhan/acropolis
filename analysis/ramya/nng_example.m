clear;

% Load the Boston housing data set
load('boshouse');

% Extract regressors and targets
X=boshouse(:,2:13);
y=boshouse(:,1);

% Standardise regressors
Xstd=zscore(X);

% Find best 's' using LOO CV
fprintf('Fitting data using LOO CV...');
[beta_cv,s_cv,perror_cv,se_cv]=nng_finds(Xstd,y,{'Method','kcv','stderror'});
fprintf('done.\n');

% Plot the standard errors for betas given the best s
figure(1);
hold on;
title(sprintf('Bootstrapped standard errors for beta using s = %g (LOO CV)',s_cv));
boxplot(se_cv,'labels',{'CRIM','ZN','INDUS','NOX','RM','AGE','DIS','RAD','TAX','PTRATIO','B','LSTAT'});
hold off;

% Find best 's' using the little bootstrap
fprintf('Fitting data using the little bootstrap...');
[beta_lb,s_lb,perror_lb,se_lb]=nng_finds(Xstd,y,{'Method','lb','nreps',100,'stderror'});
fprintf('done.\n');

% Plot the standard errors for betas given the best s
figure(2);
hold on;
title(sprintf('Bootstrapped standard errors for beta using s = %g (little bootstrap)',s_lb));
boxplot(se_lb,'labels',{'CRIM','ZN','INDUS','NOX','RM','AGE','DIS','RAD','TAX','PTRATIO','B','LSTAT'});
hold off;
