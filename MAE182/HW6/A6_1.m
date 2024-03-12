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


%% CASE 1 %%%%%%%%%%%

R1 = R(0.1, 0.1);
Q1 = Q(3);
[K, S, eig] = lqr(sys, Q1, R1);

pzmap(eig);

t = [0 10];
[~, x] = ode45(@dynamics1, t, x0, odeset('RelTol',1e-12,'AbsTol',1e-15));



function xdot = dynamics1(~, x)

xdot = (A - B*K1)*x;

end


