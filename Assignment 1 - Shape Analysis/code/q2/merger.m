function merger()
	n = 40; N = 56; st = 'hand';
    shapes = zeros(n, 2 * N);
    for i = 1:n
        path = strcat('points/', st, '_');
        load(strcat(path, int2str(i), '.mat'), 'out');
        shapes(i, :) = out;
    end
    save('points.mat', 'shapes');
end