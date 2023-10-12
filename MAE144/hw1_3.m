%% MAE144 HW1 Problem 3
clear all; close all; clc;

%Define symbolics
syms p1 p2 p3;
syms z1 z2 z3;

%Test script
ys = 20*[1 z1]; xs = [1 p1]; h = 0.01; Ds = RR_tf(ys, xs);

%Run function based of test script
Dz = EAF_C2D_matched(Ds, h);

%Test result against matlabs built-in functions
Dstest = tf(20*[1 1], [1 10]);
Dztest = c2d(Dstest, h, 'matched');