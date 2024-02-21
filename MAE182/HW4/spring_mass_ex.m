%-------------------------------------------------------------------------%
%    spring_mass_hw
%
%  DESCRIPTION: Solution to the Spring Mass Problem (Example 4.8.2)
%
%  MODIFICATIONS:
%     15-Feb-2024   |   Aaron J. Rosengren - Original
%
%  REFERENCES:
%     B.D. Tapley et al., Statistical Orbit Determination, 2004 
%
%  MAE 182 Spacecraft Guidance & Navigation - Winter 2024
%-------------------------------------------------------------------------%
clearvars; close all; %clc

%  Observation data (Ex. 4.8.2)
%     t          rho                rhodot
Y = [ 0 ,  6.1773780845922 , 0 ;
      1 ,  5.56327661282686 ,  1.31285863495514 ;
      2 ,  5.69420161397342 , -1.54488114381612 ;
      3 ,  6.15294262127432 ,  0.534923988815733 ;
      4 ,  5.46251322092491 ,  0.884698415328368 ;
      5 ,  5.83638064328625 , -1.56123248918054 ;
      6 ,  6.08236452736002 ,  1.00979943157547 ;
      7 ,  5.40737619817037 ,  0.31705117039215 ;
      8 ,  5.97065615746125 , -1.37453070975606 ;
      9 ,  5.97369258835895 ,  1.36768169443236 ;
      10 , 5.40669060248179 , -0.302111588503166 ];
  
%  Observation data (Hw. 4, Prob. 2)
%     t          rho                rhodot
% Y = [ 0 ,  6.37687486186585 , -0.00317546143535849 ;
%       1 ,  5.50318198665912 ,  1.17587430814596 ;
%       2 ,  5.94513302809067 , -1.47058865193489 ;
%       3 ,  6.30210798411686 ,  0.489030779000695 ;
%       4 ,  5.19084347133671 ,  0.993054430595876 ;
%       5 ,  6.31368240334678 , -1.40470245576321 ;
%       6 ,  5.80399842220377 ,  0.939807575607138 ;
%       7 ,  5.45115048359871 ,  0.425908088320457 ;
%       8 ,  5.91089305965839 , -1.47604467619908 ;
%       9 ,  5.67697312013520 ,  1.42173765213734 ;
%       10 , 5.25263404969825 , -0.12082311844776 ] ;  

%  System parameters  
const.k1    = 2.5;                                          % N/m
const.k2    = 3.7;                                          % N/m
const.m     = 1.5;                                          % kg
const.omega = sqrt( ( const.k1 + const.k2 ) / const.m );    % rad/s
const.h     = 5.4;                                          % m

%  Weighting matrix (reflects noise on data)
W           = eye(2);

%  a priori values
Phi0        = reshape( eye(2) , 4 , 1 );
xv0         = [ 4 ; 0.2 ];
X0          = [ xv0 ; Phi0 ];

x0_bar      = [ 0 ; 0 ];
P0_bar      = [ 1000 0 ; 0 100 ];
Lambda      = inv( P0_bar );
N           = Lambda * x0_bar;


% --------------------------------------------- %
%     BATCH PROCESSOR ALGORITHM (Fig. 4.6.1)    %
% --------------------------------------------- %
time = Y(:,1)';
for i = 1:4
    
    %  ode45 matlab integrator
    %    integrade reference trajectory and STM
    tol     = 1e-12;                                        % tolerance 
    options = odeset( 'RelTol' , tol , 'AbsTol' , tol );
    [t, X]  = ode45( @dynamics_spring_mass , time , X0 , options , const );
    X       = reshape( X' , 2 , 3 , 11 );
    
    x       = X(:,1,:);
    Phi     = X(:,2:end,:);
    
    %  Pre=allocate for memory
    H_tilda = zeros( 2 , 2 , 11 );
    H       = zeros( 2 , 2 , 11 );
    y       = zeros( 2 , 11 );
    
    %  Accumulate current observation
    for k = 1:11
        
        rho         = sqrt( x(1,:,k)^2 + const.h^2 );
        
        H_tilda(:,:,k) = [ x(1,:,k) / rho , 0 ; 
                           x(2,:,k) / rho - x(1,:,k)^2 * x(2,:,k) / rho^3 , x(1,:,k) / rho ];
        
        H(:,:,k)    = H_tilda(:,:,k) * Phi(:,:,k);
        
        y(:,k)      = Y(k,2:3)' - [ rho ; x(1,:,k) * x(2,:,k) / rho ];
        
        Lambda      = Lambda + H(:,:,k)' * W * H(:,:,k);
        N           = N + H(:,:,k)' * W * y(:,k);
                       
    end
    
    x0_hat  = Lambda \ N;
    P0      = inv( Lambda );
    
    X0      = [ X0(1:2) + x0_hat ; X0(3:end) ];
    
    x0_bar  = x0_bar - x0_hat;
    Lambda  = inv( P0_bar );
    N       = Lambda * x0_bar;
    
end

%  RMS of measurement noise
%    from avg of square of measurement residuals y
rho_RMS     = sqrt( dot( y(1,:) , y(1,:) ) / 11 );
rhodot_RMS  = sqrt( dot( y(2,:) , y(2,:) ) / 11 );

%  Variance and covariance are given by P0
sigma_x0    = sqrt( P0(1,1) );
sigma_v0    = sqrt( P0(2,2) );
rho_x0v0    = P0(1,2) / ( sigma_x0 * sigma_v0 );

soln        = [ X0(1) , X0(2) , rho_RMS , rhodot_RMS , sigma_x0 , sigma_v0 , rho_x0v0 ];
str         = { 'x0        ' , 'v0        ', 'rho_RMS    ' };
str2        = { 'rhodot_RMS', 'sigma_x0', 'sigma_v0', 'rho_x0v0' };
c           = [ str str2 ; num2cell(soln) ];
disp( ' ' )
disp( '-------------------------------------------------------------------' )
disp( 'Answer after four iterations:' )
fprintf( '%s\t  %4.4f\n' , c{:} )
disp( '-------------------------------------------------------------------' )
disp( ' ' )