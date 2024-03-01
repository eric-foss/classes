function [H_tilde, rho] = computeH_tilde(t, X, station, const)
%COMPUTEHTILDA Finds observations H_tilde matrix and range/range-rate using 
%matlab generated functions

theta = t*const.thetadot;

switch station
    case 101
        
        H_tilde = computeH_tilde_s1(X(1), X(2), X(3), X(4), X(5), X(6), X(10), X(11), X(12), theta, const.thetadot);
        rho = computeRho_s1(X(1), X(2), X(3), X(4), X(5), X(6), X(10), X(11), X(12), theta, const.thetadot);

    case 337
        
        H_tilde = computeH_tilde_s2(X(1), X(2), X(3), X(4), X(5), X(6), X(13), X(14), X(15), theta, const.thetadot);
        rho = computeRho_s2(X(1), X(2), X(3), X(4), X(5), X(6), X(13), X(14), X(15), theta, const.thetadot);

    case 394

        H_tilde = computeH_tilde_s3(X(1), X(2), X(3), X(4), X(5), X(6), X(16), X(17), X(18), theta, const.thetadot);
        rho = computeRho_s3(X(1), X(2), X(3), X(4), X(5), X(6), X(16), X(17), X(18), theta, const.thetadot);
end


end

