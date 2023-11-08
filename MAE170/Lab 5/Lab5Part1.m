%% MAE170 Lab 5 Eric Foss A17068006
clc; close all; clear all;



%% Question2
load('lab5p1.mat');

figure(1);

%x = linspace(0, 6, 588);
x = [1:588]/100;
yavg = recMatrix_sig;
ylast = wave_sig;

plot(x, yavg, 'r--', 'LineWidth', 1); hold on;
plot(x, ylast, 'b-', 'LineWidth', 1); hold on;
legend('Average Signal', 'Final Signal', 'Location', 'northwest');
xlabel('Time (ms)'); ylabel('Voltage (V)');


%% Question 4
load('lab5pt2.mat');

dx = 23/29; dy = 10/14; %totalreal/totalexpected = realincrement

x0 = 46; y0 = 15;

delay = zeros(30, 15);
dist = zeros(30, 15);
x = zeros(30, 15);
y = zeros(30, 15);
data = zeros(30*15, 2);
counter = 0;
figure(2);
for i = 1:30
    for j = 1:15
        
        counter = counter + 1;

        %time delay calcs

        %stupid edge case
        if i == 1
            if j == 15
                continue;
            end
        end
        %stupid edge case

        sig = recMatrix_sig(:, i, j);
        maxs = islocalmax(sig);
        mins = islocalmin(sig);
        extrema = maxs + mins;

        indexs = find(extrema);
        temp = sig(indexs);

        for o = 1:length(indexs)
   
            if abs(temp(o+1) - temp(o)) > 0.8
                if abs(temp(o+2) - temp(o+1)) > 0.7
                    break;
                end
            end
        end

        delay(i, j) = (indexs(o)- 100)/100000; %ms
        
        if j ~= 1
            if abs(delay(i, j) - delay(i, j-1)) > 15
                delay(i, j) = delay(i, j-1);
            end
        end


        %distance calcs

        x(i, j) = x0 - dx*(i-1);
        y(i, j) = y0 - dy*(j-1);
        dist(i, j) = sqrt(x(i, j)^2 + y(i, j)^2)/100;

        data(counter, :) = [dist(i, j), delay(i, j)];
  
        

    end
end

data(15, :) = data(14, :);
delay(1, 15) = delay(1, 14);
x(1, 15) = 46;
y(1, 15) = 5;

datafiltered = rmoutliers(data, 'movmedian', 15);

xplot = 0.2:0.01:0.5;
xdata = datafiltered(:, 1);
ydata = datafiltered(:, 2);

% xneg = 0.003*ones(length(xdata), 1);
% xpos = 0.003*ones(length(xdata), 1);
% yneg = 0.00001*ones(length(ydata), 1);
% ypos = 0.00001*ones(length(ydata), 1);
%errorbar(xdata, ydata, yneg, ypos, xneg, xpos); hold on;


plot(xdata, ydata, '.b'); hold on;

xlabel('Distance Traveled (m)'); ylabel('Time Elapsed (s)');

p = polyfit(xdata, ydata, 1);

plot(xplot, p(1)*xplot + p(2), '-r', 'LineWidth', 1.5); hold on;


ss = 1/340;
plot(xplot, ss*xplot, '--k', 'LineWidth', 1.5);

legend('Experimental Data', 'Best Fit', 'Theoretical Result', 'Location', 'southeast');
%caption = sprintf('y = %f * x + %f', p(1), p(2));
%text(0.25, 0.0013, caption, 'FontSize', 10, 'Color', 'r', 'FontWeight', 'bold');


%% Question 6





%% Question 7

x6 = linspace(23, 46, 30);
y6 = linspace(5, 15, 15);

     