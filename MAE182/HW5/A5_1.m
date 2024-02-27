%% MAE 182 Assignment 5 Problem 1
% Eric Foss
% A17068006
clear; close all; clc;

%% Part A: Batch Algorithm



% Initial State
phi0 = eye(3);
X0_ref = [1; 1; 1; reshape(phi0, 9, 1)];

% A Piori
x0_bar = [0; 0; 0];
P0_bar = [4 0 0;
          0 2 0;
          0 0 1];

% Measurements
t = 0:1;
Y = 2;
R = 1;

itr = 4;
Lambda = inv(P0_bar);
N = Lambda*x0_bar;


for j = 1:itr
    
    for t = 1:2
        X_ref




end

    
