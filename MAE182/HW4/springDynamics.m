function xdot = springDynamics(~, X, const)
%SPRINGDYNAMICS Dynamics of the system outlined in HW4 Problem 2

omega = sqrt((const.k1 + const.k2)/const.m);

A = [0 1;
     -(omega^2) 0];

phi = reshape(X(3:6), 2, 2);

xdot = [X(2); -(omega^2)*X(1); reshape(A*phi, 4, 1)];

end

