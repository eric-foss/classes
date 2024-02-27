%% MAE182 Assignment 4 Problem 1
% Eric Foss
% A17068006
clear; close all; clc;

%% Part A

%Givens
y = [1; 2; 1];
R = [1/2 0 0;
     0 1 0;
     0 0 1];
H = [1; 1; 1];
xbar = 2;
Pbar = 1/2;

%Deviation
xhat = inv(H'*inv(R)*H + inv(Pbar))*(H'*inv(R)*y + inv(Pbar)*xbar);

%% Part B

%Variance
P = inv(H'*inv(R)*H + inv(Pbar));

%Standard Deviation
sigma = sqrt(P);

%% Part C

%Error
ehat = y - H*xhat;