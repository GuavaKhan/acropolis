% Returns value of polynomial kernel computation run on two samples
% sample1 and sample2 are two vectors from the input space e.g. a single sample
% with any subset of the feature space
% varargin contains the optional inputs pass inputs in as name/value pairs
% e.g. ('option_name', option_value)
% c is a numeric constant i.e. y-intercept
% order is the polynomial order
% slope is self-explanatory

% sample usage: 
% PolynomialKernel([1 1], [1 2], 'c', 3, 'order', 2, 'slope', 1) = 36

function kernel_matrix_element = PolynomialKernel(sample1, sample2, varargin)

	% set defaults for function
	opts = struct( 'c', 0, 'order', 1, 'slope', 1 );

	% get all default fieldnames from struct
	all_opt_names = fieldnames(opts);

	% varargin is divisble by two
	assert( ~mod(length(varargin), 2), ['Parameters are passed as ' ...
		'name/value pairs. Number of parameters must be divisible by two ' ...
		'%d parameters were passed in.'], length(varargin) );

	% two assertions that make sure inputs were one samples features
	assert( isrow(sample1), ['First input to kernel function was not a ' ...
		'single sample. Its dimensions were: %dx%d'], size(sample1) );

	assert( isrow(sample2), ['Second input to kernel function was not a ' ...
		'single sample. Its dimensions were: %dx%d'], size(sample2) );

	% if false the matrix operations will fail
	assert( size(sample1) == size(sample2), 'Samples were not same size.' );

	% set default value for c
	% use nargin because it's faster in tight loops than exists()
	if( ~isempty(varargin) )
		for pair = reshape(varargin, 2, [])
			opts.(lower(pair{1})) = pair{2};
		end
	end

	% set the function values
	c = opts.('c');
	order = opts.('order');
	slope = opts.('slope');
	
	% the actual kernel element computation
	temp = sample1 * sample2';
	temp = temp * slope;
	temp = temp + c;
	kernel_matrix_element = temp .^ order;


end


