%% MAE182 Assignment 3 Problem 1
% Eric Foss
% A170680067

const.mu = 398600.4354360959; %gravitation parameter for earth [km^2/s^2]
const.J2 = 0.00108248; %J2 value
const.Re = 6378.1366; %radius of earth [km]

r = [-2436.45; -2436.45; 6891.037]; %initial position in ECI[km]
v = [5.088611; -5.088611; 0];  %initial velocity [km/s]

x0 = [r; v];
time = [0 86400];

[t, y] = ode45(@TwoBP_J2_drag, time, x0, odeset('RelTol',1e-12,'AbsTol',1e-15), const); %ode
