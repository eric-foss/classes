%% MAE 182 Final Project
% Eric Foss
% A17068006

%% Generate Matlab Functions
symA;
symH_tilde;
clear; close all; clc;

%% Project Parameters %%%%%%%%%%%%%%%%%%%%%%%%

%Constant Parameters
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

phi0 = eye(9); %Initial STM (only top left quad)

X0 = [r0; v0; mu0; J20; Cd0; rs1; rs2; rs3; reshape(phi0, 81, 1)]; %Initial State Vector

%% Batch Filter %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Initial Reference State
X0_ref = X0;

%A Priori
x0_bar = zeros(18, 1);
P0_bar = diag([1e6, 1e6, 1e6, 1e6, 1e6, 1e6, 1e20, 1e6, 1e6, 1e-10, 1e-10, 1e-10, 1e6, 1e6, 1e6, 1e6, 1e6, 1e6]);

%Weighting Matrix
R = [0.01^2 0;
     0 0.0001^2];

%Observation Data
Y = readmatrix('exam_obs_data.txt');
n = height(Y); %Number of observations  

%Batch Filter Initializations
itr = 3; 
Lambda = inv(P0_bar);
N = P0_bar\x0_bar;
time = 0:20:18340;

for j = 1:itr

    %Propagate Initial Reference State and STM
    [t_ref, X] = ode45(@dynamics, time, X0_ref, odeset('RelTol',1e-12,'AbsTol',1e-15), const);
    
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

    %Preallocations
    H_tilde = zeros(height(Y), 2, 18);
    H = zeros(height(Y), 2, 18);
    G = zeros(height(Y), 2);
    y = zeros(height(Y), 2);


    %Observation Loop
    for i = 1:n

        t = Y(i, 1); %Time passed since epoch
        station = Y(i, 2); %Corresponding station number
        [H_tilde(i, :, :), G(i, :)] = computeH_tilde(t, X(1 + t/20, :), station, const); %H_tilde matrix and range/range rate
        
        y(i, :) = Y(i, 3:4) - G(i, :);

        H(i, :, :) = squeeze(H_tilde(i, :, :))*squeeze(phi(1 + t/20, :, :));

        Lambda = Lambda + squeeze(H(i, :, :))' * (R\squeeze(H(i, :, :)));
        N = N + squeeze(H(i, :, :))' * (R\y(i, :)');

    end 

    %Plots
    figure(1);
    subplot(itr, 2, j*2 - 1);
    plot(1:n, y(:, 1)); %Range residuals plot
    title('Range Residuals');
    xlabel('Observation Number'); ylabel('Range Residual [m]');
    xlim([0 n]);
    
    subplot(itr, 2, j*2);
    plot(1:n, y(:, 2)); %Range-rate residual plot
    title('Range-rate Residuals');
    xlabel('Observation Number'); ylabel('Range-rate Residual [m/s]');
    xlim([0 n]);

    x0_hat = Lambda\N;
    P0 = inv(Lambda);

    %Update
    X0_ref = [X0_ref(1:18) + x0_hat; X0_ref(19:end)];
    x0_bar = x0_bar - x0_hat;
    Lambda = inv(P0_bar);
    N = P0_bar\x0_bar;


end

