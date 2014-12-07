%% k-fold cross validation
% 
% function err=nng_kcv(X,y,nfolds,s)
% Implementation of k-fold cross validation.
%
% Parameters:
%   X      = regressor matrix [n x p]
%   y      = targets [n x 1]
%   nfolds = number of folds [1 x 1]
%   s      = garotte constraint parameter [1 x 1]
%
% Returns:
%   err    = prediction error estimate [1 x 1] 
% 
% References:
%
% Cross-Validatory Choice and Assessment of Statistical Predictions
% M. Stone
% Journal of the Royal Statistical Society. Series B (Methodological), Vol. 36, No. 2 (1974), pp. 111-147 
%
% (c) Copyright Enes Makalic and Daniel F. Schmidt, 2008

function err=nng_kcv(X,y,nfolds,s)

% Initialise variables
[n,p]=size(X);
ind=randperm(n);
f=ceil(n/nfolds);

% Main loop
q=1;
err=0;
for i=1:nfolds   
    % Extract test data    
    it=q:min(q+f-1,n);
    Xts=X(ind(it),:);
    yts=y(ind(it),:);
    
    % Extract training data
    ix=setdiff(ind,it);
    Xtr=X(ind(ix),:);
    ytr=y(ind(ix),:);
        
    % Fit model
    beta=nng_garotte(Xtr,ytr,s);
    
    % Generalisation error   
    perror=(yts-Xts*beta)'*(yts-Xts*beta);
    err=err+perror/length(it);    
    
    % Get the next block
    q = q+f;
end;

% Prediction error estimate
err=err/nfolds;
