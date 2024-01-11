%%MAE 182 HW1
% Eric Foss
% A17068006

%% Problem 1
clear all; close all; clc;


%a
mu = 398600; % km^3/s^2
r = [-2436.45; -2436.45; 6891.037]; % km
v = [5.088611; -5.088611; 0]; % km/s

H = cross(r, v);

E = 0.5*norm(v)^2 - mu/norm(r);

e = cross(v, H)/mu - r/norm(r);

a = -mu/(2*E);
T = 2*pi/sqrt(mu/a^3);

ie = e/norm(e);
ih = H/norm(H);
ip = cross(ih, ie);

PN = [ie ip ih]';

Omega = atan(PN(3, 1)/-PN(3, 2));
i = acos(PN(3, 3));
omega = atan(PN(1, 3)/PN(2, 3));

M = E - norm(e)*sin(E);

%b



%c

x0 = [r; v];
xdot = @(x)[x(4:6); -mu/(norm(x(1:3))^3)*x(1:3)];

[t, y] = ode45(@(t, x) xdot(x), [0 2*T], x0, odeset('RelTol',1e-12,'AbsTol',1e-15));

