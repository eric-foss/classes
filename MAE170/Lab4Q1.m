clear all;
x = 1:30;

R = 10000;
C = 0.000001;

for i = 1:30
y(i) = sqrt((2*pi*i)^2 * (R)^2 * (C)^2);
end

p = polyfit(x, y, 1);

for i = 1:30
    y1(i) = p(1)*i + p(2);

end

figure(2);
plot(x, y); hold on;

plot(x, y1); hold on;

