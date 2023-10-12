%% MAE144 HW1 Problem 2
clear all; close all; clc;

%% Part A

%Define given polynomials
f = RR_poly([-6 -6 -3 -3 -1 -1], 1);

a = RR_poly([-6 -3 -1 1 3 6], 1);

b = RR_poly([-5 -2 2 5], 1);

%Run diophantine function
[x, y] = RR_diophantine(a, b, f);

%Test to see if a*x + b*y is equal to wanted f(s)
test = trim(a*x + b*y);

%% Part B

%Add poles at s = -20
f1 = RR_poly([-6 -6 -3 -3 -1 -1 -20 -20 -20 -20 -20], 1);

%Run diophantine
[x1, y1] = RR_diophantine(a, b, f1);

%Define transfer function
D1 = RR_tf(y1, x1);

%Test
test1 = trim(a*x1 + b*y1);






