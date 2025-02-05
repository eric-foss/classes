%% MAE 182 Assignment 2 Problem 2
% Eric Foss
% A17068006
clear; close all; clc;
%% Part A

syms x y z J mu Re; %symbolic constants/variables
r = [x; y; z]; %symbolic r vector
rmag = sqrt(x^2 + y^2 + z^2); %non-bold r
U_prime(x, y, z) = (mu/rmag)*(1 - J*(Re/rmag)^2 * ((3/2)*(z/rmag)^2 - 1/2)); %given U' function
grad = gradient(U_prime, r); %symbolic gradient
pretty(simplify(grad)) %display symbolic gradient to terminal all pretty like

%% Part b

r = [-2436.45; -2436.45; 6891.037]; %initial position in ECI[km]
v = [5.088611; -5.088611; 0];  %initial velocity [km/s]
J_val = 0.00108248; %J2 Pertubations
mu_val = 398600.4354360959; %gravitational parameter for earth [km^3/s^2]
Re_val = 6378.1366; %radius of earth [km]

grad = subs(grad, [J, mu, Re], [J_val, mu_val, Re_val]); %substitute constants into symbolic gradient

rddot = matlabFunction(grad); %convert symfun to matlab function

x0 = [r; v]; %initial state
time = [0 86400]; %time vector for ode, 1 day
xdot = @(x)[x(4:6); rddot(x(1), x(2), x(3))]; %dynamics

[t, x] = ode45(@(t, x) xdot(x), time, x0, odeset('RelTol',1e-12,'AbsTol',1e-15)); %ode

koe = zeros(length(x), 6); %define matrix for keplarian orbitial elements at each state
for i = 1:length(x)
    koe(i, :) = rv2koe(x(i, 1:3), x(i, 4:6), mu_val, 'rad');
end

%PLOTS
figure(1);
%Semi-major Axis Plot
subplot(3, 2, 1);
plot(t/3600, koe(:, 1), 'b-');
title('Semi-Major Axis over 1 Day'); xlabel('Time (hr)'); ylabel('Semi-Major Axis (km)');
xlim([0 24]);
%Eccentricity Plot
subplot(3, 2, 2);
plot(t/3600, koe(:, 2), 'b-');
title('Eccentricity over 1 Day'); xlabel('Time (hr)'); ylabel('Eccentricity');
xlim([0 24]);
%Inclination Plot
subplot(3, 2, 3);
plot(t/3600, koe(:, 3), 'b-');
title('Inclination Angle over 1 Day'); xlabel('Time (hr)'); ylabel('Inclination (rad)');
xlim([0 24]);
%Right Ascension Plot
subplot(3, 2, 4);
plot(t/3600, koe(:, 4), 'b-');
title('Right Ascension over 1 Day'); xlabel('Time (hr)'); ylabel('Right Ascension (rad)');
xlim([0 24]);
%Argument of Periapsis Plot
subplot(3, 2, 5);
plot(t/3600, koe(:, 5), 'b-');
title('Argument of Pariapsis over 1 Day'); xlabel('Time (hr)'); ylabel('Argument of Periapsis (rad)');
xlim([0 24]);
%Mean Anomoly Plot
subplot(3, 2, 6);
plot(t/3600, koe(:, 6), 'b-');
title('Mean Anomoly over 1 Day'); xlabel('Time (hr)'); ylabel('Mean Anomoly (rad)');
xlim([0 24]);

%% Part C

time = 0:20:86400; %redifine time for 20 sec intervals
[t, x] = ode45(@(t, x) xdot(x), time, x0, odeset('RelTol',1e-12,'AbsTol',1e-15)); %ode

energy0 = 0.5*norm(v)^2 - mu_val/norm(r);%find initial energy
denergy = zeros(length(t), 1); %define delta energy vector
%loop through every state
for i = 1:length(t)
    denergy(i) = 0.5*norm(x(i, 4:6))^2 - mu_val/norm(x(i, 1:3)) - energy0; %calc deltaenergy for each state
end

%PLOT
figure(2);
plot(t/3600, denergy, 'b-');
title('Change in Specific Energy over 1 Day'); xlabel('Time (hr)'); ylabel('Change in Specific Energy (km^2/s^2)');
xlim([0 24]);

%% Part D

H0 = cross(r, v);
dH = zeros(length(t), 3);
for i = 1:length(t)
    dH(i, :) = cross(x(i, 1:3), x(i, 4:6)) - H0';
end

%PLOT
figure(3);
plot(t/3600, dH(:, 3), 'b-');
title('Change in Angular Momentum over 1 Day'); xlabel('Time (hr)'); ylabel('Change in Angular Momentum (km^2/s)');
xlim([0 24]);

