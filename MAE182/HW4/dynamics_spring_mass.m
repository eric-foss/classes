function Xdot = dynamics_spring_mass( ~ , X , const )

Phi     = reshape( X(3:end) , 2 , 2 );
A       = [ 0 1 ; 
           -const.omega^2 0 ];
Phidot  = A  * Phi;
Phidot  = reshape( Phidot , 4 , 1 );

Xdot    = [ X(2) ; -const.omega^2 * X(1) ; Phidot ];

end