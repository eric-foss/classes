clear all; close all; clc;


load('lab5pt2.mat');

data = zeros(588, 30);

for i = 1:30
   
        
    sig = recMatrix_sig(:, i, 9);
    norsig = sig/max(sig);
    
    data(:, i) = norsig;

   
end

y = (1:588)/100000;
x = linspace(0.46, 0.23, 30);

figure(1);
s = pcolor(x, y, data); hold on;
s.FaceColor = 'interp';
shading flat;
colorbar;
xlabel('Distance in x-axis (m)');
ylabel('Time (s)');


ss = 1/340;

plot(x, x*ss + 0.001, 'r-', 'LineWidth', 1.5);
legend('Sound Distribution', 'Theoretical Speed of Sound', 'Location', 'northwest');