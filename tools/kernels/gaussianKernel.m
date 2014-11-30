


function kernel_matrix_element = GaussianKernel(sample1, sample2, varargin)

	% set defaults for the function
	opts = struct('sigma', 1);

	% get all default fieldnames from struct
	all_opt_names = fieldnames(opts);

	% varargin is divisble by two
	assert( ~mod(length(varargin), 2), ['Parameters are passed as ' ...
		'name/value pairs. Number of parameters must be divisible by two ' ...
		'%d parameters were passed in.'], length(varargin) );

	% two assertions that make sure inputs were one samples features
	assert(isrow(sample1), ['First input to LinearKernel() was not a ' ...
		'single sample. Its dimensions were: %dx%d'], size(sample1) );

	assert(isrow(sample2), ['Second input to LinearKernel() was not a ' ...
		'single sample. Its dimensions were: %dx%d'], size(sample2) );
	
	% if false the matrix operations will fail
	assert(size(sample1) == size(sample2), 'Samples were not same size.');

	% set default value for c
	% use nargin because it's faster in tight loops than exists()
	if( ~isempty(varargin) )
		for pair = reshape(varargin, 2, [])
			opts.(lower(pair{1})) = pair{2};
		end
	end




end


