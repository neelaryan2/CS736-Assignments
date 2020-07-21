%% Prepping the script
clc; clear; close all;
addpath('../functions/');
iptsetpref('ImshowAxesVisible','on');
iptsetpref('ImshowInitialMagnification','fit');
addpath('../functions/');
img_chest = double(imread('../../data/ChestCT.png'))/255;
img_shepp = double(imread('../../data/SheppLogan256.png'))/255;

%% SheppLogan256 RRMSE plot

% Loop over values of theta to get minimum rrmse
rrmse_shepp = zeros(181,1);
min_error=10;
for i = 0:180
    theta = i:i+150;
    [rad, xp] = radon(img_shepp, theta);
    img_shepp_recon = iradon(rad,theta,'linear','Ram-Lak',1,256);
    error = sqrt(sum((img_shepp_recon(:)-img_shepp(:)).^2)/sum(img_shepp(:).^2));
    rrmse_shepp(i+1) = error;
    if error <= min_error
        best_shepp = img_shepp_recon;
    end
end

% Plot rrmse vs theta
figure;
plot(rrmse_shepp);
xlabel('\theta');
ylabel('RRMSE');
title("RRMSE plot (b/w ground truth and reconstructed image)for SheppLogan256");

%% ChestCT RRMSE plot

% Loop over values of theta to get minimum rrmse
rrmse_chest = zeros(181,1);
min_error = 10;
for i = 0:180
    theta = i:i+150;
    [rad, xp] = radon(img_chest, theta);
    img_chest_recon = iradon(rad,theta,'linear','Ram-Lak',1,512);
    error = sqrt(sum((img_chest_recon(:)-img_chest(:)).^2)/sum(img_chest(:).^2));
    rrmse_chest(i+1) = error;
    if error <= min_error
        best_chest = img_chest_recon;
    end
end

% Plot rrmse vs theta
figure;
plot(rrmse_chest);
xlabel('\theta');
ylabel('RRMSE');
title("RRMSE plot (b/w ground truth and reconstructed image)for ChestCT");


%% SheppLogan256 Reconstructed image

[min_rrmse_shepp,shepp_theta] = min(rrmse_shepp);

fprintf("Best set of theta values for SheppLogan256\n");
fprintf("[%d %d ... %d]\n",shepp_theta,shepp_theta+1,shepp_theta+150);
fprintf("RRMSE at this theta = %.4f\n",min_rrmse_shepp);

figure;
imshow(img_shepp);
title('Original SheppLogan256 Image');

figure;
imshow(best_shepp);
title({'Reconstructed Image for SheppLogan256'; ['Occuring at \theta = ',num2str(shepp_theta),'\circ']});


%% ChestCT Reconstructed image

[min_rrmse_chest,chest_theta] = min(rrmse_chest);

fprintf("Best set of theta values for ChestCT\n");
fprintf("[%d %d ... %d]\n",chest_theta,chest_theta+1,chest_theta+150);
fprintf("RRMSE at this theta = %.4f\n",min_rrmse_chest);

figure;
imshow(img_chest);
title('Original ChestCT Image');

figure;
imshow(best_chest);
title({'Reconstructed Image for ChestCT'; ['Occuring at \theta = ',num2str(chest_theta),'\circ']});
