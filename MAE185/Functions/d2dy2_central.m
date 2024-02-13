function df = d2dy2_central(f, dy, bc)
%D2DY2_CENTRAL Second Order Central Second Difference

%default to one-sided if lacking user input
if nargin < 3
    bc = 'one-sided';
end %if

df = zeros(size(f)); %initialize difference matrix

%central second difference
for j = 2:(width(f)-1)
    for i = 1:length(f)
        df(i, j) = (f(i, j+1) - 2*f(i, j) + f(i, j-1))/(dy^2);
    end %for
end %for

switch bc
    case 'periodic' %periodic boundry conditions
        for i = 1:length(f) 
            j = 1;
            df(i, j) = (f(i, j+1) - 2*f(i, j) + f(i, width(f)))/(dy^2);
            j = width(f);
            df(i, j) = (f(i, 1) - 2*f(i, j) + f(i, j-1))/(dy^2);
        end %for
    otherwise 
        for i = 1:length(f)
            j = 1;
            df(i, j) = (2*f(i, j) - 5*f(i, j+1) + 4*f(i, j+2) - f(i, j+3))/(dy^2); %2nd order fwd
            j = width(f);
            df(i, j) = (2*f(i, j) - 5*f(i, j-1) + 4*f(i, j-2) - f(i, j-3))/(dy^2); %2nd order bwd
        end %for
end %switch

end

