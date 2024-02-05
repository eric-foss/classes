%% MAE 185 Assignment 3 Problem 2
% Eric Foss
% A17068006
clear all; close all; clc;

%load and store initial state
load('gotritons.mat', 'T', 'xx', 'yy');
Tinitial = T;

%define constants
Cx = 1;
Cy = 1;
dx = xx(2, 1) - xx(1, 1);
dy = yy(1, 2) - yy(1, 1);
SF = 1.1;

%% First Order Backward

t1_final = 2;
dt1 = dx*dy/(SF*(Cx*dy + Cy*dx));
dt1 = t1_final/ceil(t1_final/dt1); %so its nice and whole
t1 = 0:dt1:t1_final;

T1 = zeros(length(t1), length(Tinitial), width(Tinitial));
T1(1, :, :) = Tinitial;

for n = 2:length(t1)
    
    T1(n, :, :) = squeeze(T1(n-1, :, :)) - Cx*dt1*ddx_bwd_PB(squeeze(T1(n-1, :, :)), dx) - Cy*dt1*ddy_bwd_PB(squeeze(T1(n-1, :, :)), dy);

end

%% Second Order Central

t2_final = 0.25;
dt2 = dx*dy/(SF*(Cx*dy + Cy*dx));
dt2 = t2_final/ceil(t2_final/dt2);
t2 = 0:dt2:t2_final;

T2 = zeros(length(t2), length(xx), width(xx));
T2(1, :, :) = Tinitial;

for n = 2:length(t2)

    T2(n, :, :) = squeeze(T2(n-1, :, :)) - Cx*dt2*ddx_central_PB(squeeze(T2(n-1, :, :)), dx) - Cy*dt2*ddy_central_PB(squeeze(T2(n-1, :, :)), dy);

end

%Animation Loop
figure(1);
for i = 1:length(t1)
    
    pcolor(xx, yy, squeeze(T1(i, :, :)));
    shading interp;
    axis equal tight;
    colorbar;
    title('T: 1st Order Backward Difference'); xlabel('x'); ylabel('y');
    drawnow;
    clim([0 1]);

end

figure(2);
for i = 1:length(t2)

    pcolor(xx, yy, squeeze(T2(i, :, :)));
    shading interp;
    axis equal tight;
    colorbar;
    title('T: 2nd Order Central Difference'); xlabel('x'); ylabel('y');
    clim([0 1])
    drawnow;

end

%% FUNCTIONS

function df = ddx_bwd_PB(f, dx)
%%DDX_BWD_PB First Order Backward Difference in X With Periodic Boundries

df = zeros(size(f));
for i = 1:length(f)
    for j = 1:width(f)
        if i == 1
            df(i, j) = (f(i, j) - f(length(f), j))/dx;
            continue;
        end

        df(i, j) = (f(i, j) - f(i-1, j))/dx;

    end
end

end

function df = ddy_bwd_PB(f, dy)
%%DDY_BWD_PB First Order Backward Difference in Y With Periodic Boundries

df = zeros(size(f));

for j = 1:width(f)
    for i = 1:length(f)

        if j == 1
            df(i, j) = (f(i, j) - f(i, width(f)))/dy;
            continue;
        end

        df(i, j) = (f(i, j) - f(i, j-1))/dy;

    end
end

end

function df = ddx_central_PB(f, dx)
%DDX_CENTRAL_PB Second Order Central Difference in X with Periodic
%Boundries

df = zeros(size(f)); %define df array

%loop through f array
for i = 1:length(f)
    for j = 1:width(f)
        %check boundary conditions
        if i == 1
            df(i, j) = (f(i+1, j) - f(length(f), j))/(2*dx); %second order fwd
            continue;
        end
        if i == length(f)
            df(i, j) = (f(1, j) - f(i-1, j))/(2*dx); %second order bwd
            continue;
        end

        %second order central
        df(i, j) = (f(i+1,j) - f(i-1, j))/(2*dx);

    end
end

end

function df = ddy_central_PB(f, dy)
%DDY_CENTRAL_PB Second Order Central Difference in Y with Periodic Boundries

df = zeros(size(f));

%loop through f array
for j = 1:width(f)
    for i = 1:length(f)
        %check boundary conditions
        if j == 1
            df(i, j) = (f(i, j+1) - f(i, width(f)))/(2*dy); %periodic
            continue;
        end
        if j == width(f)
            df(i, j) = (f(i, 1) - f(i, j-1))/(2*dy); %periodic
            continue;
        end
        
        df(i, j) = (f(i, j+1) - f(i, j-1))/(2*dy);

    end
end

end
