%% MAE182 Assignment 6 Problem 1
% Eric Foss
% A17068006


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

x0 = [1; 2; 3; 4; 5];

sys = ss(A, B, C, D);

pzmap(sys);

syms g a b;

R(a, b) = [ a  0;
            0  b];

Q(g) = [ 0  0  0  0  0;
         0  0  0  0  0;
         0  0  g  0  0;
         0  0  0  0  0;
         0  0  0  0  0];


%Dynamics
time = [0 10];
xdot = @(x, A, B, K) (A - B*K)*x;


%% CASE 1 %%%%%%%%%%%

R1 = R(0.1, 0.1);
Q1 = Q(3);
[K1, S1, eig1] = lqr(sys, Q1, R1);

[t1, x1] = ode45(@(t, x) xdot(x, A, B, K1), time, x0, odeset('RelTol',1e-12,'AbsTol',1e-15));



figure(2); hold on;
plot(t1, x1(:, 1), '-g');
plot(t1, x1(:, 2), '-b');
plot(t1, x1(:, 3), '-k');
plot(t1, x1(:, 4), '-c');
plot(t1, x1(:, 5), '-r');
legend('x1', 'x2', 'x3', 'x4', 'x5');

%% CASE 2 %%%%%%%%%%%%%

R2 = R(0, 0);
Q2 = Q1;
[K2, ~, eig2] = lqr(sys, Q2, R2);

[t2, x2] = ode45(@(t, x) xdot(x, A, B, K2), time, x0, odeset('RelTol',1e-12,'AbsTol',1e-15));

figure(3); hold on;
plot(t2, x2(:, 1), '-g');
plot(t2, x2(:, 2), '-b');
plot(t2, x2(:, 3), '-k');
plot(t2, x2(:, 4), '-c');
plot(t2, x2(:, 5), '-r');
legend('x1', 'x2', 'x3', 'x4', 'x5');



