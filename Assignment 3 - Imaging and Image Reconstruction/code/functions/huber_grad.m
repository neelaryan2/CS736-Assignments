function out = huber_grad(x, A, b, alpha, gamma)
	out = 2 * A' * (A*x - b);
    n = sqrt(size(x,1));
    x_img = reshape(x,[n,n]);
	for i = -1:1
		for j = -1:1
			if i*j~=0 continue,	end
			curr = x_img - circshift(x_img, [i, j]);
			curr = (abs(curr) <= gamma).*curr + gamma*((abs(curr) > gamma).*sign(curr));
			out = out + alpha * curr(:);
		end
	end
end