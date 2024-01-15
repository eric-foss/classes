%% 1.4
clear all; close all; clc; %reset workspace
load("cylinder_Re100.mat"); %load data

u_bar = squeeze(mean(u(150:end, :, :)));
v_bar = squeeze(mean(v(150:end, :, :)));

[nt, nx, ny] = size(u); %define data lengths



%Animation Loop
for i = 1:nt

    %U plot
    subplot(2, 1, 1);
    uprime = squeeze(u(i, :, :)) - u_bar;
    pcolor(x, y, uprime);
    shading interp;
    axis equal tight;
    rectangle('Position',[-0.5 -0.5 1 1],'Curvature',[1 1],'LineStyle','none','FaceColor',[1 1 1]); hold off;
    title('U prime'); xlabel('x'); ylabel('y');
%     clim([-2 2]); 
%     colorbar; %%to slow
    drawnow;

    %V plot
    subplot(2, 1, 2);
    vprime = squeeze(v(i, :, :)) - v_bar;
    pcolor(x, y, vprime);
    shading interp;
    axis equal tight;
    rectangle('Position',[-0.5 -0.5 1 1],'Curvature',[1 1],'LineStyle','none','FaceColor',[1 1 1]); hold off;
    title('V prime'); xlabel('x'); ylabel('y');
%     clim([-2 2]);
%     colorbar; %%to slow
    drawnow;

end