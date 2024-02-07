function mu = sutherland(T)
%SUTHERLAND Calculates dynamic viscosity based off of Sunderland's Law for air 

S1 = 110.4; %[K]
mu0 = 1.735e-5; %[N s/m^2]
T0 = 273.15; %[K]

mu = mu0*(T0+S1)*(T/T0).^(3/2)./(T+S1); %dynamic viscosity

end

