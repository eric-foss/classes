%%MAE185 Assignment 4 Problem 1
% Eric Foss
% A17068006'
clear; close all; clc;

load('supersonicJetLES_xyPlane.mat');

cp = 1005; %specific heat for constant pressure [J/kg K]
cv = 718; %specific heat for constant volume [J/kg K]
R = cp - cv; %gas constant for air [J/kg K]

U = prim2conv(rho, u, v, T, cv);
[rho, u, v, T, P, e, Et] = cons2prim(U, R, cv);
mu = sunderland(T);

%PLOTS
figure(1);
subplot(4, 2, 1);
pcolor(xx, yy, rho);
shading interp;
axis equal tight;
title('Density Field');
xlabel('X [m]'); ylabel('Y [m]');
cb = colorbar; ylabel(cb, '\rho [kg/m^3]');

subplot(4, 2, 2);
pcolor(xx, yy, squeeze(U(2, :, :)));
shading interp;
axis equal tight;
title('Mass Flux in X Field');
xlabel('X [m]'); ylabel('Y [m]');
cb = colorbar; ylabel(cb, '\rhou [kg/s m^2]');

subplot(4, 2, 3);
pcolor(xx, yy, squeeze(U(3, :, :)));
shading interp;
axis equal tight;
title('Mass Flux in Y Field');
xlabel('X [m]'); ylabel('Y [m]');
cb = colorbar; ylabel(cb, '\rho [kg/m^3]');

subplot(4, 2, 4);
pcolor(xx, yy, T);
shading interp;
axis equal tight;
title('Temperature Field');
xlabel('X [m]'); ylabel('Y [m]');
cb = colorbar; ylabel(cb, 'T [K]');

subplot(4, 2, 5);
pcolor(xx, yy, P);
shading interp;
axis equal tight;
title('Pressure Field');
xlabel('X [m]'); ylabel('Y [m]');
cb = colorbar; ylabel(cb, 'P [N/m^2]');

subplot(4, 2, 6);
pcolor(xx, yy, e);
shading interp;
axis equal tight;
title('Internal Energy Field');
xlabel('X [m]'); ylabel('Y [m]');
cb = colorbar; ylabel(cb, 'e [J/kg]');

subplot(4, 2, 7);
pcolor(xx, yy, Et);
shading interp;
axis equal tight;
title('Total Energy Field');
xlabel('X [m]'); ylabel('Y [m]');
cb = colorbar; ylabel(cb, 'E [kg/m s^2]');

subplot(4, 2, 8);
pcolor(xx, yy, mu);
shading interp;
axis equal tight;
title('Dynamic Viscosity Field');
xlabel('X [m]'); ylabel('Y [m]');
cb = colorbar; ylabel(cb, '/mu [N s/m^2]');


%% Functions

function U = prim2conv(rho, u, v, T, cv)
%PRIM2CONV Converts primative variables to conservative variables

U(1, :, :) = rho;
U(2, :, :) = rho.*u;
U(3, :, :) = rho.*v;
U(4, :, :) = rho.*(cv*T + (u.^2 + v.^2)/2);

end

function [rho,u,v,T,P,e,Et] = cons2prim(U,R,cv)
%CONS2PRIM Converts conservative variables into primative variables

rho = squeeze(U(1, :, :));
u = squeeze(U(2, :, :))./rho;
v = squeeze(U(3, :, :))./rho;
Et = squeeze(U(4, :, :));
e = Et./rho - (u.^2 + v.^2)/2;
T = e/cv;
P = rho.*T*R;

end

function mu = sunderland(T)
%SUNDERLAND Calculates dynamic viscosity based off of Sunderland's Law for air 

S1 = 110.4; %[K]
mu0 = 1.735e-5; %[N s/m^2]
T0 = 273.15; %[K]

mu = mu0*(T0+S1)*(T/T0).^(3/2)./(T+S1);

end