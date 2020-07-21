function out = log_grad(x, y, alpha, gamma)
	out = 2 * (1 - alpha) * (x - y);    
    for i = -1:1
		for j = -1:1
			if i*j~=0 continue,	end
			curr = x - circshift(x, [i, j]);
            curr = (gamma * curr)./(abs(curr) + gamma);
			out = out + alpha * curr;
		end
    end
end