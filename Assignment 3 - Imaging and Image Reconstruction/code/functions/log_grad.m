function out = log_grad(x, A, b, alpha, gamma)
	out = 2 * A' * (A*x - b);
    n = sqrt(size(x,1));
    x_img = reshape(x,[n,n]);
    for i = -1:1
		for j = -1:1
			if i*j~=0 continue,	end
			curr = x_img - circshift(x_img, [i, j]);
            curr = (gamma * curr)./(abs(curr) + gamma);
			out = out + alpha * curr(:);
		end
    end
end