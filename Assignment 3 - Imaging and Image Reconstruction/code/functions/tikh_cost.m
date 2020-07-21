function out = tikh_cost(x, A, b, alpha, gamma)
	out = sumsqr(A*x - b) + alpha*sumsqr(x);
end