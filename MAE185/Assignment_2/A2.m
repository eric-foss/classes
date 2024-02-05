%% MAE185 Assignment 2
% Eric Foss
% A17068006
clear; close all; clc;
%% Problem 3

load('cylinder_Re100.mat');
addpath('Functions');

[nt, nx, ny] = size(u);
dx = (x(end)-x(1))/length(x);
dy = (y(end)-y(1))/width(y);


%Animation Loop
figure(1);
for i = 1:nt

    omega_z = ddx_central(squeeze(v(i, :, :)), dx) - ddy_central(squeeze(u(i, :, :)), dy);
    pcolor(x, y, squeeze(omega_z));
    shading interp;
    axis equal tight;
    rectangle('Position',[-0.5 -0.5 1 1],'Curvature',[1 1],'LineStyle','none','FaceColor',[1 1 1]); hold off;
    title('Vorticity'); xlabel('x'); ylabel('y');
    %clim([-10 10]); colorbar;
    drawnow;

end

