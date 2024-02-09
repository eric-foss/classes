%%MAE182 Assignment 3 Problem 3
% Eric Foss
% A17068006
clear; close all; clc;


%% Part A

x0 = [1; 0; 0; 1]; %initial condition
time = 0:0.001:100; %specify time step for simplicity
i = 1:10000:100001; %indices corresponding to t = 0 10 20 ...

[~, x] = ode45(@planar_2BP, time, x0, odeset('RelTol',1e-12,'AbsTol',1e-15)); %propagate

X_true = x(i, :); %true states at t = 0 10 20 ...

%% Part B

dX0 = [1; -1; 1; 1]*10^-6; %initial deviation
x_ref0 = x0 - dX0; %initial reference
phi0 = eye(4); %initial stm
x_ref0 = [x_ref0; reshape(phi0, 16, 1)]; %initial ref state w/ stm

[t, x] = ode45(@dev_stm, time, x_ref0, odeset('RelTol',1e-12,'AbsTol',1e-15)); %propagate

X_ref = x(i, 1:4); %ref states at t = 0 10 20 ...

phi = x(i, 5:20); %unshaped stm

Phi = zeros(4, 4, 11); %initialize stm 3d matrix
for i = 1:11
    Phi(:, :, i) = reshape(phi(i, :), 4, 4); %shaped stm
end

%% Part C

dX1 = X_true - X_ref; %true deviation

dX2 = zeros(11, 4);
for i = 1:11
    dX2(i, :) = reshape(phi(i, :), 4, 4)*dX0; %stm determined deviation
end