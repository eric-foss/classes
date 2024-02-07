function df = ddy_fwd(f, dy, bc)
%DDY_FWD First Order Foward Difference in Y

%default to one-sided if lacking user input
if nargin < 3
    bc = 'one-sided';
end

df = zeros(size(f)); %initialize difference matrix

%fwd difference
for j = 1:width(f)-1
    for i = 1:length(f)        
        df(i, j) = (f(i, j+1) - f(i, j))/dy;
    end
end

switch bc %Boundry Conditions
    case 'periodic' %Periodic Boundry Conditions
        j = width(f);
        for i = 1:length(f)
            df(i, j) = (f(i, 1) - f(i, j))/dy;
        end
    otherwise %Backward Difference at BC
        j = width(f);
        for i = 1:length(f)
            df(i, j) = (f(i, j) - f(i, j-1))/dy;
        end
end

end
