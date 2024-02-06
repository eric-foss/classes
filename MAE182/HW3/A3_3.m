%%MAE182 Assignment 3 Problem 3
% Eric Foss
% A17068006
clear; close all; clc;


%% Part A



x0 = [1; 0; 0; 1];
time = [0 100];


[t, x] = ode45(@planar_2BP, time, x0, odeset('RelTol',1e-12,'AbsTol',1e-15)); %ode