function Weights = ridgeRegression(X, Y, lambda)

	Xt = transpose(X);
	XtX = Xt*X;
	I = eye(rows(XtX), columns(XtX));
	
	Weights = inverse( XtX + (lambda*I) )*Xt*Y;

endfunction