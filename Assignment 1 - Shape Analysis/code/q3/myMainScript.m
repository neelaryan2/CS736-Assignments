clear; clc; close all; tic;
load('points.mat', 'shapes');
[n,N] = size(shapes);

figure(1); hold on;
title('All Pointsets');
for i = 1:n
    show(shapes(i, :), 1);
end
hold off;

mymean = meanShape(shapes);
figure(2); hold on;
title('All Pointsets aligned with Mean');
for i = 1:n
    shapes(i, :) = align(mymean, shapes(i, :));
    show(shapes(i, :), 1);
end
show(mymean, 4); hold off;

temp = shapes - mymean;
cov = (temp'*temp)/n;
assert(size(cov,1) == N);
[v, d] = eigs(cov, N);
d = abs(diag(d)); v = v';
figure(3);
plot(1:N, d');
title('Variances (Eigenvalues)');
d = real(sqrt(d));

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
    show(temp, 1); show(closest, 1);
    title(strcat('Closest shape for $b_{1} = ', int2str(t), '\sqrt{\lambda_{1}}$'), 'interpreter', 'latex');
    hold off;
end

figure(8); hold on;
for i = 1:n
    temp = reshape(shapes(i, :), [], 2);
    scatter(temp(:, 1), temp(:, 2), '.b');
end
show(mymean, 4);
title('Scatter Plot of Pointsets with mean');
hold off; toc;


