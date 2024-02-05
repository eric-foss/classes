function df = ddx_bwd(f, dx)
%DDX_BWD First Order Backward Difference

df = zeros(size(f)); %define derivative array

%loop through f array
for i = 1:length(f)
    for j = 1:width(f)

        %check for boundry condition
        if i == 1
            df(i, j) = (f(i+1, j) - f(i, j))/dx;
            continue;
        end
        
        df(i, j) = (f(i, j) - f(i-1, j))/dx;

    end
end

end

