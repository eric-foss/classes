%% MAE182 Assignment 1
%   Eric Foss
%   A17068006


%--------------------------------------------------------------------------
%   Problem 1
%--------------------------------------------------------------------------


mu = 398600;                                                                %gravitational parameter for earth [km^3/s^2]
I = [1; 0; 0]; J = [0; 1; 0;]; K = [0; 0; 1];                               %cordinate frame unit vectors

koe = zeros(6, 1);

r = [-2436.45; -2436.45; 6891.037];                                         %initial position [km]
v = [5.088611; -5.088611; 0];                                               %initial velocity [km/s]


h = cross(r, v);                                                            %specific angular momentum [km^2/s]
hhat = h/norm(h);                                                           %normalized specific angular momentum
energy = 0.5*dot(v, v) - mu/norm(r);                                        %specific energy [km^2/s^2]
nhat = cross(K, h)/norm(cross(K, h));                                       %normalized ascending node

f = atan2(dot(hhat, cross(e, r)), dot(e, r));                               %True anomoly [rads]
E = 2*atan(sqrt((1-norm(e))/(1+norm(e)))*tan(f/2));                         %eccentric anomoly [rads]

koe(1) = -mu/(2*energy);                                                    %semi-major axis [km]
koe(2) = norm(cross(v, h)/mu - r/norm(r));                                  %eccentricity
koe(3) = acos(dot([0 0 1],  hhat));                                         %inclination angle [rads]
koe(4) = atan2(nhat(2), nhat(1));                                           %longitude of ascending node [rads]
koe(5) = atan2(dot(hhat, cross(nhat, e)), dot(nhat, e));                    %argument of periapsis [rads]
koe(6) = E - norm(e)*sin(E);                                                %Mean anomoly [rads]



%--------------------------------------------------------------------------
%   Problem 2
%--------------------------------------------------------------------------




