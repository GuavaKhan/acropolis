% Returns value of linear kernel equation run on two samples
% sample1 and sample2 are two vectors from the input space e.g. a single sample
% with any subset of the feature space
% c is an optional numeric constant i.e. y-intercept
% sample usage: LinearKernel( [1 1 1], [1 2 1], 3 ) returns 7

function kernel_matrix_element = LinearKernel(sample1, sample2, c)

	% two assertions that make sure inputs were one samples features
	assert(isrow(sample1), ['First input to LinearKernel() was not a ' ...
		'single sample. Its dimensions were: %dx%d'], size(sample1) );

	assert(isrow(sample2), ['Second input to LinearKernel() was not a ' ...
		'single sample. Its dimensions were: %dx%d'], size(sample2) );

	% set default value for c
	% use nargin because it's faster in tight loops than exists()
	if( (2 == nargin) || isempty(c) )
		c = 0;
	end

	% return the kernel matrix value
	kernel_matrix_element = (sample1 * sample2') + c;

end


