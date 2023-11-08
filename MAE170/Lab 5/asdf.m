load('lab5pt2.mat');
close all;



for i = 6

test = recMatrix_sig(:, 16, i);

maxs = islocalmax(test);
mins = islocalmin(test);
extrema = maxs + mins;

indexs = find(extrema);

temp = test(indexs);


for o = 2:length(indexs)
   
    if abs(temp(o+1) - temp(o)) > 3*abs(temp(o) - temp(o-1))
        if abs(temp(o+2) - temp(o+1)) > 0.6
            break;
        end
    end
end

delay = indexs(o+1);


plot(test); hold on;

plot(indexs, test(indexs), 'or'); hold on;
plot(delay, test(delay), 'xb', 'MarkerSize', 30); hold on;

end

