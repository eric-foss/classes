%%MAE185 Assignment 4 Problem 3
% Eric Foss
% A17068006
clear; close all; clc;

load('gotritons_uv.mat');
dx = (xx(end, 1) - xx(1, 1))/length(xx); %x mesh step
dy = (yy(1, end) - yy(1, 1))/width(yy); %y mesh step
d = 0.0005; %diffusion constant 
SF = 1.2; %time step safety factor
