function H_tilde = computeHTilde(t, X, station, const)
%COMPUTEHTILDA Summary of this function goes here
%   Detailed explanation goes here

syms x y z u v w mu J2 Cd xs1 ys1 zs1 xs2 ys2 zs2 xs3 ys3 zs3

X_sym = [x; y; z; u; v; w; mu; J2; Cd; xs1; ys1; zs1; xs2; ys2; zs2; xs3; ys3; zs3];

syms theta Re S m rho0 r0 H thetadot


% theta = t*const.thetadot;

switch station
    case 101
        rho = sqrt(x^2 + y^2 + z^2 + xs1^2 + ys1^2 + zs1^2 - 2*(x*xs1 + y*ys1)*cos(theta) + 2*(x*ys1 - y*xs1)*sin(theta) - 2*z*zs1);
        rhodot = (x*u + y*v + z*w - (u*xs1 + v*ys1)*cos(theta) + thetadot*(x*xs1 + y*ys1)*sin(theta) + (u*ys1 - v*xs1)*sin(theta) + thetadot*(x*ys1 - y*xs1)*cos(theta) - w*zs1)/rho;
        
        H = [rho; rhodot];
        H_tilde = matlabFunction(jacobian(H, X_sym), "Vars", [x y z u v w xs1 ys1 zs1 theta thetadot]);

        theta = t*const.thetadot;
        H_tilde = H_tilde(X(1), X(2), X(3), X(4), X(5), X(6), X(10), X(11), X(12), theta, const.thetadot);

    case 337
        rho = sqrt(x^2 + y^2 + z^2 + xs2^2 + ys2^2 + zs2^2 - 2*(x*xs2 + y*ys2)*cos(theta) + 2*(x*ys2 - y*xs2)*sin(theta) - 2*z*zs2);
        rhodot = (x*u + y*v + z*w - (u*xs2 + v*ys2)*cos(theta) + thetadot*(x*xs2 + y*ys2)*sin(theta) + (u*ys2 - v*xs2)*sin(theta) + thetadot*(x*ys2 - y*xs2)*cos(theta) - w*zs2)/rho;

        H = [rho; rhodot];
        H_tilde = matlabFunction(jacobian(H, X_sym), "Vars", [x y z u v w xs2 ys2 zs2 theta thetadot]);
        
        theta = t*const.thetadot;
        H_tilde = H_tilde(X(1), X(2), X(3), X(4), X(5), X(6), X(13), X(14), X(15), theta, const.thetadot);

    case 394
        rho = sqrt(x^2 + y^2 + z^2 + xs3^2 + ys3^2 + zs3^2 - 2*(x*xs3 + y*ys3)*cos(theta) + 2*(x*ys3 - y*xs3)*sin(theta) - 2*z*zs3);
        rhodot = (x*u + y*v + z*w - (u*xs3 + v*ys3)*cos(theta) + thetadot*(x*xs3 + y*ys3)*sin(theta) + (u*ys3 - v*xs3)*sin(theta) + thetadot*(x*ys3 - y*xs3)*cos(theta) - w*zs3)/rho;

        H = [rho; rhodot];
        H_tilde = matlabFunction(jacobian(H, X_sym), "Vars", [x y z u v w xs3 ys3 zs3 theta thetadot]);

        theta = t*const.thetadot;
        H_tilde = H_tilde(X(1), X(2), X(3), X(4), X(5), X(6), X(16), X(17), X(18), theta, const.thetadot);
end


end

