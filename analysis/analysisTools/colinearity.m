
% hard coded, function needs to be run in this folder
companies = dir('../../companiesData/');
numberOfCompanies = size(companies);
numberOfCompanies = numberOfCompanies(1);
base = '../../companiesData/';

fid = fopen('../results/r_squared.txt', 'w');
fprintf(fid, 'The matrices have the format of open, close, high, low on both columns and rows.\n');
fprintf(fid, 'Each matrix has a diagonal of 1 which corresponds to a feature regressed against itself. \n');
fprintf(fid, 'Because the values are so high, it demonstrates the features are highly colinear/correlated.\n\n');

for i = 4:29

	% pick company
	company = companies(i).name;
	
	% load data
	open = load(strcat(base, company, '/', company, '_open.txt')); 
	close = load(strcat(base, company, '/', company, '_close.txt')); 
	high = load(strcat(base, company, '/', company, '_high.txt')); 
	low = load(strcat(base, company, '/', company, '_low.txt'));

	parameters = {open, close, high, low};
	r_squared_matrix = ones(4,4);

	fprintf(fid, '%s r_squared_matrx \n', company );


	for j = 1:4
		for k = 1:4

			p = polyfit(parameters{j}, parameters{k}, 1);
			y_fit = polyval(p, parameters{j});
			residual = parameters{k} - y_fit;
			sum_squared_residual = sum(residual.^2);
			sum_squared_total = (length(parameters{k})-1) * var(parameters{k});
			r_squared = 1 - sum_squared_residual/sum_squared_total;

			r_squared_matrix(j,k) = r_squared;

		end
	end

	fclose(fid);
	dlmwrite('../results/r_squared.txt', r_squared_matrix, '-append', 'delimiter', ' ', 'roffset', 1);
	fid = fopen('../results/r_squared.txt', 'a');
	fprintf(fid, '\n');


end

fclose(fid);



