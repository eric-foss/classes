function U = prim2conv(rho, u, v, T, cv)
%PRIM2CONV Converts primative variables to conservative variables

U(1, :, :) = rho; %density
U(2, :, :) = rho.*u; %mass flux in x
U(3, :, :) = rho.*v; %mass flux in y
U(4, :, :) = rho.*(cv*T + (u.^2 + v.^2)/2); %total energy

end
