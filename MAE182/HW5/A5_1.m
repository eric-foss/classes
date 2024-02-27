%% MAE 182 Assignment 5 Problem 1
% Eric Foss
% A17068006
clear; close all; clc;

% Initial State
X0_ref = [1; 1; 1];

% A Piori
x0_bar = [0; 0; 0];
P0_bar = [4 0 0;
          0 2 0;
          0 0 1];

% Measurements
t = 1;
Y = 2;
R = 1;
H_tilde = [1 0 0];

%% Batch Algorithm

%STM and State
phi1 = stm(1);
X1_ref = phi1*X0_ref;

%H Matrix
H1 = H_tilde*phi1;

%Observation Deviation
y1 = Y - X1_ref(1);

%Initial State Deviation
x0_hat = inv(H1'*inv(R)*H1 + inv(P0_bar))*(H1'*inv(R)*y1 + inv(P0_bar)*x0_bar);

%Estimated Initial State
X0_hat = X0_ref + x0_hat %%PART A ANSWER%%

%% Sequential Algorithm

%STM and State
phi1 = stm(t);
X1_ref = phi1*X0_ref;

%Observation Deviation
y1 = Y - X1_ref(1);

%A Priori Reference Covariance
P1_bar = phi1*P0_bar*phi1';

%Kalman Gain
K1 = P1_bar*H_tilde'*inv(H_tilde*P1_bar*H_tilde' + R);

%SOMETHING WRONG SOMEWHERE
X1_hat = X1_ref + K1*(y1 - H_tilde*X1_ref);

X0_hat = inv(phi1)*X1_hat

function phi = stm(t)
%STM Computes state transition matrix from 0 to t for the dynamics in HW5
%Problem 1

    phi = [1 t 0.5*t^2;
           0 1 t;
           0 0 1];

end



    
