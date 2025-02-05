%% MAE182 Assignment 3 Problem 1
% Eric Foss
% A170680067
% Credit For Plot of Earth: https://www.mathworks.com/matlabcentral/fileexchange/13823-3d-earth-example?status=SUCCESS
clear; close all; clc;

%% Part A

const.mu = 398600.4354360959; %gravitation parameter for earth [km^2/s^2]
const.J2 = 0.00108248; %J2 value
const.Re = 6378.1366; %radius of earth [km]

r = [-2436.45; -2436.45; 6891.037]; %initial position in ECI[km]
v = [5.088611; -5.088611; 0];  %initial velocity [km/s]

x0 = [r; v];
time = [0 86400];

[~, y] = ode45(@TwoBP_J2_drag, time, x0, odeset('RelTol',1e-12,'AbsTol',1e-15), const); %ode


%PLOT
figure('Color', 'k'); hold on;
set(gca, 'NextPlot','add', 'Visible','off'); axis equal; axis auto;
view(0,30);
axis vis3d;

%Globe Plot
npanels = 180;   % Number of globe panels around the equator deg/panel = 360/npanels
alpha   = 1; % globe transparency level, 1 = opaque, through 0 = invisible
GMST0 = 4.89496121282306; % Set up a rotatable globe at J2000.0
image_file = 'http://upload.wikimedia.org/wikipedia/commons/thumb/c/cd/Land_ocean_ice_2048.jpg/1024px-Land_ocean_ice_2048.jpg';
erad    = 6371.0087714; % equatorial radius (meters)
prad    = 6371.0087714; % polar radius (meters)
erot    = 7.2921158553; % earth rotation rate (radians/sec)
[xg, yg, zg] = ellipsoid(0, 0, 0, erad, erad, prad, npanels);
globe = surf(xg, yg, -zg, 'FaceColor', 'none', 'EdgeColor', 0.5*[1 1 1]); hold on;
if ~isempty(GMST0)
    hgx = hgtransform;
    set(hgx,'Matrix', makehgtform('zrotate',GMST0));
    set(globe,'Parent',hgx);
end
cdata = imread(image_file);
set(globe, 'FaceColor', 'texturemap', 'CData', cdata, 'FaceAlpha', alpha, 'EdgeColor', 'none');

%Orbit Plot
plot3(y(:, 1), y(:, 2), y(:, 3), 'r');
title('Atmospheric Drag Simulation in ECI Frame');

%% Part B Change in Energy over 1 Day

time = 0:20:86400; %20 sec time step
[t, x] = ode45(@TwoBP_J2_drag, time, x0, odeset('RelTol',1e-12,'AbsTol',1e-15), const); %propagate

U0 = (const.mu/norm(r))*(1 - const.J2*(const.Re/norm(r))^2*(3/2*(r(3)/norm(r))^2 - 1/2));
energy0 = 0.5*norm(v)^2 - U0; %initial specific energy [km^2/s^2]
denergy = zeros(length(t), 1); %initialize delta energy vector
U = zeros(length(t), 1); %initialize potential vector
%loop through propagated values and find energy
for i = 1:length(t)
    U(i) = (const.mu/norm(x(i, 1:3)))*(1 - const.J2*(const.Re/norm(x(i, 1:3)))^2*(3/2*(x(i, 3)/norm(x(i, 1:3)))^2 -1/2));
    denergy(i) = 0.5*norm(x(i, 4:6))^2 - U(i) - energy0;
end

%PLOT
figure(2);
plot(t/3600, denergy, 'b-');
title('Change in Specific Energy over 1 Day'); xlabel('Time (hr)'); ylabel('Change in Specific Energy (km^2/s^2)');
xlim([0 24]);

%% Part C Plotting Orbital Elements

koe = zeros(length(t), 6);
for i = 1:length(x)
    koe(i, :) = rv2koe(x(i, 1:3), x(i, 4:6), const.mu, 'rad');
end

%PLOTS
figure(3);
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