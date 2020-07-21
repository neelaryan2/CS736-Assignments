clear; clc; close all; tic;
load('points.mat', 'shapes');
[n,N] = size(shapes);

figure(1); hold on; q='q1/';
titl='All Pointsets';
title(titl);
for i = 1:n
    show(shapes(i, :), 1);
end
hold off;
saveas(gcf,'filename.png');
image = imread('filename.png');
save(strcat(q,titl,'.mat'),'image');

mymean = meanShape(shapes);
titl='All Pointsets aligned with Mean';
figure(2); hold on;
title(titl);
for i = 1:n
    shapes(i, :) = align(mymean, shapes(i, :));
    show(shapes(i, :), 1);
end
show(mymean, 4); hold off;
saveas(gcf,'filename.png');
image = imread('filename.png');
save(strcat(q,titl,'.mat'),'image');

temp = shapes - mymean;
cov = (temp'*temp)/n;
assert(size(cov,1) == N);
[v, d] = eigs(cov, N);
d = abs(diag(d)); v = v';
figure(3);
plot(1:N, d');
titl='Variances (Eigenvalues)';
title(titl);
d = real(sqrt(d));
saveas(gcf,'filename.png');
image = imread('filename.png');
save(strcat(q,titl,'.mat'),'image');

num = 3; factor = 3;
figure(4); hold on;
for i = 1:num
    subplot(3, 3, 3*i-2);
    temp = mymean - factor * d(i) * v(i, :);
    show(temp, 1);
 
    subplot(3, 3, 3*i-1);
    temp = mymean;
    show(temp, 1);
    title(strcat('Mode of Variation : ', int2str(i)));
 
    subplot(3, 3, 3*i);
    temp = mymean + factor * d(i) * v(i, :);
    show(temp, 1);
    hold off;
end
titl='Modes of Variation';
saveas(gcf,'filename.png');
image = imread('filename.png');
save(strcat(q,titl,'.mat'),'image');

for i = 1 : 3
    t = (i - 2) * factor;
    temp = mymean + t * d(1) * v(1, :);
    dist = Inf; closest = shapes(1, :);
    for j = 1:n
        im = align(temp, shapes(j, :));
        new = norm(temp - im);
        if new < dist
            closest = im;
            dist = new;
        end
    end
    figure(i + 4); hold on;
    titl=strcat('ClosestShape_', int2str(i));
    show(temp, 1); show(closest, 1);
    title(strcat('Closest shape for $b_{1} = ', int2str(t), '\sqrt{\lambda_{1}}$'), 'interpreter', 'latex');
    hold off;
    saveas(gcf,'filename.png');
    image = imread('filename.png');
    save(strcat(q,titl,'.mat'),'image');
end

figure(8); hold on;
for i = 1:n
    temp = reshape(shapes(i, :), [], 2);
    scatter(temp(:, 1), temp(:, 2), '.b');
end
show(mymean, 4);
titl='Scatter Plot of Pointsets with Mean';
title(titl);
hold off;
saveas(gcf,'filename.png');
image = imread('filename.png');
save(strcat(q,titl,'.mat'),'image');
delete('filename.png'); toc;
