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
X0_hat_A = X0_ref + x0_hat; %%PART A ANSWER%%

%% Sequential Algorithm

%STM and State
phi1 = stm(t);
X1_ref = phi1*X0_ref;
x1_bar = phi1*x0_bar;

%Observation Deviation
y1 = Y - X1_ref(1);

%A Priori Reference Covariance
P1_bar = phi1*P0_bar*phi1';

%Kalman Gain
K1 = P1_bar*H_tilde'*inv(H_tilde*P1_bar*H_tilde' + R);

%State Deviation Estimate
x1_hat = x1_bar + K1*(y1 - H_tilde*x1_bar);

%Map Back To Initital State Deviation
x0_hat = inv(phi1)*x1_hat;

%Estimated Initial State
X0_hat_B = X0_ref + x0_hat; %%PART B ANSWER%%


%%PART C%%

%Estimated t = 1 State
X1_hat_C = X1_ref + x1_hat; %%PART C ANSWER%%

%Map Back to Estimated Initial State
X0_hat_C = inv(phi1)*X1_hat_C; %%PART C ANSWER%%

function phi = stm(t)
%STM Computes state transition matrix from 0 to t for the dynamics in HW5
%Problem 1

    phi = [1 t 0.5*t^2;
           0 1 t;
           0 0 1];

end
