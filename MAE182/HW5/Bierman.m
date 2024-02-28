function [P2_exact, P2_kalman, X2_kalman, P2_joseph, X2_joseph, P2_batch, X2_batch] = Bierman(d)
%BIERMAN Function that produces the P2 matrix of Bierman's Example

P0 = [1/(d^2)       0;
      0       1/(d^2)];

H1 = [1 d];
H2 = [1 1];
H = [H1; H2];

X0 = [4; 7];

y1 = 3;
y2 = 2;

R = 1;

%Exact
beta = 1 - 2*d + 2*(2 + d^2)*d^2;
P2_exact = [1 + 2*d^2 -(1 + d);
            -(1 + d)   (2*d^2)]/beta;

%Kalman
K1 = P0*H1'*inv(H1*P0*H1' + R);
X1_kalman = X0 + K1*(y1 - H1*X0);
P1_kalman = (eye(2) - K1*H1)*P0;
K2 = P1_kalman*H2'*inv(H2*P1_kalman*H2' + R);
X2_kalman = X1_kalman + K2*(y2 - H2*X1_kalman);
P2_kalman = (eye(2) - K2*H2)*P1_kalman;

%Joseph
P1_joseph = (eye(2) - K1*H1)*P0*(eye(2) - K1*H1)' + K1*R*K1';
X1_joseph = P1_joseph*(H1'*inv(R)*y1 + inv(P0)*X0);
K2 = P1_joseph*H2'*inv(H2*P1_joseph*H2' + R);
P2_joseph = (eye(2) - K2*H2)*P1_joseph*(eye(2) - K2*H2)' + K2*R*K2';
X2_joseph = P2_joseph*(H2'*inv(R)*y2 + inv(P0)*X1_joseph);

% Batch
P1_batch = inv(H1'*inv(R)*H1 + inv(P0));
P2_batch = inv(H2'*inv(R)*H2 + inv(P1_batch));
X2_batch = inv(H'*inv(R)*H + inv(P0))*(H'*inv(R)*[y1; y2] + inv(P0)*X0);

end

