%% MAE 182 Assignment 5 Problem 2
% Eric  Foss
% A17068006
clear; close all; clc;


d = 1e-6;
delta = zeros(10, 1);
tr_exact = zeros(10, 1);
tr_kalman = zeros(10, 1);
tr_kalman_err = zeros(10, 1);
tr_joseph = zeros(10, 1);
tr_joseph_err = zeros(10, 1);
tr_batch = zeros(10, 1);
tr_batch_err = zeros(10, 1);
X_kal = zeros(10, 2);
X_jos = zeros(10, 2);
X_bat = zeros(10, 2);

for i = 1:10
    
    [P2_exact, P2_kalman, X_kalman, P2_joseph, X_joseph, P2_batch, X_batch] = Bierman(d);

    delta(i) = d;
    d = d/10;

    tr_exact(i) = trace(P2_exact);
    tr_kalman(i) = trace(P2_kalman);
    tr_kalman_err(i) = tr_kalman(i) - tr_exact(i);
    tr_joseph(i) = trace(P2_joseph);
    tr_joseph_err(i) = tr_joseph(i) - tr_exact(i);
    tr_batch(i) = trace(P2_batch);
    tr_batch_err(i) = tr_batch(i) - tr_exact(i);
    X_kal(i, :) = X_kalman;
    X_jos(i, :) = X_joseph;
    X_bat(i, :) = X_batch;

end

figure(1);
subplot(3, 1, 1);
loglog(delta, tr_kalman_err);
title('Kalman Error');
subplot(3, 1, 2);
loglog(delta, tr_joseph_err);
title('Joseph Error');
subplot(3, 1, 3);
loglog(delta, tr_batch_err);
title('Batch Error');

