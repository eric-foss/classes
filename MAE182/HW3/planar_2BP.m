function xdot = planar_2BP(~, x)
%PLANAR_2BP Dynamics of Two Body Problem  in 2D
%   Detailed explanation goes here

xdot = [x(3); x(4); -x(1)/(norm(x(1:2))^3); -x(2)/(norm(x(1:2))^3)];

end