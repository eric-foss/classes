%%MAE182 HW1 Problem 1
% Eric Foss
% A17068006
clear; close all; clc;

%% Part a

mu = 398600; %gravitational parameter for earth [km^3/s^2]
r = [-2436.45; -2436.45; 6891.037]; %initial position [km]
v = [5.088611; -5.088611; 0];  %initial velocity [km/s]

koe = rv2kep(r, v, mu); %ECI to keplarian orbital elements conversion function

%% Part b

[r2, v2] = kep2rv(koe, mu); %keplarian orbital elements to ECI conversion function

%% Part c

T = 2*pi/sqrt(mu/koe(1)^3); %Period of Orbit
time = 0:20:2*T; %define ode time step
x0 = [r; v]; %initial state
xdot = @(x)[x(4:6); -mu/(norm(x(1:3))^3)*x(1:3)]; %derivative of State

[t, x] = ode45(@(t, x) xdot(x), time, x0, odeset('RelTol',1e-12,'AbsTol',1e-15)); %ode

[pos, vel, acc] = posvelacc(t, x, mu, 1);

%% Part d

denergy = zeros(length(time), 1); %define change in energy vector
energy0 = 0.5*vel(1)^2 - mu/pos(1); %find initial energy

%loop through each state
for i = 1:length(time)

    denergy(i) = 0.5*vel(i)^2 - mu/pos(i) - energy0; %change in energy

end

%plot
figure(2); hold on;
title('Change in Specific Energy');
xlabel('Time (s)'); ylabel('Difference from Initial Energy (km^2/s^2)');
plot(time, denergy, 'k-');
xlim ([0 2*T]); %ylim([-1 1]);

