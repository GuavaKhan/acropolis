%Input: m, a matrix
%Output: shuffled, matrix m with its rows shuffled
function [shuffled] = shuffle(m)
	p = randperm(rows(m));
	shuffled = m(p,:);
endfunction
