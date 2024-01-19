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


x0_h = [rp; vp]; %initial state
timeh = [0; Th];

[th, yh] = ode45(@(t, x) xdot(x), timeh, x0_h, odeset('RelTol',1e-12,'AbsTol',1e-15)); %ode

%deltaV calcs
dv1 = norm(vp) - norm(v1);
dv2 = norm(v2) - norm(va);

%% Part b

%misaligned hohmann transfer
rp = r1; %initial position [km]
vp_ma = v1 + [dv1*sind(1); dv1*cosd(1); 0]; %misaligned hohmann transfer velocity [km/s]

x0_ma = [rp; vp_ma]; %initial state

[th_ma, yh_ma] = ode45(@(t, x) xdot(x), timeh, x0_ma, odeset('RelTol',1e-12,'AbsTol',1e-15)); %ode


%high Orbit (probs no longer GEO I would imagine)
r3 = yh_ma(end, 1:3)';
va_ma = yh_ma(end, 4:6)';
v3 = va_ma + dv2*va_ma/norm(va_ma);

%find period
energy3 = 0.5*dot(v3, v3) - mu/norm(r3); %specific energy [km^2/s^2]
a3 = -mu/(2*energy3); %semi-major axis [km]
T3 = 2*pi/sqrt(mu/a3^3); %period of orbit

%propagation
x0_3 = [r3; v3]; %initial state
time3 = [0; T3]; %define time vector for ode

[t3, y3] = ode45(@(t, x) xdot(x), time3, x0_3, odeset('RelTol',1e-12,'AbsTol',1e-15)); %ode



%% PLOTS
%Plot of Orbits
figure(4); hold on;
plot(y1(:, 1), y1(:, 2), 'b-'); %parking
plot(yh(:, 1), yh(:, 2), 'g-'); %hohmann
plot(y2(:, 1), y2(:, 2), 'r-'); %GEO
plot(y3(:, 1), y3(:, 2), 'c--'); %High
plot(yh_ma(:, 1), yh_ma(:, 2), 'k--'); %Misaligned Hohmann Transfer


title('Demonstration of Hohmann Transfer (ECI Coordinates)');
xlabel('x (km)'); ylabel('y (km)'); zlabel('z (km)');
axis equal tight;
legend('Parking Orbit', 'Hohmann Transfer', 'GEO Orbit', 'Misaligned High Orbit', 'Misaligned Hohmann Tranfer');


%Position Plots
% figure(5); hold on;
% subplot(2, 1, 1);
% 
% yh_mag = zeros(length(yh), 1);
% yh_ma_mag = zeros(length(yh_ma), 1);
% for i = 1:length(yh)
%     yh_mag(i) = norm(yh(i, 1:3));
% end
% for i = 1:length(yh_ma)
%     yh_ma_mag(i) = norm(yh_ma(i, 1:3));
% end
% 
% plot(th, yh_mag, 'b-'); hold on;
% plot(th_ma, yh_ma_mag, 'r--');
