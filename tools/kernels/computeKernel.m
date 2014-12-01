% This function computes the kernel matrix given a specific kernel function

% samples is the matrix of each samples features
% kernel_function is the function handle of the chose kernel function
% varargin are the optional args for the kernel function

% sample usage: ComputerKernel( samples, @LinearKernel, 'c', 3 )
% returns ans = [5 6; 6 8]

function kernel_matrix = ComputeKernel( samples, kernel_function, varargin )

	% m rows n columns
	num_rows    = size(samples, 1);
	num_columns = size(samples, 2);

	kernel_matrix = zeros(num_rows);

	for m = 1:num_rows
		for n = m:num_rows

			% compute the symmetric kernel matrix
			kernel_matrix(m,n) = kernel_function( samples(m,:), samples(n,:), varargin{:} );
			kernel_matrix(n,m) = kernel_matrix(m,n);

		end
	end

end