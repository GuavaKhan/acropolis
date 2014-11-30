% Returns

function kernel_matrix_element = PolynomialKernel(sample1, sample2, c, d, slope)

	% two assertions that make sure inputs were one samples features
	assert(isrow(sample1), ['First input to LinearKernel() was not a ' ...
		'single sample. Its dimensions were: %dx%d'], size(sample1) );

	assert(isrow(sample2), ['Second input to LinearKernel() was not a ' ...
		'single sample. Its dimensions were: %dx%d'], size(sample2) );

	% set default values
	% use nargin because it's faster in tight loops than exists()
	% nargin is also a good choice because these functions have no clever
	% parameter matching
	if( (2 == nargin) || ( isempty(c) && isempty(d) && isempty(slope) ) )
		c = 0;
		d = 1;
		slope = 1;
	
	elseif ( (3 == nargin) || ( isempty(d) && isempty(slope) ) )
		d = 1;
		slope = 1;
	
	elseif ( (4 == nargin) || isempty(slope) )
		slope = 1;
	end
	
	temp = sample1 * sample2';
	temp = temp * slope;
	temp = temp + c;
	kernel_matrix_element = temp .^ d;


end


