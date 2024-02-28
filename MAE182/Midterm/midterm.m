%%MAE 182 Midterm
% Eric Foss
%A17068006

rs1 = [-5127510; -3794160;       0]; %Station 101 Cords in ECEF
rs2 = [ 3860910;  3238490; 3898094]; %Station 337 Cords in ECEF
rs3 = [  549505; -1380872; 6182197]; %Station 394 Cords in ECEF

r = [757700; 5222607; 4851500]; %initial position ECI [m]
v = [2213.21; 4678.34; -5371.30]; %initial velocity ECI [m/s]

% const.thetadot = 7.2921158553e-5; %Earth Rotation Rate [rad/s]
% const.Re = 6378136.3; %Radius of Earth [m]
% const.A = 3; %Cross-section area of Satellite [m^2]
% const.m = 970; %Mass of Satellite [kg]
% const.rho0 = 3.614e-13; %Reference atmospheric density [kg/m^2]
% const.r0 = 700000 + const.Re; %Reference atmospheric model altitude [m]
% const.H = 88667; %dude idk [m]


syms x y z u v w mu J2 Cd xs1 ys1 zs1 xs2 ys2 zs2 xs3 ys3 zs3

syms t theta thetadot Re A m rho0 r0 H
const.Re = Re;
const.thetadot = thetadot;
const.theta = theta;
const.A = A;
const.m = m;
const.rho0 = rho0;
const.r0 = r0;
const.H = H;

X = [x; y; z; u; v; w; mu; J2; Cd; xs1; ys1; zs1; xs2; ys2; zs2; xs3; ys3; zs3];

Xdot = Dynamics(t, X, const);



rho1 = sqrt(x^2 + y^2 + z^2 + xs1^2 + ys1^2 + zs1^2 - 2*(x*xs1 + y*ys1)*cos(theta) + 2*(x*ys1 - y*xs1)*sin(theta) - 2*z*zs1);

