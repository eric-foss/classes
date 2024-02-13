function df = d2dx2_central(f, dx, bc)
%D2DX2_CENTRAL Summary of this function goes here

%default to one-sided if lacking user input
if nargin < 3
    bc = 'one-sided';
end %if

df = zeros(size(f)); %initialize difference matrix

%central second difference
for i = 2:(length(f)-1)
    for j = 1:width(f)
        df(i, j) = (f(i+1, j) - 2*f(i, j) + f(i-1, j))/(dx^2);
    end %for
end %for

switch bc
    case 'periodic' %periodic boundry conditions
        for j = 1:width(f)
            i = 1;
            df(i, j) = (f(i+1, j) - 2*f(i, j) + f(length(f), j))/(dx^2);
            i = length(f);
            df(i, j) = (f(1, j) - 2*f(i, j) + f(i-1, j))/(dx^2);
        end
    otherwise %one-sided boundry conditions
        for j = 1:width(f)
            i = 1;
            df(i, j) = (2*f(i, j) -5*f(i+1, j) + 4*f(i+2, j) - f(i+3, j))/(dx^2);
            i = length(f);
            df(i, j) = (2*f(i, j) -5*f(i-1, j) + 4*f(i-2, j) - f(i-3, j))/(dx^2);
        end %for
end %switch

end %fuctnions