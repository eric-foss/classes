%%MAE185 Assignment 4 Problem 3
% Eric Foss
% A17068006
clear; close all; clc;

load('gotritons_uv.mat');


dx = (xx(end, 1) - xx(1, 1))/length(xx); %x mesh step
dy = (yy(1, end) - yy(1, 1))/width(yy); %y mesh step
d = 0.0005; %diffusion constant 
SF = 1.12; %time step safety factor

u(:, 1) = 0; u(:, end) = 0; %noslip bc
v(:, 1) = 0; v(:, end) = 0; %noslip bc

t_final = 2; %time to simulate to
t = 0;
while t < t_final
    dt = dx*dy/(SF*(dy*max(max(u)) + dx*max(max(v))));
    t = t + dt;
     
    dudx = ddx_fwd(u, dx, 'periodic');
    dudy = ddy_fwd(u, dy, 'periodic');
    d2udx2 = d2dx2_central(u, dx, 'periodic');
    d2udy2 = d2dy2_central(u, dy, 'periodic');

    ubar = u + dt*(d*(d2udx2 + d2udy2) - u.*dudx - v.*dudy);
    ubar(:, 1) = 0; ubar(:, end) = 0;
    
    dvdx = ddx_fwd(v, dx, 'periodic');
    dvdy = ddy_fwd(v, dy, 'periodic');
    d2vdx2 = d2dx2_central(v, dx, 'periodic');
    d2vdy2 = d2dy2_central(v, dy, 'periodic');
    
    vbar = v + dt*(d*(d2vdx2 + d2vdy2) - u.*dvdx - v.*dvdy);
    vbar(:, 1) = 0; vbar(:, end) = 0;

    dubardx = ddx_bwd(ubar, dx, 'periodic');
    dubardy = ddy_bwd(ubar, dy, 'periodic');
    d2ubardx2 = d2dx2_central(ubar, dx, 'periodic');
    d2ubardy2 = d2dy2_central(ubar, dy, 'periodic');
    
    u = 0.5*(ubar + u) + (dt/2)*(d*(d2ubardx2 + d2ubardy2) - u.*dubardx - v.*dubardy);
    u(:, 1) = 0; u(:, end) = 0; %noslip bc

    dvbardx = ddx_bwd(vbar, dx, 'periodic');
    dvbardy = ddy_bwd(vbar, dy, 'periodic');
    d2vbardx2 = d2dx2_central(vbar, dx, 'periodic');
    d2vbardy2 = d2dy2_central(vbar, dy, 'periodic');

    v = 0.5*(vbar + v) + (dt/2)*(d*(d2vbardx2 + d2vbardy2) - u.*dvbardx - v.*dvbardy);
    v(:, 1) = 0; v(:, end) = 0; %noslip bc
    
    %animation
    figure(1); hold on;
    pcolor(xx, yy, u);
    shading interp;
    axis equal tight;
    title('U Velocity Field');
    xlabel('X [m]'); ylabel('Y [m]');
    cb =colorbar; ylabel(cb, 'u [m/s]');
    %clim([0 2]);

end %while



%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

function df = ddy_fwd(f, dy, bc)
%DDY_FWD First Order Foward Difference in Y

%default to one-sided if lacking user input
if nargin < 3
    bc = 'one-sided';
end

df = zeros(size(f)); %initialize difference matrix

%fwd difference
for j = 1:width(f)-1
    for i = 1:length(f)        
        df(i, j) = (f(i, j+1) - f(i, j))/dy;
    end
end

switch bc %Boundry Conditions
    case 'periodic' %Periodic Boundry Conditions
        j = width(f);
        for i = 1:length(f)
            df(i, j) = (f(i, 1) - f(i, j))/dy;
        end
    otherwise %Backward Difference at BC
        j = width(f);
        for i = 1:length(f)
            df(i, j) = (f(i, j) - f(i, j-1))/dy;
        end
end
end


function df = ddx_bwd(f, dx, bc)
%%DDX_BWD First Order Backward Difference in X

df = zeros(size(f));

if nargin < 3
    bc = 'one-sided';
end

for i = 2:length(f)
    for j = 1:width(f)

        df(i, j) = (f(i, j) - f(i-1, j))/dx; %bwd dif

    end
end

switch bc %Boundry Conditions
    case 'periodic'
        i = 1;
        for j = 1:width(f)
            df(i, j) = (f(i, j) - f(end, j))/dx; %periodic
        end

    otherwise
        i = 1;
        for j = 1:width(f)
            df(i, j) = (f(i+1, j) - f(i, j))/dx; %fwd dif
        end
end
end


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


function df = d2dx2_central(f, dx, bc)
%D2DX2_CENTRAL Summary of this function goes here

%default to one-sided if lacking user input
if nargin < 3
    bc = 'one-sided';
end %if

df = zeros(size(f)); %initialize difference matrix

%central second difference
for i = 2:(length(f)-1)
    for j = 1:width(f)
        df(i, j) = (f(i+1, j) - 2*f(i, j) + f(i-1, j))/(dx^2);
    end %for
end %for

switch bc
    case 'periodic' %periodic boundry conditions
        for j = 1:width(f)
            i = 1;
            df(i, j) = (f(i+1, j) - 2*f(i, j) + f(length(f), j))/(dx^2);
            i = length(f);
            df(i, j) = (f(1, j) - 2*f(i, j) + f(i-1, j))/(dx^2);
        end
    otherwise %one-sided boundry conditions
        for j = 1:width(f)
            i = 1;
            df(i, j) = (2*f(i, j) -5*f(i+1, j) + 4*f(i+2, j) - f(i+3, j))/(dx^2);
            i = length(f);
            df(i, j) = (2*f(i, j) -5*f(i-1, j) + 4*f(i-2, j) - f(i-3, j))/(dx^2);
        end %for
end %switch

end %function


function df = d2dy2_central(f, dy, bc)
%D2DY2_CENTRAL Second Order Central Second Difference

%default to one-sided if lacking user input
if nargin < 3
    bc = 'one-sided';
end %if

df = zeros(size(f)); %initialize difference matrix

%central second difference
for j = 2:(width(f)-1)
    for i = 1:length(f)
        df(i, j) = (f(i, j+1) - 2*f(i, j) + f(i, j-1))/(dy^2);
    end %for
end %for

switch bc
    case 'periodic' %periodic boundry conditions
        for i = 1:length(f) 
            j = 1;
            df(i, j) = (f(i, j+1) - 2*f(i, j) + f(i, width(f)))/(dy^2);
            j = width(f);
            df(i, j) = (f(i, 1) - 2*f(i, j) + f(i, j-1))/(dy^2);
        end %for
    otherwise 
        for i = 1:length(f)
            j = 1;
            df(i, j) = (2*f(i, j) - 5*f(i, j+1) + 4*f(i, j+2) - f(i, j+3))/(dy^2); %2nd order fwd
            j = width(f);
            df(i, j) = (2*f(i, j) - 5*f(i, j-1) + 4*f(i, j-2) - f(i, j-3))/(dy^2); %2nd order bwd
        end %for
end %switch

end %function

