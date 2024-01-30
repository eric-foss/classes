function df = ddx_fwd(f, dx, bc)
%DDX_FWD First Order Forward Difference in X

    if nargin < 3
        bc = 'one-sided';
    end

    df = zeros(size(f));

    for i = 1:length(f)-1
        for j = 1:width(f)
            
            df(i, j) = (f(i+1, j) - f(i, j))/dx;

        end
    end

    switch bc %Boundry Conditions
        case 'periodic' %Periodic Boundry Conditions

            i = length(f);
            for j = 1:width(f)
                df(i, j) = (f(1, j) - f(i, j))/dx;
            end

        otherwise %Backward Difference at BC

            i = length(f);
            for j = 1:width(f)
                df(i, j) = (f(i, j) - f(i-1, j))/dx;
            end
    end

end
