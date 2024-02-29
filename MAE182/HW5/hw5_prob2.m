function [ P2exact , P2kal, P2joe, P2pot, P2bat] = hw5_prob2(e)

%-------------------------------------------------------------------------%
%    hw5_prob2.m
%
%  DESCRIPTION: This function computes the covariance matrix P2 associated
%  with the estimate xhat2 for various filters.
%
%  MODIFICATIONS:
%     22-2-2024   |   Aaron J. Rosengren - Original
%
%  REFERENCES:
%     Tapley et al., Statistical Orbit Determination, 2004
%
%  MAE 182 - Winter 2024
%-------------------------------------------------------------------------%

P   = 1 / e^2 * eye(2);
H1  = [ 1 e ];
H2  = [ 1 1 ];
R   = 1;
W   = 1 / R;

%  Exact value using Eq. (4.7.24)
beta    = 1 - 2 * e + 2 * e^2 * ( 2 + e^2 );
P2exact = 1 / beta * [ 1 + 2 * e^2 , -(1 + e) ; -(1 + e) 2 + e^2 ];

%  Conventional Kalman, Eqs. (4.7.11) and (4.7.12)
K1      = P * H1' * inv( H1 * P * H1' + R );
P1kal   = ( eye(2) - K1 * H1 ) * P;
K2      = P1kal * H2' * inv( H2 * P1kal * H2' + R );
P2kal   = ( eye(2) - K2 * H2 ) * P1kal;

%  Joseph formulation, Eq. (4.7.19)
P1joe   = ( eye(2) - K1 * H1 ) * P * ( eye(2) - K1 * H1 )' + K1 * R * K1';
K2joe   = P1joe * H2' * inv( H2 * P1joe * H2' + R );
P2joe   = ( eye(2) - K2joe * H2 ) * P1joe * ( eye(2) - K2joe * H2 )' + K2joe * R * K2joe';

%  Potter square root update, Eqs. (5.7.17) and (5.7.18)
Wbar    = [ sqrt( P(1,1) ) 0; 0 sqrt( P(2,2) ) ];
F       = Wbar' * H1';
alpha   = inv( F' * F + R );
gamma   = 1 / ( 1 + sqrt(R * alpha ) );
K1pot   = alpha * Wbar * F;
Wbar    = Wbar - gamma * K1pot * F';
P1pot   = Wbar * Wbar';

F       = Wbar' * H2';
alpha   = inv( F' * F + R );
gamma   = 1 / ( 1 + sqrt( R * alpha ) );
K2pot   = alpha * Wbar * F;
Wbar    = Wbar - gamma * K2pot * F';
P2pot   = Wbar * Wbar';

%  Batch processor 
P1bat   = inv( H1' * W * H1 + inv( P ) );
P2bat   = inv( H2' * W * H2 + inv( P1bat ) );

end % ---- end function