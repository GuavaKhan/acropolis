% Returns value of linear kernel equation run on two samples
% sample1 and sample2 are two vectors from the input space e.g. a single sample
% with any subset of the feature space
% varargin contains the optional inputs pass inputs in as name/value pairs
% e.g. ('c', 3)
% c is an optional numeric constant i.e. y-intercept

% sample usage: LinearKernel( [1 1 1], [1 2 1], 'c', 3 ) returns 7

function kernel_matrix_element = LinearKernel( sample1, sample2, varargin )

	% set defaults for function
	opts = struct( 'c', 0 );

	all_opt_names = fieldnames(opts);

	assert( ~mod(length(varargin), 2), ['Parameters are passed as' ...
		'name/value pairs. Number of parameters must be divisible by two' ...
		'%d parameters were passed in.'], length(varargin) );

	% two assertions that make sure inputs were one samples features
	assert(isrow(sample1), ['First input to LinearKernel() was not a ' ...
		'single sample. Its dimensions were: %dx%d'], size(sample1) );

	assert(isrow(sample2), ['Second input to LinearKernel() was not a ' ...
		'single sample. Its dimensions were: %dx%d'], size(sample2) );

	% set default value for c
	% use nargin because it's faster in tight loops than exists()
	if( ~isempty(varargin) )
		for pair = reshape(varargin, 2, [])
			opts.(lower(pair{1})) = pair{2};
		end
	end

	c = opts.('c');

	% return the kernel matrix value
	kernel_matrix_element = (sample1 * sample2') + c;

end


