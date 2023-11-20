clear all; close all; clc;

%% Problem 1

a0 = 0.1;
b0 = a0;
d = 6;

G = tf([b0], [1 a0], 'InputDelay', 6);

Gpade = pade(G, 2);

bode(G);

%% Problem 4a

%rlocus(Gpade);
Ku = 3.3;
omegau = 0.317;

alpha = 0.05;
beta = 0.5;
gamma = 0.125;

Kp = alpha*Ku;
Ti = beta*(1/omegau);
Td = gamma*(1/omegau);

C = Kp*Td*tf([1, 1/Td, 1/(Ti*Td)], [1, 0]);


T = C*Gpade/(1+C*Gpade);


pzmap(T);


%% Problem 4b



