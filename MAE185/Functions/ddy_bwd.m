function df = ddy_bwd(f, dy, bc)
%%DDY_BWD First Order Backward Difference in Y

%default to one-sided if lacking user input
if nargin < 3
    bc = 'one-sided';
end %if

df = zeros(size(f)); %initialize difference matrix

%backward difference
for j = 2:width(f)
    for i = 1:length(f)
        df(i, j) = (f(i, j) - f(i, j-1))/dy;
    end %for
end %for

switch bc %boundry conditions
    case 'periodic' %periodic boundry conditions
        j = 1;
        for i = 1:length(f)
            df(i, j) = (f(i, j) - f(i, end))/dy; %left periodic
        end %for
    otherwise %one-sided
        j = 1;
        for i = 1:length(f)
            df(i, j) = (f(i, j+1) - f(i, j))/dy; %left fwd dif
        end %for
end %switch
end %function

