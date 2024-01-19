function [r, v] = kep2rv(koe, mu)

a = koe(1);
ec = koe(2);
i = koe(3);
omega = koe(4);
w = koe(5);
M = koe(6);

nhat = [cos(omega); sin(omega); 0];
hhat = [sin(i)*sin(omega); -sin(i)*cos(omega); cos(i)];
rT = [-cos(i)*sin(omega); cos(i)*cos(omega); sin(i)];


j = 1;
E(j) = M;
f(j) = M - E(j) + ec*sin(E(j));
while (abs(f(j)) > 10^(-12))
    
    
    E(j+1) = E(j) + f(j)/(1 - ec*cos(E(j)));
    j = j + 1;
    f(j) = M - E(j) + ec*sin(E(j));
   
end
E = E(j);
f = 2*atan(sqrt((1 + ec)/(1 - ec))*tan(E/2));

r_mag = a*(1 - ec^2)/(1 + ec*cos(f));
v_mag = sqrt(mu*(2 - r_mag/a)/r_mag);

gamma = atan2(ec*sin(f), 1 + ec*cos(f));

u = w + f;
rhat = cos(u)*nhat + sin(u)*rT;
vhat = sin(gamma - u)*nhat + cos(gamma - u)*rT;

r = r_mag*rhat;
v = v_mag*vhat;

end