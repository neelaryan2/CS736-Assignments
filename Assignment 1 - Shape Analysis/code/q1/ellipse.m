function ellipse(i)
    path = '../../data/ellipse/'; N = 16;
    im = imread(strcat(path, int2str(i), '.jpg'));
    im = bwconvhull(imbinarize(rgb2gray(im)));
    t = linspace(0, 2 * pi, N);
    s = regionprops(im, {...
      'Centroid', ...
      'MajorAxisLength', ...
      'MinorAxisLength', ...
      'Orientation'});
    a = s(1).MajorAxisLength / 2;
    b = s(1).MinorAxisLength / 2;
    Xc = s(1).Centroid(1); Yc = s(1).Centroid(2);
    phi = deg2rad(- s(1).Orientation);
    x = Xc + a * cos(t) * cos(phi) - b * sin(t) * sin(phi);
    y = Yc + a * cos(t) * sin(phi) + b * sin(t) * cos(phi);
    out = reshape([x' y'], [], 1);
    path = 'points/ellipse_';
    path = strcat(path, int2str(i), '.mat');
    save(path, 'out'); close all;
    imshow(im); hold on;
    x = [x x(1)]'; y=[y y(1)]';
    plot(x, y, '-ro', ...
      'LineWidth', 1.5, ...
      'MarkerEdgeColor', 'g', ...
      'MarkerFaceColor', 'g', ...
      'MarkerSize', 7);
    hold off; disp(size(out, 1));
end
