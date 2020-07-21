function merger()
    n = 150; N = 16; st = 'ellipse';
    shapes = zeros(n, 2 * N);
    for i = 1:n
        path = strcat('points/', st, '_');
        load(strcat(path, int2str(i), '.mat'), 'out');
        shapes(i, :) = out;
    end
    save('points.mat', 'shapes');
end