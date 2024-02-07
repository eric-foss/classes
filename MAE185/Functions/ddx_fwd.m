function df = ddx_fwd(f, dx, bc)
%DDX_FWD First Order Forward Difference in X

%default to one-sided if lacking user input
if nargin < 3
    bc = 'one-sided';
end %if

df = zeros(size(f)); %initialize difference matrix

%fwd difference
for i = 1:length(f)-1
    for j = 1:width(f)
        df(i, j) = (f(i+1, j) - f(i, j))/dx;
    end %for
end %for

switch bc %boundry conditions
    case 'periodic' %periodic boundry conditions
        i = length(f);
        for j = 1:width(f)
            df(i, j) = (f(1, j) - f(i, j))/dx; %right periodic
        end %for
    otherwise %backward difference at BC
        i = length(f);
        for j = 1:width(f)
            df(i, j) = (f(i, j) - f(i-1, j))/dx; %right bwd dif
        end %for
end %switch
end %function
