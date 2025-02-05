%Assignment 1.1; 
% Eric Foss; 
% A17068006;

%% 1.1
clear all; close all; clc; %reset workspace
load("cylinder_Re100.mat"); %load data
%EDITS:
% Removed preliminary figure setup as it resulted in slower animation
% ^ Allowed to plot cylinder for every image in animation


[nt, nx, ny] = size(u); %define data lengths


figure(1);

%Animation Loop
for i = 1:nt
    
    %U plot
    subplot(2, 1, 1);
    pcolor(x, y, squeeze(u(i, :, :)));
    shading interp;
    axis equal tight;
    rectangle('Position',[-0.5 -0.5 1 1],'Curvature',[1 1],'LineStyle','none','FaceColor',[1 1 1]); hold off;
    title('U'); xlabel('x'); ylabel('y');
    drawnow;
    
    %V plot
    subplot(2, 1, 2);
    pcolor(x, y, squeeze(v(i, :, :)));
    shading interp;
    axis equal tight;
    rectangle('Position',[-0.5 -0.5 1 1],'Curvature',[1 1],'LineStyle','none','FaceColor',[1 1 1]); hold off;
    title('V'); xlabel('x'); ylabel('y');
    drawnow;
end

%% 1.2
clear all; close all; clc; %reset workspace
load("cylinder_Re100.mat"); %load data

%Find mean past transient
u_bar = mean(u(150:end, :, :)); %u mean
v_bar = mean(v(150:end, :, :)); %v mean

%Plot means
figure(2);

subplot(2, 1, 1); %u plot
title('u bar');
xlabel('x'); ylabel('y');
pcolor(x, y, squeeze(u_bar));
rectangle('Position',[-0.5 -0.5 1 1],'Curvature',[1 1],'LineStyle','none','FaceColor',[1 1 1]);
shading interp;
axis equal tight;

subplot(2, 1, 2); %v plot
title('v bar');
xlabel('x'); ylabel('y');
pcolor(x, y, squeeze(v_bar));
rectangle('Position',[-0.5 -0.5 1 1],'Curvature',[1 1],'LineStyle','none','FaceColor',[1 1 1]);
shading interp;
axis equal tight;

%% 1.3
clear all; close all; clc; %reset workspace
load("cylinder_Re100.mat"); %load data

u_bar = squeeze(mean(u(150:end, :, :))); %u mean
v_bar = squeeze(mean(v(150:end, :, :))); %v mean

%Plot u flow field
figure(3); hold on;
title('Horizontal Velocity w/ Streamlines');
xlabel('x');
ylabel('y');
pcolor(x, y, squeeze(u_bar)); %plot u flow field
rectangle('Position',[-0.5 -0.5 1 1],'Curvature',[1 1],'LineStyle','none','FaceColor',[1 1 1]);
shading interp;
axis equal tight;

%Plot streamlines
[startX, startY] = meshgrid(-5, -5:0.5:5); %initial xy coords for streamlines
verts = stream2(x', y', u_bar', v_bar', startX, startY);
lineObj = streamline(verts); %plot streamlines

%% 1.4
clear; close all; clc; %reset workspace
load("cylinder_Re100.mat"); %load data

u_bar = squeeze(mean(u(150:end, :, :)));
v_bar = squeeze(mean(v(150:end, :, :)));

[nt, nx, ny] = size(u); %define data lengths


figure(4);
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

%% 1.5
clear all; close all; clc;
load('cylinder_Re100.mat');

u_bar = squeeze(mean(u(150:end, :, :))); %u average
v_bar = squeeze(mean(v(150:end, :, :))); %v average

[nt, nx, ny] = size(u); %define data lengths

for i = 1:nt
    
    uprime(i, :, :) = squeeze(u(i, :, :)) - u_bar;
    vprime(i, :, :) = squeeze(v(i, :, :)) - v_bar;

end

k = sqrt(squeeze(mean(uprime(150:end, :, :).^2 + vprime(150:end, :, :).^2)));



figure(5); hold on;
title('Turbulence Kinetic Energy');
xlabel('x'); ylabel('y');
pcolor(x, y, k);
rectangle('Position',[-0.5 -0.5 1 1],'Curvature',[1 1],'LineStyle','none','FaceColor',[1 1 1]); hold off;
shading interp;
axis equal tight;
colorbar;

