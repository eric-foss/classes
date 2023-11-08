clear all; close all;

load('lab5pt2.mat');

%% Question 8

filename = 'scanning.gif';

for k=1:10:588
    

    data = zeros(30, 15);

    for i = 1:30
        for j = 1:15
        
            data(i, j) = recMatrix_sig(k, i, j);
    
        end
    end

    data(1, 15) = data(1, 14);
    nordata = data./max(max(data));

    x = linspace(0.46, 0.23, 30);
    y = linspace(0.15, 0.05, 15);


    pcolor(x, y, nordata'); colorbar; shading flat;
    xlabel('Distance in x axis (m)'); ylabel('Distance in y axis (m)');
    legend('Normalized Microphone Voltage Readings');
    caxis([-1 1]);
    pause(0.5);
    drawnow;

    frame = getframe(); % You can either remove the argument h
    % or define a figure above, e.g., h=figure(01);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    % Write to the GIF File
    if k == 1
        imwrite(imind,cm,filename,'gif', 'Loopcount',inf);
    else
        imwrite(imind,cm,filename,'gif','WriteMode','append');
    end
end