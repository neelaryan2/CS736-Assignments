function hand
    load('../../data/hand/data.mat', 'shapes');
    shapes = permute(shapes, [3 2 1]);
    [n, N, ~] = size(shapes);
    shapes = reshape(shapes, n, 2 * N);
    for i = 1:n
        out = shapes(i, :)';
        name = 'points/hand_';
        name = strcat(name, int2str(i), '.mat');
        save(name, 'out');
    end
end
