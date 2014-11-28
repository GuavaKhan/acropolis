function [X, binaryFieldArray] = readCoStateFieldDate(filename)

	inFile = fopen(filename, 'r');

	X = [];
	binaryFieldArray = [];
	
	while true
	
		line = fgetl(inFile);															%Reads line in from file

		if(line == -1)																		%Termination condition. True when we reach EOF.
			break;
		endif

		tokenized_line = strsplit(line, " ,[]");					%breaks the line into tokens, each token is the value of a feature		

		emptyCells = cellfun(@isempty, tokenized_line);		%removes empty cells
		tokenized_line(emptyCells) = [];
		
		len = length(tokenized_line);											%should be 24
		
		for(i = 2:(len - 1))
		
			feat = tokenized_line{1,i};	
			binaryFieldArray = [binaryFieldArray, str2num(feat)];

		endfor
		
		X = [X, str2num(tokenized_line{1,1})];							%puts the features into the array of features X
		X = [X, sum(binaryFieldArray)];
		X = [X, str2num(tokenized_line{1,len})];
	
	endwhile

endfunction

%Output
%X = [State, Number Of Fields, Company Founding Date]
%binaryFieldArray = [1, 0, ... 1, 0], the fields the company does business in.