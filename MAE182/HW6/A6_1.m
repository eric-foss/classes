%% MAE182 Assignment 6 Problem 1
% Eric Foss
% A17068006
clear; close all; clc;

%% System Parameters
A = [ 5  0  3  0  1;
      3  0  0 -2  0;
      0 -2  4  1  0;
      1  3 -4  1  3;
      0  2  2  0 -1];

B = [ 0  1;
      0  2;
      0  0;
      1  3;
      1  1];


C = [ 0  0  1  0  0];

D = 0;

%non-trivial initial state
x0 = [1; 2; 3; 4; 5];

%Dynamics
time = [0 10];
xdot = @(x, A, B, K) (A - B*K)*x;

%% Open Loop %%%%%%%%%%%%%%

Kol = zeros(2, 5);
sys = ss(A, B, C, D);

[tol, xol] = ode45(@(t, x) xdot(x, A, B, Kol), time, x0, odeset('RelTol',1e-12,'AbsTol',1e-15));

uol = zeros(height(tol), 2);
for i = 1:height(tol)    
    uol(i, :) = -Kol*xol(i, :)';
end

figure(2); hold on;
pzmap(sys);

figure(3); hold on;
plot(tol, xol(:, 1), '-g');
plot(tol, xol(:, 2), '-b');
plot(tol, xol(:, 3), '-k');
plot(tol, xol(:, 4), '-c');
plot(tol, xol(:, 5), '-r');
legend('x1', 'x2', 'x3', 'x4', 'x5');
title('State Response');

figure(4); hold on;
plot(tol, uol(:, 1), '-g');
plot(tol, uol(:, 2), '-r');
legend('u1', 'u2');
title('Control Response');


%% LQR Functions %%%%%%%%%%%%%%%%%%%%%%%%%%%%
syms g a b;

R(a, b) = [a 0;
           0 b];

Q(g) = [ 0  0  0  0  0;
         0  0  0  0  0;
         0  0  g  0  0;
         0  0  0  0  0;
         0  0  0  0  0];

%% CASE 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%

R1 = double(R(0.1, 0.1));
Q1 = double(Q(3));

[K1, ~, eig1] = lqr(sys, Q1, R1);
sys1 = ss(A - B*K1, B, C, D);

[t1, x1] = ode45(@(t, x) xdot(x, A, B, K1), time, x0, odeset('RelTol',1e-12,'AbsTol',1e-15));

u1 = zeros(height(t1), 2);
for i = 1:height(t1)
    
    u1(i, :) = -K1*x1(i, :)';

end

figure(5); hold on;
pzmap(sys1);

figure(6); hold on;
plot(t1, x1(:, 1), '-g');
plot(t1, x1(:, 2), '-b');
plot(t1, x1(:, 3), '-k');
plot(t1, x1(:, 4), '-c');
plot(t1, x1(:, 5), '-r');
legend('x1', 'x2', 'x3', 'x4', 'x5');
title('State Response');

figure(7); hold on;
plot(t1, u1(:, 1), '-g');
plot(t1, u1(:, 2), '-r');
legend('u1', 'u2');
title('Control Response');

%% CASE 2 %%%%%%%%%%%%%

R2 = double(R(1e-10, 1e-10));
Q2 = Q1;
[K2, ~, eig2] = lqr(sys, Q2, R2);
sys2 = ss(A - B*K2, B, C, D);

[t2, x2] = ode45(@(t, x) xdot(x, A, B, K2), time, x0, odeset('RelTol',1e-12,'AbsTol',1e-15));

u2 = zeros(height(t2), 2);
for i = 1:height(t2)
    
    u2(i, :) = -K2*x2(i, :)';

end

figure(8); hold on;
pzmap(sys2);

figure(9); hold on;
plot(t2, x2(:, 1), '-g');
plot(t2, x2(:, 2), '-b');
plot(t2, x2(:, 3), '-k');
plot(t2, x2(:, 4), '-c');
plot(t2, x2(:, 5), '-r');
legend('x1', 'x2', 'x3', 'x4', 'x5');
title('State Response');

figure(10); hold on;
plot(t2, u2(:, 1), '-g');
plot(t2, u2(:, 2), '-r');
legend('u1', 'u2');
title('Control Response');

%% CASE 3 %%%%%%%%%%%%%%%%

R3 = double(R(1e-10, 0.1));
Q3 = Q1;
[K3, ~, eig3] = lqr(sys, Q3, R3);
sys3 = ss(A - B*K3, B, C, D);

[t3, x3] = ode45(@(t, x) xdot(x, A, B, K3), time, x0, odeset('RelTol',1e-12,'AbsTol',1e-15));

u3 = zeros(height(t3), 2);
for i = 1:height(t3)
    
    u3(i, :) = -K3*x3(i, :)';

end

figure(11); hold on;
pzmap(sys3);

figure(12); hold on;
plot(t3, x3(:, 1), '-g');
plot(t3, x3(:, 2), '-b');
plot(t3, x3(:, 3), '-k');
plot(t3, x3(:, 4), '-c');
plot(t3, x3(:, 5), '-r');
legend('x1', 'x2', 'x3', 'x4', 'x5');
title('State Response');

figure(13); hold on;
plot(t3, u3(:, 1), '-g');
plot(t3, u3(:, 2), '-r');
legend('u1', 'u2');
title('Control Response');