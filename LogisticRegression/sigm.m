%Author: Parker Temple for http://github.com/kwyjibo1230/acropolis
function [sigm] = g(x,w)
	z = -(x*w);
	sigm = power((exp(z) + 1), -1);
endfunction
