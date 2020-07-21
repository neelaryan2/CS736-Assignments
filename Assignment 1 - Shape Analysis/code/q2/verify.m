function verify(i)
    close all; clc; st='hand';
    path = strcat('points/', st, '_');
    load(strcat(path,int2str(i),'.mat'), 'out'); 
    out = reshape(out, [], 2);
    x=out(:,1); y=out(:,2);
    hold on;
    x = [x; x(1)]; y=[y; y(1)];
    plot(x,y,'-ro',...
    'LineWidth',1.5,...
    'MarkerEdgeColor','g',...
    'MarkerFaceColor','g',...
    'MarkerSize',7);
    hold off;
 end