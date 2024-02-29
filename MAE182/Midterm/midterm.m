%%MAE 182 Midterm
% Eric Foss
%A17068006
symA;
clear; close all; clc;

%%%%Constant Parameters%%%%
const.thetadot = 7.2921158553e-5; %Earth Rotation Rate [rad/s]
const.Re = 6378136.3; %Radius of Earth [m]
const.S = 3; %Cross-section area of Satellite [m^2]
const.m = 970; %Mass of Satellite [kg]
const.rho0 = 3.614e-13; %Reference atmospheric density [kg/m^2]
const.r0 = 700000 + const.Re; %Reference atmospheric model altitude [m]
const.H = 88667; %dude idk [m]

%%%%Initial State%%%%
r0 = [757700; 5222607; 4851500]; %initial position ECI [m]
v0 = [2213.21; 4678.34; -5371.30]; %initial velocity ECI [m/s]

mu0 = 3.986004415e14; %Approximate gravitational parameter [m^3/s^2]
J20 = 1.082626925638815e-3; %Approximate J2 pertubation term
Cd0 = 2; %Approximate satellite coefficent of drag

rs1 = [-5127510; -3794160;       0]; %Station 101 Cords in ECEF
rs2 = [ 3860910;  3238490; 3898094]; %Station 337 Cords in ECEF
rs3 = [  549505; -1380872; 6182197]; %Station 394 Cords in ECEF

phi0 = eye(9);

X0 = [r0; v0; mu0; J20; Cd0; rs1; rs2; rs3; reshape(phi0, 81, 1)];

%% Problem 1

A0 = findA(X0(1), X0(2), X0(3), X0(4), X0(5), X0(6), X0(7), X0(8), X0(9), const.S, const.H, const.Re, const.m, const.r0, const.rho0, const.thetadot);

H_tilde0 = computeHTilde(0, X0, 337, const);

test = A0(1:9, 1:9);

syms t;

%dynamics(t, X0, const);


%% Problem 2
time = 0:20:18340;
[t, X] = ode45(@dynamics, time, X0, odeset('RelTol',1e-12,'AbsTol',1e-15), const);

%State Variables
r = X(:, 1:3);
v = X(:, 4:6);
mu = X(:, 7);
J2 = X(:, 8);
Cd = X(:, 9);

%STMs
phi = zeros(918, 18, 18);
for i = 1:918
    phi(i, 1:9, 1:9) = reshape(X(i, 19:end), 9, 9);
    phi(i, 10:end, 10:end) = eye(9);
end

rvf = [r(end), v(end)]; %%PROBLEM 2 ANS%%
phif = squeeze(phi(end, :, :)); %%PROBLEM 2 ANS%%

%% Problem 3
%TBC