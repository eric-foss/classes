function xdot = flatearthdynamics(t, X, const)
%FLATEARTHDYNAMICS Dynamics of 1D flat earth outlined in Hw5 problem 1

A = [0 1 t;
     0 0 1;
     0 0 0];

phi = reshape(X(4:12), 3, 3);

xdot = []