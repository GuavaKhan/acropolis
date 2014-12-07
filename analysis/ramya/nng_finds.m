%% Estimate 's' using either k-fold CV or the little bootstrap for the non-negative garotte.
% 
% function [beta,s,perror,se]=nng_finds(X,y,Options)
% Estimate 's' using either k-fold CV or the little bootstrap.
%
% Parameters:
%   X         = regressor matrix [n x p]
%   y         = targets [n x 1]
%   Options   = cell array of optional arguments (discussed below)
%
% Returns:
%   beta      = shrunken regression parameters [p x 1]
%   s         = estimated garotte constraint [1 x 1]
%   perror    = estimated prediction error [sgridsize x 1]
%   se        = bootstrapped betas using estimated s [1000 x p]
% 
% Options
%   Method    = Find best s using either 'kcv' or 'lb' (Default='kcv')
%   nfolds    = Number of folds for k-fold CV (Default='n')
%   nreps     = Number of repetitions for the little bootstrap (Default=25)
%   sgridsize = Number of points in the search grid for s (Default=20)
%   stderror  = If passed, return bootstrapped betas in se (Default=false)
% 
% Example
% [beta,s,perror,se]=nng_finds(X,y,{'Method','lb','nreps',100,'stderror'});
%
% (c) Copyright Daniel F. Schmidt and Enes Makalic, 2008

function [beta,s,perror,se]=nng_finds(X,y,Options)

% Data set size
[n,p]=size(X);

% Default Options
Method = 'kcv';
nfolds = n;
nreps = 25;
sgridsize = 20;
stderror = false;
se=[];

if exist('Options','var'),
% Process Options
    i = 1;
    while (i <= length(Options))
        if (strcmp(Options{i}, 'Method') == 1)
            Method = Options{i+1};
            i=i+1;
        elseif (strcmp(Options{i}, 'nfolds') == 1)
            nfolds = Options{i+1};
            i = i+1;
        elseif (strcmp(Options{i}, 'nreps') == 1)
            nreps = Options{i+1};
            i=i+1;            
        elseif (strcmp(Options{i}, 'sgridsize') == 1)
            sgridsize = Options{i+1};
            i=i+1;
        elseif (strcmp(Options{i}, 'stderror') == 1)
            stderror = true; 
        else
            error('Unknown option: %s\n', Options{i});
        end
        
        i = i+1;
    end
end

% Main loop
s=linspace(1e-3,p,sgridsize);
perror=zeros(length(s),1);

for i=1:length(s)  
    % 
    if(strcmp(Method,'kcv') == 1)
        perror(i)=nng_kcv(X,y,nfolds,s(i));
    elseif(strcmp(Method,'lb') == 1)
        perror(i)=nng_little_bootstrap(X,y,nreps,s(i));
    end;
end;

% Find best s
[~, ind]=min(perror);
s=s(ind);
beta=nng_garotte(X,y,s);

% Return standard error of betas conditioned on s
if(stderror)
    se = bootstrp(1000, @(x,y) nng_garotte(x,y,s), X,y);
end;
