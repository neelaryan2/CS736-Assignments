function out = huber_cost(x, A, b, alpha, gamma)
	out = sumsqr(A*x - b);
    n = sqrt(size(x,1));
    x_img = reshape(x,[n,n]);
	for i = -1:1
		for j = -1:1
			if i*j~=0 continue,	end
			curr = x_img - circshift(x_img, [i, j]);
			curr = 0.5 * ((curr <= gamma).*(curr.*curr)) + gamma * ((curr > gamma).*(curr - 0.5 * gamma));
			out = out + alpha * sum(sum(curr));
		end
	end
end