function df = d2dy2(f, dy)
%D2DY2 Second Order Central Second Difference

df = zeros(size(f)); %define df array

for j = 1:width(f)
    for i = 1:length(f)
        %Check Boundary Condition
        if j == 1
            df(i, j) = (2*f(i, j) - 5*f(i, j+1) + 4*f(i, j+2) - f(i, j+3))/(dy^2); %2nd order fwd
            continue;
        end
        if j == width(f)
            df(i, j) = (2*f(i, j) - 5*f(i, j-1) + 4*f(i, j-2) - f(i, j-3))/(dy^2); %2nd order bwd
            continue;
        end

        df(i, j) = (f(i, j+1) -2*f(i, j) + f(i, j-1))/(dy^2); %2nd order central

    end
end

end

