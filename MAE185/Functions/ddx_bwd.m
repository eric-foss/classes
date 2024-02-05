function df = ddx_bwd(f, dx, bc)
%%DDX_BWD First Order Backward Difference in X

df = zeros(size(f));

if nargin < 3
    bc = 'one-sided';
end

for i = 2:length(f)
    for j = 1:width(f)

        df(i, j) = (f(i, j) - f(i-1, j))/dx; %bwd dif

    end
end

switch bc %Boundry Conditions
    case 'periodic'
        i = 1;
        for j = 1:width(f)
            df(i, j) = (f(i, j) - f(end, j))/dx; %periodic
        end

    otherwise
        i = 1;
        for j = 1:width(f)
            df(i, j) = (f(i+1, j) - f(i, j))/dx; %fwd dif
        end
end
end

