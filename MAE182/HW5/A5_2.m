%% MAE 182 Assignment 5 Problem 2
% Eric  Foss
% A17068006
clear; close all; clc;


delta = 1e-6;

y = [3; 2];

H = [1 delta;
     1     1];

X0_ref = [4; 7];

P0 = [1/delta^2         0;
      0         1/delta^2];

R = eye(2);


%% Part A

beta = 1 - 2*delta + 2*(2+delta^2)*delta^2;

mat = [1 + 2*delta^2  -(1+delta);
       -(1 + delta)    2+delta^2];
P2_exact = mat/beta %%PART A ANSWER%%

%% Part B

mat = [-1   1;
        1  -1];
P2_kalman = mat/(1-2*delta) %%PART B ANSWER%%

%% Part C

P2_joseph = [  1 + 2*delta   -(1+3*delta);
             -(1 + 3*delta)   (2 + delta)]; %%PART C ANSWER%%


%% Part D

P2_batch = [ 1 + 2*delta   -(1 + 3*delta);
            -(1 + 3*delta)  2*(1+2*delta)];
