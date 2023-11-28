clear all; clc; close all;

%% Problem 5

rho = 1000;
S = 0.0455;
CD_0 = 0.1;
K = 0.06;
figure(1);

% Positive Buoyancy

W_B = -0.15;

V = 0.1:0.001:0.2;

q = 0.5*rho*V.^2;

a = 1;
b = -(q*S)./(K*W_B);
c = -(1+(q*S./(K*W_B)).^2 * K*CD_0);

x1 = (-b + sqrt(b.^2 - 4*a*c))/(2*a);
x2 = (-b - sqrt(b.^2 - 4*a*c))/(2*a);

gamma1 = asin(x1);
dx = V.*cos(gamma1)*100;
dy = V.*sin(gamma1)*100;

plot(dx, dy); hold on;

% Negative Buoyancy
W_B = 0.15;

V = 0.1:0.001:0.2;

q = 0.5*rho*V.^2;

a = 1;
b = -(q*S)./(K*W_B);
c = -(1+(q*S./(K*W_B)).^2 * K*CD_0);

x1 = (-b + sqrt(b.^2 - 4*a*c))/(2*a);
x2 = (-b - sqrt(b.^2 - 4*a*c))/(2*a);

gamma1 = asin(x2);
dx = V.*cos(gamma1)*100;
dy = V.*sin(gamma1)*100;

plot(dx, dy); hold on;
title('Velocity Behavior of Positive and Negative Buoyancy SeaGlide');
xlabel('Horizontal Velocity (cm/s)'); ylabel('Vertical Veloctiy (cm/s)');
grid on;
legend('Positive Buoyancy', 'Negative Buoyancy');
