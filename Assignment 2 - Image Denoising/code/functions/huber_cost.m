function out = huber_cost(x, y, alpha, gamma)
	out = (1 - alpha) * sumsqr(x - y);
	for i = -1:1
		for j = -1:1
			if i*j~=0 continue,	end
			curr = x - circshift(x, [i, j]);
			curr = 0.5 * ((curr <= gamma).*(curr.*curr)) + gamma * ((curr > gamma).*(curr - 0.5 * gamma));
			out = out + alpha * sum(sum(curr));
		end
	end
end