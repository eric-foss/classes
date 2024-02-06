function dx = TwoBP_J2_drag(~, x, const)
%2BP_J2_DRAG Dynamics of 2 Body Problem wiht J2 and Atmospheric Drag Model

r = norm(x(1:3));

%GRAVITY
k = const.J2*const.mu*const.Re^2;
a_g = [-(2*const.mu*x(1)*r^4 - 15*k*x(1)*x(3)^2 + 3*k*x(1)*r^2)/(2*r^7);
       -(2*const.mu*x(2)*r^4 - 15*k*x(2)*x(3)^2 + 3*k*x(2)*r^2)/(2*r^7);
       -(2*const.mu*x(3)*r^4 - 15*k*x(3)^3 + 9*k*x(3)*r^2)/(2*r^7)];

% DRAG
Cd = 2.0;
A = 0.0000036; %[km^2]
m = 1350; %[kg]
rho0 = 0.0004; %[kg/km^3]
r0 = 7298.145; %[km]
H = 200.000; %[km]
thetadot = 7.29211585530066e-5; %[rad/s]

vA = [x(4) + thetadot*x(2); 
      x(5) - thetadot*x(1);
      x(6)];

rho = rho0*exp((r0-r)/H);

a_drag = -0.5*Cd*(A/m)*rho*(norm(vA)^2)*vA;

%COMBINED
acc = a_drag + a_g;
dx = [x(4:6); acc];

end

