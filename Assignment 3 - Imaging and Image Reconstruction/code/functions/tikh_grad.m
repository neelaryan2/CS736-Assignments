function out = tikh_grad(x, A, b, alpha, gamma)
	out = 2 * A' * (A*x - b) + 2*alpha*x;
end