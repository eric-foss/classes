% MAE 190: CFD, Programming Assignment #1
% OTS, 2020

clear variables
close all
clc

% load data from file
load('cylinder_Re100.mat')

% determine number of snapshots and grid size
[nt,nx,ny]  = size(u);
% NOTE: the x- and y- indices correspond to Matlab's 'ndgrid' format.
% ndgrids can be much nicer to work with, as it sticks with conventional
% indexing. That is, the first index corresponds to x, and the second to y,
% etc. This is different from the'meshgrid' format. It can get a bit confusing
% between the two, so just be sure to keep track of what kind of grid
% is being used.

%% 1.1: Basic flow visualization 
figure
for ti = 1:nt
    % plot u
    subplot(2,1,1)
    pcolor(x,y,squeeze(u(ti,:,:)))
    shading interp, axis equal tight
    caxis([-0.5 2])
    title(['u (' num2str(ti) '/' num2str(nt) ')']); xlabel('x'); ylabel('y')
    rectangle('Position',[-0.5 -0.5 1 1],'Curvature',[1 1],'LineStyle','none','FaceColor',[1 1 1]); hold off
    %colorbar
    
    % plot v
    subplot(2,1,2)
    pcolor(x,y,squeeze(v(ti,:,:)))
    shading interp, axis equal tight 
    caxis([-1 1])
    rectangle('Position',[-0.5 -0.5 1 1],'Curvature',[1 1],'LineStyle','none','FaceColor',[1 1 1]); hold off
    title(['v (' num2str(ti) '/' num2str(nt) ')']); xlabel('x'); ylabel('y')
    %colorbar
    drawnow
end

%% 1.2: Mean flow (time average)
u_mean  = squeeze(mean(u(150:end,:,:),1)); % discard the intitial transient
v_mean  = squeeze(mean(v(150:end,:,:),1));

figure
% plot u
subplot(2,1,1)
pcolor(x,y,u_mean)
shading interp, axis equal tight
title('mean of u'); xlabel('x'); ylabel('y')
rectangle('Position',[-0.5 -0.5 1 1],'Curvature',[1 1],'LineStyle','none','FaceColor',[1 1 1]); hold off
colorbar

% plot v
subplot(2,1,2)
pcolor(x,y,v_mean)
shading interp, axis equal tight
title('mean of v'); xlabel('x'); ylabel('y')
rectangle('Position',[-0.5 -0.5 1 1],'Curvature',[1 1],'LineStyle','none','FaceColor',[1 1 1]); hold off
colorbar