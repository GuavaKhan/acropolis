function yfit = predfun(XTRAIN, ytrain, XTEST)
	ols = inv(XTRAIN' * XTRAIN)*XTRAIN'*ytrain;
	yfit = XTEST * ols;

end
