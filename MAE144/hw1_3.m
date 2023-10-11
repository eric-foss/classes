%% MAE144 HW1 Problem 3
clear all; close all; clc;

%Define symbolics
syms p1;
syms z1;

%Test script
ys = 20*[1 1]; xs = [1 10]; h = 0.01; Ds = RR_tf(ys, xs);

%Run function based of test script
Dz = EAF_C2D_matched(Ds, h);

%Test result against matlabs built-in functions
Dstest = tf(ys, xs);
Dztest = c2d(Dstest, h, 'matched');

