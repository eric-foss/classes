function xdot = dev_stm(~, X)
%DEV_STM Dynamics for 2D Two Body Problem Deviation and State Transition Matrix
%
x = X(1);
y = X(2);
r = norm(X(1:2));

dxdd_dx = (3*x^2)/(r^5) - 1/(r^3);
dxdd_dy = (3*x*y)/(r^5);
dydd_dx = (3*x*y)/(r^5);
dydd_dy = (3*y^2)/(r^5) - 1/(r^3);

A = [0 0 1 0;
     0 0 0 1;
     dxdd_dx dxdd_dy 0 0;
     dydd_dx dydd_dy 0 0];

phi = reshape(X(5:20), 4, 4);

xdot = [X(3); X(4); -x/r^3; -y/r^3; reshape(A*phi, 16, 1)];

end

