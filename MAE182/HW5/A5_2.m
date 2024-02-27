%% MAE 182 Assignment 5 Problem 2
% Eric  Foss
% A17068006
clear; close all; clc;


syms d;

y = [3; 2];

H = [1     d;
     1     1];

X0_ref = [4; 7];

P0 = [1/d^2         0;
      0         1/d^2];

R = eye(2);

d = 1e-6;
delta = zeros(10, 1);
tr_exact = zeros(10, 1);
tr_kalman = zeros(10, 1);
tr_joseph = zeros(10, 1);
tr_batch = zeros(10, 1);

for i = 1:10
    
    %Exact
    mat = [1 + 2*d^2   -(1+d);
            -(1 + d)    2+d^2];
    beta = 1 - 2*d + 2*(2+d^2)*d^2;
    P2_exact = mat/beta; %%PART A ANSWER%%
    tr_exact(i) = trace(P2_exact);
    
    %Kalman
    

end


%% Part A





%% Part B



%% Part C




%% Part D


