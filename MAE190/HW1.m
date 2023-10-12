%% Problem 5

a = 6378137/1000;

phia = 32.867 * pi/180;
lama = -117.257 * pi/180;

phib = 21.43 * pi/180;
lamb = -157.63 * pi/180;

d = a*acos(sin(phia)*sin(phib) + cos(phia)*cos(phib)*cos(lamb - lama));


