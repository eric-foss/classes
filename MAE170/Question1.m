




%% Question 1

d = csvread('MAE170_lab4.csv');

x = d(:, 1);
y = sqrt((1./d(:, 2)).^2 - 1)/(2*pi);

p = polyfit(x, y, 1);

figure(1);
plot(x, y, 'ro-', 'LineWidth', 1); hold on;
plot(x, p(1)*x + p(2), 'b^-', 'LineWidth', 1); hold on;
legend('Experimental Data', 'Line Fit', 'Location', 'northwest');
xlabel('Input Frequency'); 
ylabel('Normalized RC Filter Gain');
caption = sprintf('y = %f * x + %f', p(1), p(2));
text(7, 0.05, caption, 'FontSize', 10, 'Color', 'b', 'FontWeight', 'bold');



%% Question 2

x = d(:, 1);
y = d(:, 2);

RC = p(1);
x1 = x;
y1 = 1./(sqrt(1 + (RC*2*pi*x).^2));



figure(2);
plot(x, y, 'ro-', 'LineWidth', 1); hold on;
plot(x1, y1, 'b^-', 'LineWidth', 1); hold on;
xline(18, 'r', 'LineWidth', 1); hold on;
xline(20, 'b', 'LineWidth', 1); hold on;
yline(sqrt(2)/2, 'k', 'LineWidth', 1); hold on;
legend('Experimental Results', 'Analytical Function', 'Experimental Cutoff Frequency', 'Analytical Cutoff Frequency', '-3 dB');
xlabel('Input Frequency');
ylabel('RC Filer Gain');

%% Question 3

d2 = csvread('MAE170_lab4Q3.csv');

x = d2(:, 1);
y = d2(:, 2);

figure(3);
plot(x, y, 'ro-', 'LineWidth', 1); hold on;
legend('Experimental Results', 'Location', 'southeast');
xlabel('Input Frequency'); ylabel('Op Amp Gain');
xlim([0 30]);
ylim([0 2.2]);


%% Question 4

d3 = csvread('MAE170_lab4Q4.csv');

x = d3(:, 1);
y = d3(:, 2);

y2 = d(:, 2) .* d2(:, 2);

figure(4);
plot(x, y, 'ro-', 'LineWidth', 1); hold on;
plot(x, y2, 'b^-', 'LineWidth', 1); hold on;
legend('Experimental Results', 'Analytical Function');
xlabel('Input Frequency'); ylabel('Gain of RC Filter and Op Amp')




