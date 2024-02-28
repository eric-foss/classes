function Xdot = Dynamics(~, X, const)
%DYNAMICS Summary of this function goes here
%   Detailed explanation goes here



%% Symbolic
syms theta

x = X(1);
y = X(2);
z = X(3);
u = X(4);
v = X(5);
w = X(6);
mu = X(7);
J2 = X(8);
Cd = X(9);
xs1 = X(10);
ys1 = X(11);
zs1 = X(12);
xs2 = X(13);
ys2 = X(14);
zs2 = X(15);
xs3 = X(16);
ys3 = X(17);
zs3 = X(18);

theta = const.theta;
Re = const.Re;
A = const.A;
m = const.m;
rho0 = const.rho0;
r0 = const.r0;
H = const.H;
thetadot = const.thetadot;



%%Gravity with J2 Pertubations
r = [x; y; z]; %symbloic position
rmag = sqrt(x^2 + y^2 + z^2); %position magnitude
U_prime(x, y, z, u, v, w, mu, J2, Re) = (mu/rmag)*(1 - J2*(Re/rmag)^2 * ((3/2)*(z/rmag)^2 - 1/2)); %given U' function
a_g = gradient(U_prime, r);


%%Drag due to Atmosphere

vA(x, y, u, v, w, thetadot) = [u + thetadot*y;
                               v - thetadot*x;
                                            w];

rho(x, y, z, rho0, r0, H) = rho0*exp((r0-rmag)/H);

a_drag(x, y, z, u, v, w, rho0, r0, H, Cd, A, m, thetadot) = -0.5*Cd*(A/m)*rho*(norm(vA)^2)*vA;

rddot = a_g + a_drag;

Xdot = [u; v; w; rddot; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0];


end

