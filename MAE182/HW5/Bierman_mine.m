function [P2_exact, P2_kalman, X2_kalman, P2_joseph, X2_joseph, P2_batch, X2_batch] = Bierman(d)
%BIERMAN Function that produces the P2 matrix of Bierman's Example

P1 = [1/(d^2)       0;
      0       1/(d^2)];

H1 = [1 d];
H2 = [1 1];
H = [H1; H2];

X0 = [4; 7];

y1 = 3;
y2 = 2;

R = 1;