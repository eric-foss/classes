function df = ddx_central(f, dx)
%DDX_CENTRAL Second Order Central Difference

df = zeros(size(f)); %define df array

%loop through f array
for i = 1:length(f)
    for j = 1:width(f)
        %check boundary conditions
        if i == 1
            df(i, j) = (-3*f(i, j) + 4*f(i+1, j) - f(i+2, j))/(2*dx); %second order fwd
            continue;
        end
        if i == length(f)
            df(i, j) = (3*f(i, j) - 4*f(i-1, j) + f(i-2,j))/(2*dx); %second order bwd
            continue;
        end

        %second order central
        df(i, j) = (f(i+1,j) - f(i-1, j))/(2*dx);

    end
end

end

