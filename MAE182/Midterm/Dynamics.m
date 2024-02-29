function Xdot = dynamics(~, X, const)
%DYNAMICS Summary of this function goes here
%   Detailed explanation goes here

x = X(1);
y = X(2);
z = X(3);
u = X(4);
v = X(5);
w = X(6);
mu = X(7);
J2 = X(8);
Cd = X(9);

r = norm(X(1:3));

%Gravity with J2
k = J2*mu*const.Re^2;
a_g = [-(2*mu*x*r^4 - 15*k*x*z^2 + 3*k*x*r^2)/(2*r^7);
       -(2*mu*y*r^4 - 15*k*y*z^2 + 3*k*y*r^2)/(2*r^7);
       -(2*mu*z*r^4 - 15*k*z^3   + 9*k*z*r^2)/(2*r^7)];


%Drag
vA = [u + const.thetadot*y;
      v - const.thetadot*x;
                         w];

rho = const.rho0*exp((const.r0-r)/const.H);

a_drag = -0.5*Cd*(const.S/const.m)*rho*norm(vA)*vA;

rddot = a_g + a_drag;

%%STM
phi = reshape(X(19:end), 9, 9);
A = findA(X(1), X(2), X(3), X(4), X(5), X(6), X(7), X(8), X(9), const.S, const.H, const.Re, const.m, const.r0, const.rho0, const.thetadot);

phidot = A(1:9, 1:9)*phi;

xdot = A*X(1:18);

Xdot = [X(4:6); rddot; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; reshape(phidot, 81, 1)];

end

