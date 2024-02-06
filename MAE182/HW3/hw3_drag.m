%-------------------------------------------------------------------------%
%    hw3_Drag.m
%
%  DESCRIPTION: This file numerically integrates the (two-body dynamic) EOM
%  using ODE45 (4th order Runge-Kutta).  The ECI position and velocity
%  vectors are propagated at 20s intervals for 2 periods.   
%
%  FUNCTIONS CALLED:
%     dynamics_2BP_J2_Drag
%     
%  MODIFICATIONS:
%     1-25-2024   |   Aaron J. Rosengren - Original
%
%  MAE 182 - Winter 2024
%-------------------------------------------------------------------------%
clearvars; close all; clc

%  Planetary constants
const.mu = 3.986004e14;   % Earth gravitational parameter, m^3/s^2
const.Re = 6378145;       % Earth radius, m
const.J2 = 0.00108248;    % Earth oblateness

%  Conversions
r2d = 180/pi;       % radians to degrees 

%  ECI position and velocity at initial epoch
r0_ECI = [ -2436.45 ; -2436.45 ; 6891.037 ]*1e3;   % m
v0_ECI = [ 5.088611 ; -5.088611 ; 0 ]*1e3;          % m/s

%  Initial state vector
x0 = [r0_ECI; v0_ECI];

%  Initial energy
r0 = norm(r0_ECI);
v0 = norm(v0_ECI);
U0 = (const.mu/r0)*(1 - const.J2*(const.Re/r0)^2*(3/2*(r0_ECI(3)/r0)^2 - 1/2));
energy0 = v0^2/2 - U0;

%  Period of orbit
a0 = -const.mu/(2*energy0);    % semi-major axis, m
P = 2*pi*sqrt(a0^3/const.mu);  % s

% --------------------------------------- %
%     Numerically integrated solution     %
% --------------------------------------- %
tol = 1e-13;            % tolerance 
options = odeset('RelTol', tol, 'AbsTol', tol*ones(1,6));

%  ode45 matlab integrator
time = 0:20:2*P;
[ t , x ] = ode45( @dynamics_2BP_J2_Drag , time , x0 , options , const );
r_ECI = x(:,1:3);   % m
v_ECI = x(:,4:6);   % m/s

r = zeros(length(time), 1);
v = zeros(length(time), 1);
U = zeros(length(time), 1);
energy = zeros(length(time), 1);
dTE = zeros(length(time), 1);
for k = 1:length(time)
    
    %  position, velocity, acceleration magnitudes
    r(k) = norm(r_ECI(k,:));
    v(k) = norm(v_ECI(k,:));
        
    %  Potential function
    U(k) = (const.mu/r(k))*(1 - const.J2*(const.Re/r(k))^2*(3/2*(r_ECI(k,3)/r(k))^2 - 1/2));
    
    %  Energy and angular momentum
    energy(k) = v(k)^2/2 - U(k);
    dTE(k) = energy(k) - energy0;
    
end

hFig = figure(1);
    plot( time, dTE )
    hXLabel = xlabel( 'time (s)' );
    hYLabel = ylabel( '\Delta E with drag (km^2/s^2)' );
    set( gca , 'FontName' , 'Helvetica' );
    set( [hXLabel, hYLabel], 'FontName' , 'AvantGarde' );
    set( [hXLabel, hYLabel] , 'FontSize' , 10 );   
    set( gcf, 'PaperPositionMode' , 'auto' ); 
    set( hFig , 'units' , 'inches' , ... 
         'NumberTitle' , 'off' , 'Name' , 'EccVecAMR' );
    pos = get(hFig , 'position');
    set(hFig , 'position' , [pos(1:2),5.5,4] );     
    set( gcf, 'PaperPositionMode' , 'auto' );

    