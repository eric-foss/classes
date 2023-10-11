%% MAE144 HW1 Problem 2
clear all; close all; clc;

%% Part A


f = RR_poly([-6 -6 -3 -3 -1 -1], 1);

a = RR_poly([-6 -3 -1 1 3 6], 1);

b = RR_poly([-5 -2 2 5], 1);

[x, y] = RR_diophantine(a, b, f);

G = RR_tf(b, a);

D = RR_tf(y, x);

T = (G*D)/(1 + G*D);

test = trim(a*x + b*y);

%% Part B






