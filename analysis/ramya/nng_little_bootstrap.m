%% Implementation of the little bootstrap (Breiman 1995)
%
% function err=nng_little_bootstrap(X,y,nreps,s)
% Estimate the prediction error for a particular value of 's'.
% This method can be used to find the best value of 's' for the
% non-negative garotte.
%
% Parameters:
%   X     = regressor matrix [n x p]
%   y     = targets [n x 1]
%   nreps = number of repetitions for the little bootstrap [1 x 1]
%   s     = garotte constraint parameter [1 x 1]
%
% Returns:
%   err   = prediction error estimate [1 x 1]
%
% References:
% 
% The Little Bootstrap and Other Methods for Dimensionality Selection in Regression: X-Fixed Prediction Error
% Leo Breiman
% Journal of the American Statistical Association, Vol. 87, No. 419 (Sep., 1992), pp. 738-754 
%
% (c) Copyright Enes Makalic and Daniel F. Schmidt, 2008

function err=nng_little_bootstrap(X,y,nreps,s)

% Initialise variables
[n, p]=size(X);
t=0.7;
beta_ls=X\y;
tau=(y-X*beta_ls)'*(y-X*beta_ls) / (n-p);

% Main loop
[~, ~, rss]=nng_garotte(X,y,s);
    
B=0;
for j=1:nreps        
    % Generate e from N(0, t^2 * tau)
    e=normrnd(0,t*sqrt(tau),n,1);

    %
    beta=nng_garotte(X,y+e,s);
    ypred=X*beta;

    % 
    B=B+e'*ypred/t^2;
end;

%
B=B/nreps;
err=rss+2*B;
