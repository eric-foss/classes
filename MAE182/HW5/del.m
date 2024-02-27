
clear; clc;

X0_bar = [2; 3];
P0_bar = [1 0;
          0 1];
R = [1 0;
     0 2];

Y = [3; 2];

Phi = [1 1;
       0 1];

H = [0 1/2;
     1 1/2];

X1_bar = Phi*X0_bar

y1 = Y - X1_bar;

P1_bar = Phi*P0_bar*Phi'

K1 = P1_bar*H'*inv(H*P1_bar*H' + R)

temp = [5/4 3/4;
        3/4 21/4];

x1_hat = X0_bar + K1*(y1 - H*X0_bar)
