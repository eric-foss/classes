function [r, v] = kep2rv(koe, mu)

%Define Keplerian Elements
a = koe(1); %semi-major axis [km]
ec = koe(2); %eccentricity
i = koe(3); %inclination [rads]
omega = koe(4); %longitude of ascending node [rads]
w = koe(5); %arguement of periapsis [rads]
M = koe(6); %mean anomoly [rads]

nhat = [cos(omega); sin(omega); 0];
hhat = [sin(i)*sin(omega); -sin(i)*cos(omega); cos(i)];
rT = [-cos(i)*sin(omega); cos(i)*cos(omega); sin(i)]; 

%Newton's Method to find eccentric anomoly
j = 1;
E(j) = M;
f(j) = M - E(j) + ec*sin(E(j));
while (abs(f(j)) > 10^(-12))
    
    
    E(j+1) = E(j) + f(j)/(1 - ec*cos(E(j)));
    j = j + 1;
    f(j) = M - E(j) + ec*sin(E(j));
   
end
E = E(j); %eccentric anomoly [rads]
f = 2*atan(sqrt((1 + ec)/(1 - ec))*tan(E/2)); %true anomoly [rads]

r_mag = a*(1 - ec^2)/(1 + ec*cos(f)); %position magnitude [km]
v_mag = sqrt(mu*(2 - r_mag/a)/r_mag); %velocity magnitude [km/s]

gamma = atan2(ec*sin(f), 1 + ec*cos(f));

u = w + f;
rhat = cos(u)*nhat + sin(u)*rT; %position unit vector
vhat = sin(gamma - u)*nhat + cos(gamma - u)*rT; %velocity unit vector

r = r_mag*rhat; %position vector [km]
v = v_mag*vhat; %velocity vector [km/s]

end