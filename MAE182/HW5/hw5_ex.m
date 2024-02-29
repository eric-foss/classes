function [Xkal, Xjoe, Xpot, Xbat] = hw5_ex(e)

%-------------------------------------------------------------------------%
%    hw5_ex.m
%
%  DESCRIPTION: This function computes the estimate of the state using the
%  various estimators.  
%
%  MODIFICATIONS:
%     22-2-2024   |   Aaron J. Rosengren - Original
%
%  REFERENCES:
%     Tapley et al., Statistical Orbit Determination, 2004
%
%  MAE 182 - Winter 2024
%-------------------------------------------------------------------------%

%  The a priori estimated and true state vectors are: 
X0 = [ 4 ; 7 ];
Xt = [ 3 ; 1 ];

%  The a priori covariance is
P0 = 1 / e^2 * eye(2);

%  Assume that two observations, Y1 and Y2, are made of two constants X1 and X2. 
%  Observations are of the form
H1 = [ 1 e ];
H2 = [ 1 1 ];
H  = [ H1 ; H2 ];

%  Observations have zero mean and unit variance
R  = 1;

Y  = [3; 2];

%  Kalman estimator
K1      = P0 * H1' * inv( H1 * P0 * H1' + R );
P1kal   = ( eye(2) - K1 * H1 ) * P0;
Xkal1   = X0 + K1 * ( Y(1) - H1 * X0 );
K2      = P1kal * H2' * inv( H2 * P1kal * H2' + R );
P2kal   = ( eye(2) - K2 * H2 ) * P1kal;
Xkal    = Xkal1 + K2 * ( Y(2) - H2 * Xkal1 );

%  Joseph formulation
P1joe   = ( eye(2) - K1 * H1 ) * P0 * ( eye(2) - K1 * H1 )' + K1 * R * K1';
Xjoe1   = P1joe * ( H1' * inv( R ) * Y(1) + inv( P0 ) * X0);
K2joe   = P1joe * H2' * inv( H2 * P1joe * H2' + R );
P2joe   = ( eye(2) - K2joe * H2 ) * P1joe * ( eye(2) - K2joe * H2 )' + K2joe * R * K2joe';
Xjoe    = P2joe * ( H2' * inv( R ) * Y(2) + inv( P0 ) * Xjoe1);

%  Potter squart root algorithm
Wbar    = [ sqrt( P0(1,1) ) 0; 0 sqrt( P0(2,2) ) ];
F       = Wbar' * H1';
alpha   = inv( F' * F + R );
gamma   = 1 / ( 1 + sqrt( R * alpha ) );
K1      = alpha * Wbar * F;
Wbar    = Wbar - gamma * K1 * F';
P1pot   = Wbar * Wbar';
Xhat    = X0 + K1 * ( Y(1) - H1 * X0 );

F       = Wbar' * H2';
alpha   = inv( F' * F + R );
gamma   = 1 / ( 1 + sqrt( R * alpha ) );
K2      = alpha * Wbar * F;
Wbar    = Wbar - gamma * K2 * F';
P2pot   = Wbar * Wbar';
Xpot    = Xhat + K2 * ( Y(2) - H2 * Xhat );
      
%  Batch algorithm
Xbat    = inv( H' * H + inv( P0 ) ) * ( H' * Y + inv( P0 ) * X0 );

end % ---- end function