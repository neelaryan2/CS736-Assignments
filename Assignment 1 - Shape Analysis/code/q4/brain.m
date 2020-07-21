function brain(i)
    close all; N = 32;
    path = '../../data/brain/mri_image_';
    im = imread(strcat(path, int2str(i), '.png'));
    imshow(im); [x, y] = getpts;
    out = reshape([x y], [], 1);
    name = 'pointsbrain_';
    name = strcat(name, int2str(i), '.mat');
    save(name, 'out'); close all;
    imshow(im); hold on;
    x = [x; x(1)]; y = [y; y(1)];
    plot(x, y, '-ro', ...
      'LineWidth', 1.5, ...
      'MarkerEdgeColor', 'g', ...
      'MarkerFaceColor', 'g', ...
      'MarkerSize', 7);
    hold off; disp(size(out, 1));
end
