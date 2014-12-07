%% Implementation of L. Breiman's non-negative garrote.
%
% function [beta shrcf rss]=nng_garotte(X,y,s)
% Implementation based on L. Breiman's original FORTRAN code.
%
% Parameters:
%   X     = regressor matrix [n x p]
%   y     = targets [n x 1]
%   s     = garotte constraint parameter [1 x 1]
%
% Returns:
%   beta  = shrunken regression parameters [p x 1]
%   shrcf = shrinkage coefficients [p x 1]
%   rss   = residual sum of squares [1 x 1]
%
% References:
%
% (1) Better Subset Regression Using the Nonnegative Garrote
% Leo Breiman
% Technometrics, Vol. 37, No. 4 (Nov., 1995), pp. 373-384 
%
% (2) A Tutorial on the SWEEP Operator
% James H. Goodnight
% The American Statistician, Vol. 33, No. 3 (Aug., 1979), pp. 149-158 
%
% (3) Solving Least Squares Problems
% Charles L. Lawson and Richard J. Hanson
% pp. 161
%
% (c) Copyright Daniel F. Schmidt and Enes Makalic, 2008

function [beta shrcf rss]=nng_garotte(X,y,s)

%% Initialise variables 
xx=X'*X;
xy=X'*y;
yy=y'*y;
bols=X\y;

%% Solve sum_i c_i < s using the barrier method
con=1000;
tol=0.001;  

xy=bols .* xy / s;
xx=bols*bols' .* xx;
yy=yy/s^2;

done=false;
iters=1;
while(~done && iters < 100)
    xy=xy + (con / s);
    xx=xx + (con / s);
    yy=yy + (con / s);

    % Lawson and Hansen algorithm for solving NNLS
    shrcf=nnls(xx,xy,yy);

    ssum=sum(shrcf);
    shrcf=s*shrcf;

    if(abs(ssum-1.0)>tol)
        con=10*con;
    else
        done=true;
    end;
    
    iters=iters+1;
end;

% Shrunken betas
beta=bols.*shrcf;

% RSS
rss=(y-X*beta)'*(y-X*beta);

%% Solve NNLS by the Lawson and Hansen algorithm
function bt=nnls(xx,xy,yy)

%% Initialise variables
m=length(xx);
z=ones(m,1);
bt=zeros(m,1);
bs=zeros(m,1);
u=zeros(m+1,m+1);

%% Setup 'sweep' matrix
u(1:m,1:m)=xx;
u(1:m,m+1)=xy;
u(m+1,1:m)=xy';
u(m+1,m+1)=yy;

%% Main algorithm
done=false;
loopa=true;
while(~done)

    %% Loop A    
    if(loopa)
        % Compute derivatives w.r.t. beta (Step 2)
        w=xy-xx*bt;

        % If all remaining derivatives are less than zero (Step 3)
        ix=find(z==1);
        if(sum(z) == 0 || max(w(ix)) <= 0)
            return; % we are done
        end;

        % Find the next variable to enter (Step 4)
        [~,wt]=max(w(ix));
        wt=ix(wt);

        % Move the index t from set Z (Step 5)
        z(wt)=0;
        u=sweep(u,wt);
    end;
    
    % Compute the LS solution (Step 6)
    ix=find(z==0);
    bs(ix)=u(ix,m+1);

    % If all coefficients are non-negative, betas are fine (Step 7)
    if(min(bs(ix)) > 0)
        bt=bs;
        loopa=true;
        continue;
    end;
    
    %% Loop B
    loopa=false;

    % (Step 8)
    g=bt ./ (bt - bs);
    ix=find((bs<=0) .* (z == 0));

    % (Step 9)
    alpha=min(g(ix));
    
    % Fix for numerical problems (?)
    if(alpha==0)
            return;
    end;
    
    % (Step 10)
    bt=bt+alpha*(bs-bt);

    % (Step 11)
    [~,ind]=min(g(ix));
    ind=ix(ind);
    u=sweep(u,ind);
end;

%% Sweep operator (Goodnight 1979, page 154)
%  Given a matrix v, and k
function v=sweep(v,k)

m=length(v);
td=v(k,k);

if(td < 1e-10)
    warning('Small');
end;

v(k,:)=v(k,:)/td;
for i=1:m
    if(i == k)
        continue;
    end;
    
    ct=v(i,k);
    v(i,:)=v(i,:)-ct*v(k,:);
    v(i,k)=-ct/td;
end;
v(k,k)=1/td;    
