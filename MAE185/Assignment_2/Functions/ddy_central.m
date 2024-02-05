function df = ddy_central(f, dy)
%DDY_CENTRAL Second order central difference in y

df = zeros(size(f));

%loop through f array
for j = 1:width(f)
    for i = 1:length(f)
        %check boundary conditions
        if j == 1
            df(i, j) = (-3*f(i, j) + 4*f(i, j+1) - f(i, j+2))/(2*dy); %2nd order fwd
            continue;
        end
        if j == width(f)
            df(i, j) = (3*f(i, j) - 4*f(i, j-1) + f(i, j-2))/(2*dy); %2nd order bwd
            continue;
        end
        
        df(i, j) = (f(i, j+1) - f(i, j-1))/(2*dy);

    end
end

end

