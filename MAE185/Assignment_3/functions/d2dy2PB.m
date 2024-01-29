function df = d2dy2PB(f, dy)
%D2DY2PB Second Order Central Second Difference w/ Periodic Boundries

df = zeros(size(f)); %define df array

for j = 1:width(f)
    for i = 1:length(f)
        %Check Boundary Condition
        if j == 1
            df(i, j) =  (f(i, j+1) - 2*f(i, j) + f(i, width(f)))/(dy^2);
            continue;
        end
        if j == width(f)
            df(i, j) = (f(i, 1) - 2*f(i, j) + f(i, j-1))/(dy^2);
            continue;
        end

        df(i, j) = (f(i, j+1) -2*f(i, j) + f(i, j-1))/(dy^2); %2nd order central

    end
end

end

