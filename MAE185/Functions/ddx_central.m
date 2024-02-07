function df = ddx_central(f, dx, bc)
%DDX_CENTRAL Second Order Central Difference in X

%default to one-sided if lacking user input
if nargin < 3
    bc = 'one-sided';
end %if

df = zeros(size(f)); %initialize difference matrix

%central difference
for i = 2:length(f)-1
    for j = 1:width(f)
        df(i, j) = (f(i+1, j) - f(i-1, j))/(2*dx);
    end %for
end %for

switch bc
    case 'periodic' %periodic boundry conditions
        for j = 1:width(f)
            i = 1;
            df(i, j) = (f(i+1, j) - f(end, j))/(2*dx); %left periodic
            i = length(f);
            df(i, j) = (f(1, j) - f(i-1, j))/(2*dx); %right periodic
        end %for
    otherwise %one-sided boundry conditions
        for j = 1:width(f)
            i = 1;
            df(i, j) = (-3*f(i, j) + 4*f(i+1, j) - f(i+2, j))/(2*dx); %left 2nd order fwd dif
            i = length(f);
            df(i, j) = (3*f(i, j) - 4*f(i-1, j) + f(i-2, j))/(2*dx); %rigth 2nd order bwd dif
        end %for
end %switch
end %function

