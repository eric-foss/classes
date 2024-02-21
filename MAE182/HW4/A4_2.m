%% MAE182 Assignment 4 Problem 2
% Eric Foss
% A17068006
clear; close all; clc;

%System Constants
const.k1 = 2.5; %spring 1 constant [N/m]
const.k2 = 3.7; %spring 2 constant [N/m]
const.m = 1.5; %mass [kg]
const.h = 5.4; %height of observation [m]


%Initial State
phi0 = eye(2);
X0_ref = [4; 0.2; reshape(phi0, 4, 1)];

%Weighting Matrix
R = [0.0625 0;
     0 0.01];

%A Priori
x0_bar = [0; 0];
P0_bar = [1000 0;
          0 100;];

t = 0:10;
Y = [6.37687486186585, -0.00317546143535849;
     5.50318198665912,  1.17587430814596;
     5.94513302809067, -1.47058865193489;
     6.30210798411686,  0.489030779000695;
     5.19084347133671,  0.993054430595876;
     6.31368240334678, -1.40470245576321;
     5.80399842220377,  0.939807575607138;
     5.45115048359871,  0.425908088320457;
     5.91089305965839, -1.47604467619908;
     5.67697312013520,  1.42173765213734;
     5.25263404969825, -0.12082311844776];  

%BATCH FILTER
itr = 4; %number of filter iterations
Lambda = inv(P0_bar);
N = Lambda*x0_bar;


for j = 1:itr

    [~, X_ref] = ode45(@springDynamics, t, X0_ref, odeset('RelTol',1e-12,'AbsTol',1e-15), const); %propagate
    phi = reshape(X_ref(:, 3:end)', 2, 2, 11);
    X_ref = reshape(X_ref(:, 1:2)', 2, 11);

    H_tilde = zeros(2, 2, 11);
    H = zeros(2, 2, 11);
    rho = zeros(11, 1);
    y = zeros(2, 11);

    for i = 1:11
        
        rho(i) = sqrt(X_ref(1, i)^2 + const.h^2);

        H_tilde(:, :, i) = [X_ref(1, i)/rho(i), 0;
                   (X_ref(2, i)/rho(i))*(1 - (X_ref(1, i)/rho(i))^2), X_ref(1, i)/rho(i)];
        
        y(:, i) = Y(i, :)' - [rho(i); X_ref(1, i)*X_ref(2, i)/rho(i)];

        H(:, :, i) = H_tilde(:, :, i)*phi(:, :, i);

        Lambda = Lambda + H(:, :, i)'*inv(R)*H(:, :, i);
        N = N + H(:, :, i)'*inv(R)*y(:, i);

    end

    x0_hat = inv(Lambda)*N;
    P0 = inv(Lambda);

    X0_ref = [X0_ref(1:2) + x0_hat; X0_ref(3:end)];
    x0_bar = x0_bar - x0_hat;
    Lambda = inv(P0_bar);
    N = Lambda*x0_bar;
end


