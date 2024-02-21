%% MAE182 Assignment 4 Problem 1
% Eric Foss
% A17068006
clear; close all; clc;

%% Part A

y = [1; 2; 1];

R = [1/2 0 0;
     0 1 0;
     0 0 1];

H = [1; 1; 1];

xbar = 2;

Pbar = 1/2;

xhat = inv(H'*inv(R)*H + inv(Pbar))*(H'*inv(R)*y + inv(Pbar)*xbar);

%% Part B

P = inv(H'*inv(R)*H + inv(Pbar));

sigma = sqrt(P);

%% Part C

ehat = y - H*xhat;