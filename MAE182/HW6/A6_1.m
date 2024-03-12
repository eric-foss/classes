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

syms gamma a b;

R(a, b) = [ a  0;
            0  b];

Q = gamma;

H(gamma, a, b) = gamma*X(3)^2 + u'*R*u;

