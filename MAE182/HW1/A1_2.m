%%MAE182 HW1 Problem 2
% Eric Foss
% A17068006
clear; close all; clc;

%% Part a

mu = 398600; %gravitational parameter for earth [km^3/s^2]
I = [1; 0; 0]; J = [0; 1; 0;]; K = [0; 0; 1]; %cordinate frame unit vectors

%parking orbit
r1 = [200+6371; 0; 0]; %initial position [km]
v1 = [0; sqrt(mu/norm(r1)); 0]; %initial velocity [km/s]

energy1 = 0.5*dot(v1, v1) - mu/norm(r1); %specific energy [km^2/s^2]
a1 = -mu/(2*energy1); %semi-major axis [km]
T1 = 2*pi/sqrt(mu/a1^3); %period of orbit

x0_1 = [r1; v1]; %initial state
xdot = @(x)[x(4:6);  -mu/(norm(x(1:3))^3)*x(1:3)]; %derivative of state
time1 = [0; T1]; %ode time step

[t1, y1] = ode45(@(t, x) xdot(x), time1, x0_1, odeset('RelTol',1e-12,'AbsTol',1e-15)); %ode


%GEO orbit
r2 = [-(35786+6371); 0; 0]; %initial position [km]
v2 = [0; -sqrt(mu/norm(r2)); 0]; %initial velocity [km/s]
koe2 = rv2kep(r2, v2, mu);

energy2 = 0.5*dot(v2, v2) - mu/norm(r2); %specific energy [km^2/s^2]
a2 = -mu/(2*energy2); %semi-major axis [km]
T2 = 2*pi/sqrt(mu/a2^3); %period of orbit

x0_2 = [r2; v2];
time2 = [0; T2];

[t2, y2] = ode45(@(t, x) xdot(x), time2, x0_2, odeset('RelTol',1e-12,'AbsTol',1e-15)); %ode


%hohmann transfer
ah = (norm(r1) + norm(r2))/2; %semi-major axis of Hohmann Transfer [km]

rp = r1; %initial position [km]
vp = [0; sqrt(mu*(2/norm(r1) - 1/ah)); 0]; %initial velocity [km/s]

ra = r2; %final position [km]
va = [0; -sqrt(mu*(2/norm(r2) - 1/ah)); 0]; %final velocity [km/s]

Th = pi*sqrt((ah^3)/mu); %Hohmann half period
koe_h = rv2kep(rp, vp, mu);

x0_h = [rp; vp]; %initial state
timeh = [0; Th];

[th, yh] = ode45(@(t, x) xdot(x), timeh, x0_h, odeset('RelTol',1e-12,'AbsTol',1e-15)); %ode

%deltaVs
dv1 = norm(vp) - norm(v1); %change in velocity to start hohmann transfer [km/s]
dv2 = norm(v2) - norm(va); %change in velocity to get into GEO orbit [km/s]

%% Part b

%misaligned hohmann transfer
rp_ma = r1; %initial position [km]
vp_ma = v1 + [dv1*sind(1); dv1*cosd(1); 0]; %misaligned hohmann transfer velocity [km/s]

koe_ma = rv2kep(rp_ma, vp_ma, mu);
time_ma = [0 pi/sqrt(mu/koe_ma(1)^3)];

x0_ma = [rp_ma; vp_ma]; %initial state

[th_ma, yh_ma] = ode45(@(t, x) xdot(x), time_ma, x0_ma, odeset('RelTol',1e-12,'AbsTol',1e-15)); %ode


%high Orbit (probs no longer GEO I would imagine)
r3 = yh_ma(end, 1:3)';
va_ma = yh_ma(end, 4:6)';
v3 = va_ma + dv2*va_ma/norm(va_ma);
koe3 = rv2kep(r3, v3, mu);

%find period
energy3 = 0.5*dot(v3, v3) - mu/norm(r3); %specific energy [km^2/s^2]
a3 = -mu/(2*energy3); %semi-major axis [km]
T3 = 2*pi/sqrt(mu/a3^3); %period of orbit

%propagation
x0_3 = [r3; v3]; %initial state
time3 = [0; T3]; %define time vector for ode

[t3, y3] = ode45(@(t, x) xdot(x), time3, x0_3, odeset('RelTol',1e-12,'AbsTol',1e-15)); %ode

koe_error = abs(koe_h - koe_ma);

%% Part c

%acceleration from parking
rp_a = r1; %initial position
vp_a = v1; %initial velocity
a = 0.03; %constant acceleration [km/s^2]


x0_a = [rp_a; vp_a]; %initial state
time_a = [0 dv1/a]; %define time for ode [s]

xdot_a = @(x)[x(4:6); -mu*x(1:3)/(norm(x(1:3))^3) + a*x(4:6)/norm(x(4:6))]; %derivative of state including acceleration

[t_a, y_a] = ode45(@(t, x) xdot_a(x), time_a, x0_a, odeset('RelTol',1e-12,'AbsTol',1e-15)); %ode

%hohmann transfer from accelerated
x0_ha = y_a(end, 1:6)';
koe_ha = rv2kep(x0_ha(1:3), x0_ha(4:6), mu);
time_ha = [0 (pi-koe_ha(6))*sqrt(koe_ha(1)^3/mu)];

[t_ha, y_ha] = ode45(@(t, x) xdot(x), time_ha, x0_ha, odeset('RelTol',1e-12,'AbsTol',1e-15)); %ode

%acceleration to GEO
x0_raa = y_ha(end, 1:6)';
time_raa = [0 dv2/a];

[t_raa, y_raa] = ode45(@(t, x) xdot_a(x), time_raa, x0_raa, odeset('RelTol',1e-12,'AbsTol',1e-15)); %ode

%GEO from accelerated
x0_2a = y_raa(end, 1:6)';
koe_2a = rv2kep(x0_2a(1:3), x0_2a(4:6), mu);
time_2a = [0, 2*pi*sqrt(koe_2a(1)^3/mu)];

[t_2a, y_2a] = ode45(@(t, x) xdot(x), time_2a, x0_2a, odeset('RelTol',1e-12,'AbsTol',1e-15)); %ode

%% PLOTS
%Plot of Orbits
figure(1); hold on;
plot(y1(:, 1), y1(:, 2), 'b-'); %parking
plot(yh(:, 1), yh(:, 2), 'g-'); %hohmann
plot(y2(:, 1), y2(:, 2), 'r-'); %GEO


title('Demonstration of Hohmann Transfer (ECI Coordinates)');
xlabel('x (km)'); ylabel('y (km)');
axis equal;
legend('Parking Orbit', 'Hohmann Transfer', 'GEO Orbit');

figure(2); hold on;
plot(y1(:, 1), y1(:, 2), 'b-'); %parking
plot(yh(:, 1), yh(:, 2), 'g-'); %hohmann
plot(y2(:, 1), y2(:, 2), 'r-'); %GEO
plot(y3(:, 1), y3(:, 2), 'c--'); %misaligned GEO
plot(yh_ma(:, 1), yh_ma(:, 2), 'k--'); %Misaligned Hohmann Transfer


title('Hohmann Transfer with Misaligned deltaV');
xlabel('x (km)'); ylabel('y (km)');
axis equal;
legend('Parking Orbit', 'Hohmann Transfer', 'GEO Orbit', 'Misaligned GEO Orbit', 'Misaligned Hohmann Tranfer');



figure(3); hold on;
plot(y1(:, 1), y1(:, 2), 'b-'); %parking
plot(y_a(:, 1), y_a(:, 2), 'm-'); %acceleration to hohmann
plot(y_ha(:, 1), y_ha(:, 2), 'g-'); %hohmann
plot(y_raa(:, 1), y_raa(:, 2), 'c-'); %acceleration to GEO
plot(y_2a(:, 1), y_2a(:, 2), 'r-'); %GEO

title('Hohmann Transfer w/ Acceleration Modeled');
xlabel('x (km)'); ylabel('y (km)'); 
axis equal;
legend('LEO', 'Acc to HT', 'HT', 'Acc to GEO', 'GEO');



%Position Plots
y2_mag = zeros(length(y2), 1);
y3_mag = zeros(length(y3), 1);
y_2a_mag = zeros(length(y_2a), 1);
for i = 1:length(y2)
    y2_mag(i) = norm(y2(i, 1:3));
end
for i = 1:length(y3)
    y3_mag(i) = norm(y3(i, 1:3));
end
for i = 1:length(y_2a)
    y_2a_mag(i) = norm(y_2a(i, 1:3));
end
figure(5); hold on;
plot(t2, y2_mag, 'k-');
plot(t3, y3_mag, 'r-');
plot(t_2a, y_2a_mag, 'g-');
title('Position Magnitude for GEO Orbits');
xlabel('Time (s)'); ylabel('Distance (km)'); xlim([0 86000]);
legend('Ideal GEO', 'Misaligned deltaV', 'Acceleration Modeled');
