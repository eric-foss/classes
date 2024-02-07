function df = ddy_central(f, dy, bc)
%DDY_CENTRAL Second Order Central Difference in Y

%default to one-sided if lacking user input
if nargin < 3
    bc = 'one-sided';
end %if

df = zeros(size(f)); %initialize difference matrix

%central difference
for j = 2:width(f)-1
    for i = 1:length(f)
        df(i, j) = (f(i, j+1) - f(i, j-1))/(2*dy);
    end %for
end %for

switch bc %boundry conditions
    case 'periodic' %periodic boundry conditions
        for i = 1:length(f)
            j = 1;
            df(i, j) = (f(i, j+1) - f(i, end))/(2*dy); %left periodic
            j = length(f);
            df(i, j) = (f(i, 1) - f(i, j-1))/(2*dy); %right periodic
        end %for
    otherwise %one-sided
        for i = 1:length(f)
            j = 1;
            df(i, j) = (-3*f(i, j) + 4*f(i, j+1) - f(i, j+2))/(2*dy); %2nd order fwd diff on left
            j = width(f);
            df(i, j) = (3*f(i, j) - 4*f(i, j-1) + f(i, j-2))/(2*dy); %2nd order bwd diff on right
        end %for
end %switch
end %function

