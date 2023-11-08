clear all; close all; 

load('lab5pt2.mat');

%% Question 7

data = zeros(30, 15);

for i = 1:30
    for j = 1:15
        
         data(i, j) = recMatrix_sig(200, i, j);
     
         

    end
end

data(1, 15) = data(1, 14);

nordata = data./max(max(data));

x = linspace(0.46, 0.23, 30);
y = linspace(0.15, 0.05, 15);


pcolor(x, y, nordata'); colorbar; shading flat;
caxis([-1 1]);
xlabel('Distance in x axis (m)'); ylabel('Distance in y axis (m)');
legend('Normalized Microphone Voltage Readings');