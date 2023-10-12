%Matched Method Function
function [Dz] = EAF_C2D_matched(Ds, h, omega_bar, bool)
    % function [Dz]=EAF_C2D_matched(Ds, h, omega_bar, bool)
    % Convert Ds(s) to Dz(z) using matched method.  If omega_bar is
    % specified, gain is adjusted appropriately.
    % If unspecified, omega_bar is defaulted to 0 (DC gain). 
    % If semi-proper TF is required, set bool equal to 1. 
    % TEST CODE : ys = 20*[1 1]; xs = [1 10]; h = 0.01; 
    %             Ds = RR_tf(ys, xs);
    %             Dz = EAF_C2D_matched(Ds, h);

  
    if nargin ~= 4, bool = 0; end
    if bool ~= 1, bool = 0; end
    if nargin == 2, omega_bar = 0; end
    
    %Find poles/zeros of CT and convert to DT poles/zeros
    z_s = RR_roots(Ds.num); p_s = RR_roots(Ds.den);
    z_z = exp(h*z_s); p_z = exp(h*p_s);
    
    %Check properness of CT function
    m = Ds.num.n; n = Ds.den.n;
    if bool == 0, n = n-1; end
    
    %If needed, add infinite poles 
    while n > m
        n = n - 1; z_z = [z_z -1];
    end

    %Temporarily define DT transfer funtion
    Dz = RR_tf(z_z, p_z, 1); Dz.h = h;
    
    %Find proper gain based off omega_bar
    dcgain_s = RR_evaluate(Ds, 1i*omega_bar); 
    dcgain_z = RR_evaluate(Dz, exp(1i*omega_bar*h));
    
    %Add gain and return
    Dz = Dz * (dcgain_s/dcgain_z);

end