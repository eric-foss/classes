%% MAE182 Assignment 1
%   Eric Foss
%   A17068006


%% Problem 1a

mu = 398600; %gravitational parameter for earth [km^3/s^2]
I = [1; 0; 0]; J = [0; 1; 0;]; K = [0; 0; 1]; %cordinate frame unit vectors

koe = zeros(6, 1); %define Kepler Orbital Elements vector

r = [-2436.45; -2436.45; 6891.037]; %initial position [km]
v = [5.088611; -5.088611; 0];  %initial velocity [km/s]


h = cross(r, v); %specific angular momentum [km^2/s]
hhat = h/norm(h); %normalized specific angular momentum
energy = 0.5*dot(v, v) - mu/norm(r); %specific energy [km^2/s^2]
nhat = cross(K, h)/norm(cross(K, h)); %normalized ascending node
e = cross(v, h)/mu - r/norm(r); %eccentricity vector



koe(1) = -mu/(2*energy); %semi-major axis [km]
koe(2) = norm(e); %eccentricity
koe(3) = acos(dot([0 0 1],  hhat)); %inclination angle [rads]
koe(4) = atan2(nhat(2), nhat(1)); %longitude of ascending node [rads]
koe(5) = atan2(dot(hhat, cross(nhat, e)), dot(nhat, e)); %argument of periapsis [rads]

f = atan2(dot(hhat, cross(e, r)), dot(e, r)); %True anomoly [rads]
E = 2*atan(sqrt((1-norm(e))/(1+norm(e)))*tan(f/2)); %eccentric anomoly [rads]

koe(6) = E - norm(e)*sin(E); %Mean anomoly [rads]

%% Problem 1b




%% Problem 1c

x0 = [r; v]; %Initial state
xdot = @(x)[x(4:6); -mu/(norm(x(1:3))^3)*x(1:3)]; %Derivative of State

T = 2*pi/sqrt(mu/koe(1)^3); %Period of Orbit
time = 0:20:2*T; %20 sec time steps of two orbits

%Propagation
[t, y] = ode45(@(t, x) xdot(x), time, x0, odeset('RelTol',1e-12,'AbsTol',1e-15)); %ode
rt = y(:, 1:3); %propagated positions
vt = y(:, 4:6); %propagated velocities

%Defining vector sizes
at = zeros(size(rt)); 
pos = zeros(length(t), 1);
vel = zeros(length(t), 1);
acc = zeros(length(t), 1);

for i = 1:length(t)
    
    at(i, :) = -mu*rt(i, :)/(norm(rt(i, :))^3); %propagated accelerations
    
    %Magnitudes
    pos(i) = norm(rt(i, :));
    vel(i) = norm(vt(i, :));
    acc(i) = norm(at(i, :));

end

%PLOTS
figure(1); hold on;

%Postion Plot
subplot(3, 1, 1);
plot(t, pos, 'k-');
title('Position Magnitude');
xlabel('Time (s)'); ylabel('Position (km)');
xlim([0 2*T]);

%Velocity Plot
subplot(3, 1, 2)
plot(t, vel, 'b-');
title('Velocity Magnitude');
xlabel('Time (s)'); ylabel('Velocity (km/s)');
xlim([0 2*T]);

%Acceleration Plot
subplot(3, 1, 3);
plot(t, acc, 'r-');
title('Acceleration Magnitude');
xlabel('Time (s)'); ylabel('Acceleration (km/s^2)');
xlim([0 2*T]);

%% Problem 1d

denergy = zeros(length(t), 1);

for i = 1:length(t)

    denergy(i) = 0.5*vel(i)^2 - mu/pos(i) - energy;

end

figure(2);
plot(time, denergy, 'k-');