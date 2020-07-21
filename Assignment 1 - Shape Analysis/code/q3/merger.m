function merger()
    n = 75; N = 32; st = 'leaf';
    shapes = zeros(n, 2 * N);
    for i = 1:n
        path = strcat('points/', st, '_');
        load(strcat(path, int2str(i), '.mat'), 'out');
        shapes(i, :) = out;
    end
    save('points.mat', 'shapes');
end