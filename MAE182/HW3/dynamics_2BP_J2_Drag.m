function xdot = dynamics_2BP_J2_Drag( ~ , x , const )

r           = norm(x(1:3));

%  Two-body dynamics
a_g_2B      = -const.mu * x(1:3) / r^3;

%  Oblateness effect
a_g_J2      = zeros(3,1);
a_g_J2(1)   = ( const.mu * x(1) / r^3 ) * (3/2) * const.J2 * ( const.Re / r )^2 * ( 5 * ( x(3) / r )^2 - 1 );
a_g_J2(2)   = ( const.mu * x(2) / r^3 ) * (3/2) * const.J2 * ( const.Re / r )^2 * ( 5 * ( x(3) / r )^2 - 1 );
a_g_J2(3)   = ( const.mu * x(3) / r^3 ) * (3/2) * const.J2 * ( const.Re / r )^2 * ( 5 * ( x(3) / r )^2 - 3 );

%  Drag dynamics
Cd          = 2.0;                  % coefficient of drag
A           = 3.6;                  % s/c projected area, m^2
m           = 1350;                 % mass of s/c, kg
rho0        = 4.0e-13;              % kg/m^3
r0          = 7298145.0;            % m
H           = 200000.0;             % m
thetadot    = 7.29211585530066e-5;  % rad/s

rho         = rho0 * exp( -( r - r0 ) / H );
VA          = [ x(4) + thetadot * x(2);
                x(5) - thetadot * x(1);
                x(6) ];
a_drag      = -(1/2) * Cd * (A/m) * rho * norm(VA) * VA;

%  Dynamics (E.O.M.) {vx vy vz ax ay az}
a_tot = a_g_2B + a_g_J2 + a_drag;

xdot = [x(4:6); a_tot];

end






