function [rho,u,v,T,P,e,Et] = cons2prim(U,R,cv)
%CONS2PRIM Converts conservative variables into primative variables

rho = squeeze(U(1, :, :)); %density
u = squeeze(U(2, :, :))./rho; %velocity in x
v = squeeze(U(3, :, :))./rho; %velocity in y
Et = squeeze(U(4, :, :)); %total energy
e = Et./rho - (u.^2 + v.^2)/2; %specific energy
T = e/cv; %temperature
P = rho.*T*R; %pressure

end %function

