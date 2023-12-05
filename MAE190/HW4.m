clear all; close all; clc;


%% Problem 4

data = csvread('sg700.csv');

z = data(20:end, 1);

T = data(20:end, 2);

S = data(20:end, 3);

y = z;

x = 1449.2 + 4.6*(T.^2) + 0.00024*(T.^2) + (1.34 - 0.01*T).*(S-35) + 0.016*z;


figure(1);
plot(x, y, 'b-'); hold on; grid on;
set(gca, 'YDir', 'reverse');
xlabel('Speed of Sound (m/s)'); ylabel('Depth (m)');
title("Speed of Sound compared to Depth");

