function out = log_cost(x, y, alpha, gamma)
	out = (1 - alpha) * sumsqr(x - y);
    for i = -1:1
		for j = -1:1
			if i*j~=0 continue,	end
			curr = (x - circshift(x, [i, j]))/gamma;
            curr = gamma * (curr - log(1 + curr));
			out = out + alpha * gamma * sum(sum(curr));
		end
    end
end