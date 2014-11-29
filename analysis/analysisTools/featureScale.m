function [Xscaled, Yscaled] = featureScale(X, Y)

	%This function zero-centers and re-scales data. For each attribute xij in feature column j, it subtracts the mean of j from xij and then divides xij by the norm of j.
	%In other words function takes non-scaled data and outputs scaled data such that every vector has zero mean and unit length.
	%eg, for every attribute xij, xij = (xij - mean(xj)) / norm(xj).
	%I added this because many regression techniques, including the elastic net code I just submitted, assume that data has been centered and scaled during preprocessing, such that
	%the feature and solution vectors all have zero mean and unit length.
	
	Xscaled = X;
	Yscaled = Y;

	m = mean(Y);												%gets the mean of Y
	Yscaled = Y - m;										%subtracts the mean from every element in Y
	
	n = norm(Yscaled);									%calculates the norm, eg length, of Yscaled
	
	if(n == 0)
		n = 1;														%This eliminates the unlikely possibility of a divide by zero error
	endif
	
	Yscaled = Yscaled / n;							%Divides every attribute in Yscaled by the norm
	
	rowsX = rows(X);
	colsX = columns(X);

	m = 0;
	n = 0;
	
	for(i = 1:colsX)
		m = mean(X(:,i));
		Xscaled(:,i) = (X(:,i) - m);			%subtracts the mean of X from every attribute in feature column Xi of the scaled result matrix
		
		n = norm(Xscaled(:,i));						%gets the norm of column Xi of scaled result matrix
			
		if(n == 0)
			n = 1;
		endif
		
		Xscaled(:,i) = Xscaled(:,i) / n		%divides scaled result matrix feature column by its norm (in other words, the scaling actually happens here).
	endfor
	
	disp("done scaling data");

endfunction