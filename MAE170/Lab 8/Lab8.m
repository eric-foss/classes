clear all; close all; clc;

%% Question 1

theta = 0:15:180;
theta = theta*pi/180;
V = [2.23, 2.214, 2.143, 2.039, 1.899, 1.735, 1.559, 1.381, 1.205, 1.059, 0.941, 0.864, 0.825];

g = -9.81*cos(theta);

p = polyfit(g, V, 1);
%plot(g, V, 'ro'); hold on;
yneg = 0.01*ones(1, length(g));
ypos = 0.01*ones(1, length(g));
xneg = 9.81*sin(theta)*0.00175;
xpos = 9.81*sin(theta)*0.00175;

errorbar(g, V, yneg, ypos, xneg, xpos, 'r.'); hold on;
xf = g;
yf = g*p(1) + p(2);
plot(xf, yf, 'b-'); hold on;

legend('Raw Data', 'Best Fit');
xlabel('Tangential Acceleration (m/s^2)'); ylabel('Measured Voltage (V)');


%% Question 3
n = 13;
G = g/9.81;
S = sqrt((1/(n-2))*sum((yf - V).^2));
sa1 = S*sqrt(1/sum((G-mean(G)).^2));
sa0 = S*sqrt(sum(G.^2)/(n*sum((G-mean(G)).^2)));
