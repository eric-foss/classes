function df = d2dx2PB(f, dx)
%D2DX2PB Second Order Central Second Difference w/ Periodic Boundries

df = zeros(size(f)); %define df array

for i= 1:length(f)
    for j = 1:width(f)
        %Check Boundary Condition
        if i == 1
            df(i, j) =  (f(i+1, j) - 2*f(i, j) + f(length(f), j))/(dx^2);
            continue;
        end
        if i == length(f)
            df(i, j) = (f(1, j) - 2*f(i, j) + f(i-1, j))/(dx^2);
            continue;
        end

        df(i, j) = (f(i+1, j) -2*f(i, j) + f(i-1, j))/(dx^2); %2nd order central

    end
end

end