%% Symbolic
syms x y z u v w mu J2 Cd xs1 ys1 zs1 xs2 ys2 zs2 xs3 ys3 zs3

X_sym = [x; y; z; u; v; w; mu; J2; Cd; xs1; ys1; zs1; xs2; ys2; zs2; xs3; ys3; zs3];

syms theta Re S m rho0 r0 H thetadot

%%Gravity with J2 Pertubations
r = [x; y; z]; %symbloic position
rmag = sqrt(x^2 + y^2 + z^2); %position magnitude
U_prime = (mu/rmag)*(1 - J2*(Re/rmag)^2 * ((3/2)*(z/rmag)^2 - 1/2)); %given U' function
a_g = gradient(U_prime, r);

%%Drag due to Atmosphere
vA = [u + thetadot*y;
      v - thetadot*x;
                   w];

rho = rho0*exp((r0-rmag)/H);

a_drag = -0.5*Cd*(S/m)*rho*norm(vA)*vA;

rddot = a_g + a_drag;

Xdot = [u; v; w; rddot; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0];

matlabFunction(jacobian(Xdot, X_sym), "File", "findA", "Vars", [x y z u v w mu J2 Cd S H Re m r0 rho0 thetadot]);

%A = A(X(1), X(2), X(3), X(4), X(5), X(6), X(7), X(8), X(9), const.S, const.H, const.Re, const.m, const.r0, const.rho0, const.thetadot);

