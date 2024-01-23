%% MAE 182 Assignment 2 Problem 1
% Eric Foss
% A17068006

%% Part A

X0_p = [1.5; 10.0; 2.2; 0.5; 0.3]; %perturbed initial conditions

rho_o = [7.0; 8.00390597; 8.94427191; 9.801147892; 10.30145813]; %range observations

Xs = 1.0; Ys = Xs; %known station coordinates


%Newton-Raphson Method: Finding true initial condition
X0 = X0_p;


error = 1;

while error > 10^(-12)

    for t = 0:4
        G(t+1) = dist(X0, t, Xs, Ys);
        J(t+1, 1) = (X0(1) - Xs + X0(3)*t)/G(t+1);
        J(t+1, 2) = (X0(2) - Ys + X0(4)*t - X0(5)*t^2/2)/G(t+1);
        

    end


end



function rho = dist(X, t, Xs, Ys)

rho = sqrt((X(1) - Xs + X(3)*t)^2 + (X(2) - Ys + X(4)*t - X(5)*(t^2)/2)^2);

end