function df = ddx_fwd(f,dx)
%DDX_FWD First Order Forward Difference 

df = zeros(size(f)); %define derivative array

%loop through f array
for i = 1:length(f)
    for j = 1:width(f)

        %check for boundry condition
        if i == length(f)
            df(i, j) = (f(i, j) - f(i-1, j))/dx; %first order bwd
            continue;
        end
        
        df(i, j) = (f(i+1, j) - f(i, j))/dx; %first order fwd
        
    end
end

end 