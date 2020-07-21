function out = rrmse(noiseless, noisy)
	num = sumsqr(noiseless - noisy);
	out = sqrt(num / sumsqr(noiseless));
end