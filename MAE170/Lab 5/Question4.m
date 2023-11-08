clear all; close all;

load('lab5pt2.mat');

%% Question 4

signals = recMatrix_sig;
signals(:, 1, 15) = signals(:, 1, 14);
data = zeros(30, 1);

for i = 1:30
    
    temp = zeros(15, 1);
    for j = 1:15

        sig = signals(:, i, j);

        maxs = islocalmax(sig);
        mins = islocalmin(sig);
        extrema = maxs + mins; %boolean vector: 1 if extrema
        extrema_indexs = find(extrema); %indexs of extrema
        extrema_values = sig(extrema_indexs); %values of extrema


        for o = 1:length(extrema_indexs)
            if abs(extrema_values(o+1) - extrema_values(o)) > 0.8
                if abs(extrema_values(o+2) - extrema_values(o+1)) > 0.7
                    break;
                end
            end
        end

        temp(j) = extrema_indexs(o) - 100;
        

    end
    
    temp2 = rmoutliers(temp);
    
    data(i) = mean(temp2);

end


%%plotting
figure(1);

xlines = 0.2:0.1:0.5;
x = linspace(0.46, 0.23, 30);
y = data/100000;

l = length(x);

xneg = 0.0015*ones(l, 1);
xpos = 0.0015*ones(l, 1);
yneg = 0.000025*ones(l, 1);
ypos = 0.000025*ones(l, 1);

plot(x, y, 'b.', 'MarkerSize', 15); hold on;
errorbar(x, y, yneg, ypos, xneg, xpos, '.b');

p = polyfit(x, y, 1);

plot(xlines, xlines*p(1) + p(2), '-r'); hold on;

plot(xlines, xlines*(1/340) + 0.00005, '--k'); hold on;

xlim([0.2 0.5]); ylim([0.0006 0.0016]);
xlabel('Distance in x-axis (m)'); ylabel('Time Elapsed (s)');
legend('Experimental Data', 'Experimental Error', 'Experimental Fit (c = 353)', 'Theoretical Result (c= 340)', 'Location', 'southeast');
