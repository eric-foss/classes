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


%% Problem 5

s1 = [100; -50];
s2 = [-350; 500];
s3 = [-100; -150];

d1 = 292;
d2 = 424;
d3 = 354;

b = [s1'*s1 - d1^2;
    s2'*s2 - d2^2;
    s3'*s3 - d3^2];

A = [2*s1', -1;
    2*s2', -1;
    2*s3', -1];

y = A\b;

