%% MAE144 HW1 Problem 3 Test Script
clear all; close all; clc;

%Define symbolics
syms p1 p2 p3;
syms z1 z2 z3;

%Test script with symbolics
ys_sym = 20*[1 z1]; xs_sym = [1 p1]; h = 0.01; Ds_sym = RR_tf(ys_sym, xs_sym);

%Run function based of symbolic test script
Dz_sym = EAF_C2D_matched(Ds_sym, h);

%Test script with real values
ys = 20*[1 1]; xs = [1 10]; h = 0.01; Ds = RR_tf(ys, xs);

%Run function based of real test script
Dz = EAF_C2D_matched(Ds, h);

%Test result against matlabs built-in functions
Dstest = tf(ys, xs);
Dztest = c2d(Dstest, h, 'matched');

%Test script for properness and critical frequency
ys_1 = RR_poly([z1], 1); xs_1 = RR_poly([p1 p2 p3], 1); h = 0.01; Ds_1 = RR_tf(ys_1, xs_1);
syms omega;

%Run function with symbolic omega
Dz_1 = EAF_C2D_matched(Ds_1, h, omega);

%Run function to retrun semi-proper
Dz_2 = EAF_C2D_matched(Ds_1, h, omega, 1);