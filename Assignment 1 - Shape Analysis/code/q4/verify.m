function verify(i)
    close all; clc;
    path = '../../data/brain/mri_image_'; ext='.png'; st='brain';
    im = imread(strcat(path,int2str(i),ext));
    path = strcat('points/', st, '_');
    load(strcat(path,int2str(i),'.mat'), 'out'); 
    out = reshape(out, [], 2);
    x=out(:,1); y=out(:,2);
    imshow(im); hold on;
    x = [x; x(1)]; y=[y; y(1)];
    plot(x,y,'-ro',...
    'LineWidth',1.5,...
    'MarkerEdgeColor','g',...
    'MarkerFaceColor','g',...
    'MarkerSize',7);
    hold off;
 end