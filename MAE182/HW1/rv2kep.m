function [koe] = rv2kep(r, v, mu)

I = [1; 0; 0]; J = [0; 1; 0]; K = [0; 0; 1];
koe = zeros(6, 1);

h = cross(r, v); %specific angular momentum [km^2/s]
hhat = h/norm(h); %normalized specific angular momentum
energy = 0.5*dot(v, v) - mu/norm(r); %specific energy [km^2/s^2]
nhat = cross(K, h)/norm(cross(K, h)); %normalized ascending node
e = cross(v, h)/mu - r/norm(r); %eccentricity vector
f = atan2(dot(hhat, cross(e, r)), dot(e, r)); %True anomoly [rads]
E = 2*atan(sqrt((1-norm(e))/(1+norm(e)))*tan(f/2)); %eccentric anomoly [rads]

koe(1) = -mu/(2*energy); %semi-major axis [km]
koe(2) = norm(e); %eccentricity
koe(3) = acos(dot([0 0 1],  hhat)); %inclination angle [rads]
koe(4) = atan2(nhat(2), nhat(1)); %longitude of ascending node [rads]
koe(5) = atan2(dot(hhat, cross(nhat, e)), dot(nhat, e)); %argument of periapsis [rads]
koe(6) = E - norm(e)*sin(E); %Mean anomoly [rads]

end