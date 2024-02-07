%%MAE185 Assignment 4 Problem 2
% Eric Foss
% A17068006
%clear; close all; clc;

load('supersonicJetLES_xyPlane.mat');
dx = (xx(end, 1) - xx(1, 1))/length(xx);
dy = (yy(1, end) - yy(1, 1))/width(yy);

mu = sutherland(T);

%% Fwd Dif in x, Central Dif in y:

tau_xx1 = 2*mu.*(ddx_fwd(u, dx) - (ddx_fwd(u, dx) + ddy_central(v, dy))/3); %normal stress in x
tau_yy1 = 2*mu.*(ddy_central(v, dy) - (ddx_fwd(u, dx) + ddy_central(v, dy))/3); %normal stress in y
tau_xy1 = mu.*(ddy_central(u, dy) + ddx_fwd(v, dx)); %shear stress

%% Central Dif in x, Bwd Dif in y:

tau_xx2 = 2*mu.*(ddx_central(u, dx) - (ddx_central(u, dx) + ddy_bwd(v, dy))/3); %normal stress in x
tau_yy2 = 2*mu.*(ddy_bwd(v, dy) - (ddx_central(u, dx) + ddy_bwd(v, dy))/3); %normal stress in y
tau_xy2 = mu.*(ddy_bwd(u, dy) + ddx_central(v, dx)); %shear strss

%% PLOTS

figure(1);
subplot(2, 3, 1);
pcolor(xx, yy, tau_xx1);
shading interp;
axis equal tight;
title('Normal Stress in X (Fwd Dif in X, Central Dif in Y)');
xlabel('X [m]'); ylabel('Y [m]');
cb = colorbar; ylabel(cb, '\sigma_x [N m/s^2]')
caxis([-0.5 0.5]);

subplot(2, 3, 2);
pcolor(xx, yy, tau_yy1);
shading interp;
axis equal tight;
title('Normal Stress in Y (Fwd Dif in X, Central Dif in Y)');
xlabel('X [m]'); ylabel('Y [m]');
cb = colorbar; ylabel(cb, '\sigma_y [N m/s^2]')
caxis([-0.5 0.5]);

subplot(2, 3, 3);
pcolor(xx, yy, tau_xy1);
shading interp;
axis equal tight;
title('Shear Stress (Fwd Dif in X, Central Dif in Y)');
xlabel('X [m]'); ylabel('Y [m]');
cb = colorbar; ylabel(cb, '\tau [N m/s^2]')
caxis([-0.5 0.5]);

subplot(2, 3, 4);
pcolor(xx, yy, tau_xx2);
shading interp;
axis equal tight;
title('Normal Stress in X (Central Dif in X, Bwd Dif in Y)');
xlabel('X [m]'); ylabel('Y [m]');
cb = colorbar; ylabel(cb, '\sigma_x [N m/s^2]')
caxis([-0.5 0.5]);

subplot(2, 3, 5);
pcolor(xx, yy, tau_yy2);
shading interp;
axis equal tight;
title('Normal Stress in Y (Central Dif in X, Bwd Dif in Y)');
xlabel('X [m]'); ylabel('Y [m]');
cb = colorbar; ylabel(cb, '\sigma_y [N m/s^2]')
caxis([-0.5 0.5]);


subplot(2, 3, 6);
pcolor(xx, yy, tau_xy2);
shading interp;
axis equal tight;
title('Shear Stress (Central Dif in X, Bwd Dif in Y)');
xlabel('X [m]'); ylabel('Y [m]');
cb = colorbar; ylabel(cb, '\tau [N m/s^2]')
caxis([-0.5 0.5]);

%% Functions

function mu = sutherland(T)
%SUNDERLAND Calculates dynamic viscosity based off of Sunderland's Law for air 

S1 = 110.4; %[K]
mu0 = 1.735e-5; %[N s/m^2]
T0 = 280; %[K]

mu = mu0*(T0+S1)*(T/T0).^(3/2)./(T+S1); %dynamic viscosity

end


function df = ddx_fwd(f, dx, bc)
%DDX_FWD First Order Forward Difference in X

%default to one-sided if lacking user input
if nargin < 3
    bc = 'one-sided';
end %if

df = zeros(size(f)); %initialize difference matrix

%fwd difference
for i = 1:length(f)-1
    for j = 1:width(f)
        df(i, j) = (f(i+1, j) - f(i, j))/dx;
    end %for
end %for

switch bc %boundry conditions
    case 'periodic' %periodic boundry conditions
        i = length(f);
        for j = 1:width(f)
            df(i, j) = (f(1, j) - f(i, j))/dx; %right periodic
        end %for
    otherwise %backward difference at BC
        i = length(f);
        for j = 1:width(f)
            df(i, j) = (f(i, j) - f(i-1, j))/dx; %right bwd dif
        end %for
end %switch
end %function


function df = ddx_central(f, dx, bc)
%DDX_CENTRAL Second Order Central Difference in X

%default to one-sided if lacking user input
if nargin < 3
    bc = 'one-sided';
end %if

df = zeros(size(f)); %initialize difference matrix

%central difference
for i = 2:length(f)-1
    for j = 1:width(f)
        df(i, j) = (f(i+1, j) - f(i-1, j))/(2*dx);
    end %for
end %for

switch bc
    case 'periodic' %periodic boundry conditions
        for j = 1:width(f)
            i = 1;
            df(i, j) = (f(i+1, j) - f(end, j))/(2*dx); %left periodic
            i = length(f);
            df(i, j) = (f(1, j) - f(i-1, j))/(2*dx); %right periodic
        end %for
    otherwise %one-sided boundry conditions
        for j = 1:width(f)
            i = 1;
            df(i, j) = (-3*f(i, j) + 4*f(i+1, j) - f(i+2, j))/(2*dx); %left 2nd order fwd dif
            i = length(f);
            df(i, j) = (3*f(i, j) - 4*f(i-1, j) + f(i-2, j))/(2*dx); %rigth 2nd order bwd dif
        end %for
end %switch
end %function


function df = ddy_central(f, dy, bc)
%DDY_CENTRAL Second Order Central Difference in Y

%default to one-sided if lacking user input
if nargin < 3
    bc = 'one-sided';
end %if

df = zeros(size(f)); %initialize difference matrix

%central difference
for j = 2:width(f)-1
    for i = 1:length(f)
        df(i, j) = (f(i, j+1) - f(i, j-1))/(2*dy);
    end %for
end %for

switch bc %boundry conditions
    case 'periodic' %periodic boundry conditions
        for i = 1:length(f)
            j = 1;
            df(i, j) = (f(i, j+1) - f(i, end))/(2*dy); %left periodic
            j = length(f);
            df(i, j) = (f(i, 1) - f(i, j-1))/(2*dy); %right periodic
        end %for
    otherwise %one-sided
        for i = 1:length(f)
            j = 1;
            df(i, j) = (-3*f(i, j) + 4*f(i, j+1) - f(i, j+2))/(2*dy); %2nd order fwd diff on left
            j = width(f);
            df(i, j) = (3*f(i, j) - 4*f(i, j-1) + f(i, j-2))/(2*dy); %2nd order bwd diff on right
        end %for
end %switch
end %function


function df = ddy_bwd(f, dy, bc)
%%DDY_BWD First Order Backward Difference in Y

%default to one-sided if lacking user input
if nargin < 3
    bc = 'one-sided';
end %if

df = zeros(size(f)); %initialize difference matrix

%backward difference
for j = 2:width(f)
    for i = 1:length(f)
        df(i, j) = (f(i, j) - f(i, j-1))/dy;
    end %for
end %for

switch bc %boundry conditions
    case 'periodic' %periodic boundry conditions
        j = 1;
        for i = 1:length(f)
            df(i, j) = (f(i, j) - f(i, end))/dy; %left periodic
        end %for
    otherwise %one-sided
        j = 1;
        for i = 1:length(f)
            df(i, j) = (f(i, j+1) - f(i, j))/dy; %left fwd dif
        end %for
end %switch
end %function
