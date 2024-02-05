%% MAE 185 Assignment 3 Problem 3
% Eric Foss
% A17068006
clear; close all; clc;

%load and store initial state
load('gotritons.mat', 'T', 'xx', 'yy');
Tinitial = T;

%define constants
Cx = 1;
Cy = 1;
dx = xx(2, 1) - xx(1, 1);
dy = yy(1, 2) - yy(1, 1);
SF = 1.1;

t_final = 2;
dt = dx*dy/(SF*(Cx*dy + Cy*dx));
dt = t_final/ceil(t_final/dt); %so its nice and whole
t = 0:dt:t_final;

T = zeros(length(t), length(Tinitial), width(Tinitial));
Tbar = zeros(length(t), length(Tinitial), width(Tinitial));
T(1, :, :) = Tinitial;


for n = 2:length(t)

    Tbar(n, :, :) = squeeze(T(n-1, :, :)) - Cx*dt*ddx_fwd(squeeze(T(n-1, :, :)), dx, 'periodic') - Cy*dt*ddy_fwd(squeeze(T(n-1, :, :)), dy, 'periodic');
    T(n, :, :) = 0.5*(squeeze(Tbar(n, :, :)) + squeeze(T(n-1, :, :))) - Cx*(dt/2)*ddx_bwd(squeeze(Tbar(n, :, :)), dx, 'periodic') - Cy*(dt/2)*ddy_bwd(squeeze(Tbar(n, :, :)), dy, 'periodic');

end

%Animation Loop
figure(1);
for i = 1:length(t)
    
    pcolor(xx, yy, squeeze(T(i, :, :)));
    shading interp;
    axis equal tight;
    colorbar;
    title('T: MacCormacks Method'); xlabel('x'); ylabel('y');
    clim([0 1]);
    drawnow;

end


%% FUNCTIONS

function df = ddx_fwd(f, dx, bc)
%DDX_FWD First Order Forward Difference in X

df = zeros(size(f));

if nargin < 3
    bc = 'one-sided';
end

for i = 1:length(f)-1
    for j = 1:width(f)

        df(i, j) = (f(i+1, j) - f(i, j))/dx; %fwd dif

    end
end

switch bc %Boundry Conditions
    case 'periodic'
        i = length(f);
        for j = 1:width(f)
            df(i, j) = (f(1, j) - f(i, j))/dx; %periodic
        end
    otherwise
        i = length(f);
        for j = 1:width(f)
            df(i, j) = (f(i, j) - f(i-1, j))/dx; %bwd dif
        end
end

end

function df = ddy_fwd(f, dy, bc)
%DDY_FWD First Order Foward Difference in Y

df = zeros(size(f));

if nargin < 3
    bc = 'one-sided';
end

for j = 1:width(f)-1
    for i = 1:length(f)  

        df(i, j) = (f(i, j+1) - f(i, j))/dy;

    end
end

switch bc %Boundry Conditions
    case 'periodic'
        j = width(f);
        for i = 1:length(f)
            df(i, j) = (f(i, 1) - f(i, j))/dy; %periodic
        end
    otherwise
        j = width(f);
        for i = 1:length(f)
            df(i, j) = (f(i, j) - f(i, j-1))/dy; %bwd dif
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

df = zeros(size(f));

if nargin < 3
    bc = 'one-sided';
end

for j = 2:width(f)
    for i = 1:length(f)

        df(i, j) = (f(i, j) - f(i, j-1))/dy; %bwd dif

    end
end

switch bc %Boundry Conditions
    case 'periodic'
        j = 1;
        for i = 1:length(f)
            df(i, j) = (f(i, j) - f(i, end))/dy; %periodic BC
        end
    otherwise
        j = 1;
        for i = 1:length(f)
            df(i, j) = (f(i, j+1) - f(i, j))/dy; %fwd dif
        end
end

end
