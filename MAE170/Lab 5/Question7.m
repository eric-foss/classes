clear all; close all; 

load('lab5pt2.mat');

data = zeros(30, 15);

for i = 1:30
    for j = 1:15
        
         data(i, j) = recMatrix_sig(200, i, j);


    end
end

data(1, 15) = data(1, 14);

x = linspace(46, 23, 30);
y = linspace(15, 5, 15);

pcolor(x, y, data'); colorbar; shading flat;

