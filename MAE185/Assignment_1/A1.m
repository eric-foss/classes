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

u_bar = squeeze(mean(u(150:end, :, :)));
v_bar = squeeze(mean(v(150:end, :, :)));
startX = [0.5];
startY = [0.5];

verts = stream2(x, y, u_bar, v_bar, startX, startY);

lineObj = streamline(verts);








