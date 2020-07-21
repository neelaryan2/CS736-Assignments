%% Prepping the script
clc; clear; close all;
addpath('../functions/');
actual = abs(double(imread('../../data/mri_image_noiseless.png'))/255);

%% Reading the data (LOW noise)
fprintf('Analysis for LOW noise level image\n');
img = abs(double(imread('../../data/mri_image_noise_level_low.png'))/255);

%% MRF prior: Quadratic function (LOW noise)
fprintf('MRF prior: Quadratic function (LOW noise)\n');
alpha_opt = 0.085; gamma_opt = 1; eps = 1e-8; epochs = 1e9;

alpha = alpha_opt; gamma = gamma_opt;
[noisy, costs] = descent(img, eps, alpha, gamma, epochs, @quad_grad, @quad_cost);
quad_denoised = abs(noisy);

% RRMSE
error = rrmse(actual, img);
fprintf('RRMSE(noiseless, noisy) : %f\n',error);

% Optimal Parameters Testing
fprintf('alpha(a) = %.3f\n', alpha_opt);
error = rrmse(actual, noisy);
fprintf('RRMSE(a) = %f\n', error);

alpha = 0.8 * alpha_opt; gamma = gamma_opt;
[noisy, ~] = descent(img, eps, alpha, gamma, epochs, @quad_grad, @quad_cost);
error = rrmse(actual, noisy);
fprintf('RRMSE(0.8a) = %f\n', error);

alpha = 1.2 * alpha_opt; gamma = gamma_opt;
[noisy, ~] = descent(img, eps, alpha, gamma, epochs, @quad_grad, @quad_cost);
error = rrmse(actual, noisy);
fprintf('RRMSE(1.2a) = %f\n', error);

% Objective function plot
figure;
plot(costs);
xlabel('Number of iterations')
ylabel('Value of Objective (Cost) function');
title('MRF prior: Quadratic function');

%% MRF prior: Discontinuity-adaptive Huber function (LOW noise)
fprintf('MRF prior: Discontinuity-adaptive Huber function (LOW noise)\n');
alpha_opt = 0.373248; gamma_opt = 0.026214; eps = 1e-8; epochs = 1e9;

alpha = alpha_opt; gamma = gamma_opt;
[noisy, costs] = descent(img, eps, alpha, gamma, epochs, @huber_grad, @huber_cost);
huber_denoised = abs(noisy);

% RRMSE
error = rrmse(actual, img);
fprintf('RRMSE(noiseless, noisy) : %f\n',error);

% Optimal Parameters
fprintf('alpha(a) = %f, gamma(b) = %f\n', alpha_opt, gamma_opt);
error = rrmse(actual, noisy);
fprintf('RRMSE(a, b) = %f\n', error);

alpha = 0.8 * alpha_opt; gamma = gamma_opt;
[noisy, ~] = descent(img, eps, alpha, gamma, epochs, @huber_grad, @huber_cost);
error = rrmse(actual, noisy);
fprintf('RRMSE(0.8a, b) = %f\n', error);

alpha = alpha_opt; gamma = 0.8 * gamma_opt;
[noisy, ~] = descent(img, eps, alpha, gamma, epochs, @huber_grad, @huber_cost);
error = rrmse(actual, noisy);
fprintf('RRMSE(a, 0.8b) = %f\n', error);

alpha = 1.2 * alpha_opt; gamma = gamma_opt;
[noisy, ~] = descent(img, eps, alpha, gamma, epochs, @huber_grad, @huber_cost);
error = rrmse(actual, noisy);
fprintf('RRMSE(1.2a, b) = %f\n', error);

alpha = alpha_opt; gamma = 1.2 * gamma_opt;
[noisy, ~] = descent(img, eps, alpha, gamma, epochs, @huber_grad, @huber_cost);
error = rrmse(actual, noisy);
fprintf('RRMSE(a, 1.2b) = %f\n', error);

% Objective function plot
figure;
plot(costs);
xlabel('Number of iterations')
ylabel('Value of Objective (Cost) function');
title('MRF prior: Huber function');

%% MRF prior: Discontinuity-adaptive Log function (LOW noise)
fprintf('MRF prior: Discontinuity-adaptive Log function (LOW noise)\n');
alpha_opt = 0.210; gamma_opt = 0.502; eps = 1e-8; epochs = 1e9;

alpha = alpha_opt; gamma = gamma_opt;
[noisy, costs] = descent(img, eps, alpha, gamma, epochs, @log_grad, @log_cost);
log_denoised = abs(noisy);

% RRMSE
error = rrmse(actual, img);
fprintf('RRMSE(noiseless, noisy) : %f\n',error);

% Optimal Parameters
fprintf('alpha(a) = %f, gamma(b) = %f\n', alpha_opt, gamma_opt);
error = rrmse(actual, noisy);
fprintf('RRMSE(a, b) = %f\n', error);

alpha = 0.8 * alpha_opt; gamma = gamma_opt;
[noisy, ~] = descent(img, eps, alpha, gamma, epochs, @log_grad, @log_cost);
error = rrmse(actual, noisy);
fprintf('RRMSE(0.8a, b) = %f\n', error);

alpha = alpha_opt; gamma = 0.8 * gamma_opt;
[noisy, ~] = descent(img, eps, alpha, gamma, epochs, @log_grad, @log_cost);
error = rrmse(actual, noisy);
fprintf('RRMSE(a, 0.8b) = %f\n', error);

alpha = 1.2 * alpha_opt; gamma = gamma_opt;
[noisy, ~] = descent(img, eps, alpha, gamma, epochs, @log_grad, @log_cost);
error = rrmse(actual, noisy);
fprintf('RRMSE(1.2a, b) = %f\n', error);

alpha = alpha_opt; gamma = 1.2 * gamma_opt;
[noisy, ~] = descent(img, eps, alpha, gamma, epochs, @log_grad, @log_cost);
error = rrmse(actual, noisy);
fprintf('RRMSE(a, 1.2b) = %f\n', error);

% Objective function plot
figure;
plot(costs);
xlabel('Number of iterations')
ylabel('Value of Objective (Cost) function');
title('MRF prior: Log function');

%% Colormap plot of all three MRFs (LOW noise)
mx = max([max(img), max(actual), max(log_denoised), max(huber_denoised), max(quad_denoised)]);
mn = min([min(img), min(actual), min(log_denoised), min(huber_denoised), min(quad_denoised)]);
magnification = 200;

figure;
imshow(actual,[mn, mx], 'InitialMagnification', magnification);
title('Noiseless image');
colorbar

figure;
imshow(img,[mn, mx], 'InitialMagnification', magnification);
title('Noisy image (LOW noise)');
colorbar

figure;
imshow(quad_denoised,[mn, mx], 'InitialMagnification', magnification);
title('Denoised image (Quadratic prior)');
colorbar

figure;
imshow(huber_denoised,[mn, mx], 'InitialMagnification', magnification);
title('Denoised image (Huber prior)');
colorbar

figure;
imshow(log_denoised,[mn, mx], 'InitialMagnification', magnification);
title('Denoised image (Log prior)');
colorbar

%% Reading the data (MEDIUM noise)
fprintf('Analysis for MEDIUM noise level image\n');
img = abs(double(imread('../../data/mri_image_noise_level_medium.png'))/255);

%% MRF prior: Quadratic function (MEDIUM noise)
fprintf('MRF prior: Quadratic function (MEDIUM noise)\n');
alpha_opt = 0.18; gamma_opt = 1; eps = 1e-8; epochs = 1e9;

alpha = alpha_opt; gamma = gamma_opt;
[noisy, costs] = descent(img, eps, alpha, gamma, epochs, @quad_grad, @quad_cost);
quad_denoised = abs(noisy);

% RRMSE
error = rrmse(actual, img);
fprintf('RRMSE(noiseless, noisy) : %f\n',error);

% Optimal Parameters Testing
fprintf('alpha(a) = %f\n', alpha_opt);
error = rrmse(actual, noisy);
fprintf('RRMSE(a) = %f\n', error);

alpha = 0.8 * alpha_opt; gamma = gamma_opt;
[noisy, ~] = descent(img, eps, alpha, gamma, epochs, @quad_grad, @quad_cost);
error = rrmse(actual, noisy);
fprintf('RRMSE(0.8a) = %f\n', error);

alpha = 1.2 * alpha_opt; gamma = gamma_opt;
[noisy, ~] = descent(img, eps, alpha, gamma, epochs, @quad_grad, @quad_cost);
error = rrmse(actual, noisy);
fprintf('RRMSE(1.2a) = %f\n', error);

% Objective function plot
figure;
plot(costs);
xlabel('Number of iterations')
ylabel('Value of Objective (Cost) function');
title('MRF prior: Quadratic function');

%% MRF prior: Discontinuity-adaptive Huber function (MEDIUM noise)
fprintf('MRF prior: Discontinuity-adaptive Huber function (MEDIUM noise)\n');
alpha_opt = 0.5184; gamma_opt = 0.036; eps = 1e-8; epochs = 1e9;

alpha = alpha_opt; gamma = gamma_opt;
[noisy, costs] = descent(img, eps, alpha, gamma, epochs, @huber_grad, @huber_cost);
huber_denoised = abs(noisy);

% RRMSE
error = rrmse(actual, img);
fprintf('RRMSE(noiseless, noisy) : %f\n',error);

% Optimal Parameters
fprintf('alpha(a) = %f, gamma(b) = %f\n', alpha_opt, gamma_opt);
error = rrmse(actual, noisy);
fprintf('RRMSE(a, b) = %f\n', error);

alpha = 0.8 * alpha_opt; gamma = gamma_opt;
[noisy, ~] = descent(img, eps, alpha, gamma, epochs, @huber_grad, @huber_cost);
error = rrmse(actual, noisy);
fprintf('RRMSE(0.8a, b) = %f\n', error);

alpha = alpha_opt; gamma = 0.8 * gamma_opt;
[noisy, ~] = descent(img, eps, alpha, gamma, epochs, @huber_grad, @huber_cost);
error = rrmse(actual, noisy);
fprintf('RRMSE(a, 0.8b) = %f\n', error);

alpha = 1.2 * alpha_opt; gamma = gamma_opt;
[noisy, ~] = descent(img, eps, alpha, gamma, epochs, @huber_grad, @huber_cost);
error = rrmse(actual, noisy);
fprintf('RRMSE(1.2a, b) = %f\n', error);

alpha = alpha_opt; gamma = 1.2 * gamma_opt;
[noisy, ~] = descent(img, eps, alpha, gamma, epochs, @huber_grad, @huber_cost);
error = rrmse(actual, noisy);
fprintf('RRMSE(a, 1.2b) = %f\n', error);

% Objective function plot
figure;
plot(costs);
xlabel('Number of iterations')
ylabel('Value of Objective (Cost) function');
title('MRF prior: Huber function');

%% MRF prior: Discontinuity-adaptive Log function (MEDIUM noise)
fprintf('MRF prior: Discontinuity-adaptive Log function (MEDIUM noise)\n');
alpha_opt = 0.24; gamma_opt = 0.448; eps = 1e-8; epochs = 1e9;

alpha = alpha_opt; gamma = gamma_opt;
[noisy, costs] = descent(img, eps, alpha, gamma, epochs, @log_grad, @log_cost);
log_denoised = abs(noisy);

% RRMSE
error = rrmse(actual, img);
fprintf('RRMSE(noiseless, noisy) : %f\n',error);

% Optimal Parameters
fprintf('alpha(a) = %f, gamma(b) = %f\n', alpha_opt, gamma_opt);
error = rrmse(actual, noisy);
fprintf('RRMSE(a, b) = %f\n', error);

alpha = 0.8 * alpha_opt; gamma = gamma_opt;
[noisy, ~] = descent(img, eps, alpha, gamma, epochs, @log_grad, @log_cost);
error = rrmse(actual, noisy);
fprintf('RRMSE(0.8a, b) = %f\n', error);

alpha = alpha_opt; gamma = 0.8 * gamma_opt;
[noisy, ~] = descent(img, eps, alpha, gamma, epochs, @log_grad, @log_cost);
error = rrmse(actual, noisy);
fprintf('RRMSE(a, 0.8b) = %f\n', error);

alpha = 1.2 * alpha_opt; gamma = gamma_opt;
[noisy, ~] = descent(img, eps, alpha, gamma, epochs, @log_grad, @log_cost);
error = rrmse(actual, noisy);
fprintf('RRMSE(1.2a, b) = %f\n', error);

alpha = alpha_opt; gamma = 1.2 * gamma_opt;
[noisy, ~] = descent(img, eps, alpha, gamma, epochs, @log_grad, @log_cost);
error = rrmse(actual, noisy);
fprintf('RRMSE(a, 1.2b) = %f\n', error);

% Objective function plot
figure;
plot(costs);
xlabel('Number of iterations')
ylabel('Value of Objective (Cost) function');
title('MRF prior: Log function');

%% Colormap plot of all three MRFs (MEDIUM noise)
mx = max([max(img), max(actual), max(log_denoised), max(huber_denoised), max(quad_denoised)]);
mn = min([min(img), min(actual), min(log_denoised), min(huber_denoised), min(quad_denoised)]);
magnification = 200;

figure;
imshow(actual,[mn, mx], 'InitialMagnification', magnification);
title('Noiseless image');
colorbar

figure;
imshow(img,[mn, mx], 'InitialMagnification', magnification);
title('Noisy image (MEDIUM noise)');
colorbar

figure;
imshow(quad_denoised,[mn, mx], 'InitialMagnification', magnification);
title('Denoised image (Quadratic prior)');
colorbar

figure;
imshow(huber_denoised,[mn, mx], 'InitialMagnification', magnification);
title('Denoised image (Huber prior)');
colorbar

figure;
imshow(log_denoised,[mn, mx], 'InitialMagnification', magnification);
title('Denoised image (Log prior)');
colorbar

%% Reading the data (HIGH noise)
fprintf('Analysis for HIGH noise level image\n');
img = abs(double(imread('../../data/mri_image_noise_level_high.png'))/255);

%% MRF prior: Quadratic function (HIGH noise)
fprintf('MRF prior: Quadratic function (HIGH noise)\n');
alpha_opt = 0.24; gamma_opt = 1; eps = 1e-8; epochs = 1e9;

alpha = alpha_opt; gamma = gamma_opt;
[noisy, costs] = descent(img, eps, alpha, gamma, epochs, @quad_grad, @quad_cost);
quad_denoised = abs(noisy);

% RRMSE
error = rrmse(actual, img);
fprintf('RRMSE(noiseless, noisy) : %f\n',error);

% Optimal Parameters Testing
fprintf('alpha(a) = %f\n', alpha_opt);
error = rrmse(actual, noisy);
fprintf('RRMSE(a) = %f\n', error);

alpha = 0.8 * alpha_opt; gamma = gamma_opt;
[noisy, ~] = descent(img, eps, alpha, gamma, epochs, @quad_grad, @quad_cost);
error = rrmse(actual, noisy);
fprintf('RRMSE(0.8a) = %f\n', error);

alpha = 1.2 * alpha_opt; gamma = gamma_opt;
[noisy, ~] = descent(img, eps, alpha, gamma, epochs, @quad_grad, @quad_cost);
error = rrmse(actual, noisy);
fprintf('RRMSE(1.2a) = %f\n', error);

% Objective function plot
figure;
plot(costs);
xlabel('Number of iterations')
ylabel('Value of Objective (Cost) function');
title('MRF prior: Quadratic function');

%% MRF prior: Discontinuity-adaptive Huber function (HIGH noise)
fprintf('MRF prior: Discontinuity-adaptive Huber function (HIGH noise)\n');
alpha_opt = 0.48; gamma_opt = 0.06; eps = 1e-8; epochs = 1e9;

alpha = alpha_opt; gamma = gamma_opt;
[noisy, costs] = descent(img, eps, alpha, gamma, epochs, @huber_grad, @huber_cost);
huber_denoised = abs(noisy);

% RRMSE
error = rrmse(actual, img);
fprintf('RRMSE(noiseless, noisy) : %f\n',error);

% Optimal Parameters
fprintf('alpha(a) = %f, gamma(b) = %f\n', alpha_opt, gamma_opt);
error = rrmse(actual, noisy);
fprintf('RRMSE(a, b) = %f\n', error);

alpha = 0.8 * alpha_opt; gamma = gamma_opt;
[noisy, ~] = descent(img, eps, alpha, gamma, epochs, @huber_grad, @huber_cost);
error = rrmse(actual, noisy);
fprintf('RRMSE(0.8a, b) = %f\n', error);

alpha = alpha_opt; gamma = 0.8 * gamma_opt;
[noisy, ~] = descent(img, eps, alpha, gamma, epochs, @huber_grad, @huber_cost);
error = rrmse(actual, noisy);
fprintf('RRMSE(a, 0.8b) = %f\n', error);

alpha = 1.2 * alpha_opt; gamma = gamma_opt;
[noisy, ~] = descent(img, eps, alpha, gamma, epochs, @huber_grad, @huber_cost);
error = rrmse(actual, noisy);
fprintf('RRMSE(1.2a, b) = %f\n', error);

alpha = alpha_opt; gamma = 1.2 * gamma_opt;
[noisy, ~] = descent(img, eps, alpha, gamma, epochs, @huber_grad, @huber_cost);
error = rrmse(actual, noisy);
fprintf('RRMSE(a, 1.2b) = %f\n', error);

% Objective function plot
figure;
plot(costs);
xlabel('Number of iterations')
ylabel('Value of Objective (Cost) function');
title('MRF prior: Huber function');

%% MRF prior: Discontinuity-adaptive Log function (HIGH noise)
fprintf('MRF prior: Discontinuity-adaptive Log function (HIGH noise)\n');
alpha_opt = 0.4; gamma_opt = 0.5632; eps = 1e-8; epochs = 1e9;

alpha = alpha_opt; gamma = gamma_opt;
[noisy, costs] = descent(img, eps, alpha, gamma, epochs, @log_grad, @log_cost);
log_denoised = abs(noisy);

% RRMSE
error = rrmse(actual, img);
fprintf('RRMSE(noiseless, noisy) : %f\n',error);

% Optimal Parameters
fprintf('alpha(a) = %f, gamma(b) = %f\n', alpha_opt, gamma_opt);
error = rrmse(actual, noisy);
fprintf('RRMSE(a, b) = %f\n', error);

alpha = 0.8 * alpha_opt; gamma = gamma_opt;
[noisy, ~] = descent(img, eps, alpha, gamma, epochs, @log_grad, @log_cost);
error = rrmse(actual, noisy);
fprintf('RRMSE(0.8a, b) = %f\n', error);

alpha = alpha_opt; gamma = 0.8 * gamma_opt;
[noisy, ~] = descent(img, eps, alpha, gamma, epochs, @log_grad, @log_cost);
error = rrmse(actual, noisy);
fprintf('RRMSE(a, 0.8b) = %f\n', error);

alpha = 1.2 * alpha_opt; gamma = gamma_opt;
[noisy, ~] = descent(img, eps, alpha, gamma, epochs, @log_grad, @log_cost);
error = rrmse(actual, noisy);
fprintf('RRMSE(1.2a, b) = %f\n', error);

alpha = alpha_opt; gamma = 1.2 * gamma_opt;
[noisy, ~] = descent(img, eps, alpha, gamma, epochs, @log_grad, @log_cost);
error = rrmse(actual, noisy);
fprintf('RRMSE(a, 1.2b) = %f\n', error);

% Objective function plot
figure;
plot(costs);
xlabel('Number of iterations')
ylabel('Value of Objective (Cost) function');
title('MRF prior: Log function');

%% Colormap plot of all three MRFs (HIGH noise)
mx = max([max(img), max(actual), max(log_denoised), max(huber_denoised), max(quad_denoised)]);
mn = min([min(img), min(actual), min(log_denoised), min(huber_denoised), min(quad_denoised)]);
magnification = 200;

figure;
imshow(actual,[mn, mx], 'InitialMagnification', magnification);
title('Noiseless image');
colorbar

figure;
imshow(img,[mn, mx], 'InitialMagnification', magnification);
title('Noisy image (HIGH noise)');
colorbar

figure;
imshow(quad_denoised,[mn, mx], 'InitialMagnification', magnification);
title('Denoised image (Quadratic prior)');
colorbar

figure;
imshow(huber_denoised,[mn, mx], 'InitialMagnification', magnification);
title('Denoised image (Huber prior)');
colorbar

figure;
imshow(log_denoised,[mn, mx], 'InitialMagnification', magnification);
title('Denoised image (Log prior)');
colorbar
