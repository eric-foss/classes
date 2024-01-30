function df = ddy_bwd(f, dy, bc)
%%DDY_BWD First Order Backward Difference in Y

df = zeros(size(f));

if nargin < 3
    bc = 'one-sided';
end

for j = 2:width(f)
    for i = 1:length(f)

        df(i, j) = (f(i, j) - f(i, j-1))/dy; %bwd dif

    end
end

switch bc %Boundry Conditions
    case 'periodic'
        j = 1;
        for i = 1:length(f)
            df(i, j) = (f(i, j) - f(i, end))/dy; %periodic BC
        end
    otherwise
        j = 1;
        for i = 1:length(f)
            df(i, j) = (f(i, j+1) - f(i, j))/dy; %fwd dif
        end
end

end

