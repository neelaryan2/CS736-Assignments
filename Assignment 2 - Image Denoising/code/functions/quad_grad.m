function out = quad_grad(x, y, alpha, gamma)
	out = 2 * (1 - alpha) * (x - y);    
	for i = -1:1
		for j = -1:1
			if i*j~=0 continue,	end
			curr = x - circshift(x, [i, j]);
			out = out + 2 * alpha * curr;
		end
	end
end