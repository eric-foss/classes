%%MAE185 Assignment 4 Problem 3
% Eric Foss
% A17068006
clear; close all; clc;

load('gotritons_uv.mat');


dx = (xx(end, 1) - xx(1, 1))/length(xx); %x mesh step
dy = (yy(1, end) - yy(1, 1))/width(yy); %y mesh step
d = 0.0005; %diffusion constant 
SF = 1.2; %time step safety factor

t_final = 2; 



t = 0;
count = 0;
while t < t_final
    count = count + 1;
    u(:, 1) = 0; u(:, end) = 0;
    v(:, 1) = 0; v(:, end) = 0;
    
    
    ubar = u - dt*u.*ddx_fwd(u, dx, 'periodic') - dt*v.*ddy_fwd(u, dy, 'periodic') + d*dt(%SECONDORDERFUCTIONS)
    
    dt = dx*dy/(SF*(dy*max(max(u)) + dx*max(max(v))));
    t = t + dt;
    


end %while