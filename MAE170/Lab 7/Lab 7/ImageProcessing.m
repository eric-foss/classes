workingDir = pwd;
frames=200; % number of frames to process
pause('on'); % enable pausing
fps=30; % number of frames per second of the original video


%% Start by processing the first frame
name = ['001.jpg']; % filename of the first frame
filename = fullfile(workingDir,'images',name); % 1st frame filename with
path
testfig=imread(filename); % load the first frame into matlab
figure(01) % setup the first figure
imshow(testfig); % plot the first frame
h=gca; % get the handle for the current plot axes
h.Visible='On'; % get the handle for the current plot
title('Original Image'); % set the plot title

%% Grayscale
figure(02)
topleft_x=250; % number of pixels to crop from the left
topleft_y=120; % number of pixels to crop from the top
width=410; % width of the cropped frame (in pixels)
height=410; % height of the cropped frame (in pixels)
testfig_crop=imcrop(testfig,[topleft_x topleft_y width height]);
% crop the image to the dimensions specified above
testfig_crop_gray=rgb2gray(testfig_crop);
% convert the cropped image to grayscale
imshow(testfig_crop_gray);
h=gca;
h.Visible='On';
colorbar; %provide a color scale bar
title('Cropped Image in Grayscale');

%% Threshold Image
figure(03)
threshold=160; % threshold value to turn grayscale into binary (0 to 255)
dims_img = size(testfig_crop_gray); % get image dimensions
test_fig_binary=uint8(zeros(dims_img)); % initialize a new figure with zeros
for i=1:dims_img(1) % loop along the cropped grayscale image rows
for j=1:dims_img(2) % loop along the cropped grayscale image columns
if double(testfig_crop_gray(i,j))>threshold
% check if grayscale value is below/above your specified threshold
test_fig_binary(i,j)=255; %if it is above, set to maximum value
end
end
end
imshow(test_fig_binary,'Colormap',jet(255));
colorbar;
h=gca;
h.Visible='On';
title('Cropped Binary Image with Identified Points');

%% Identify points in first binary image
hold on % turn  hold’ on to allow addtl. plots to be overlayed on binary plot
rot_min = 19; % rotating point minimum pixel radius
rot_max = 140; % rotating point maximum pixel radius
ctr_min = 8; % center point minimum pixel radius
ctr_max = 16; % center point maximum pixel radius
rot_sens = 0.962; % algorithm sensitivity to find rotating point
ctr_sens = 0.93; % algorithm sensitivity to find center point
[rotatingpoint.center,rotatingpoint.radii] = imfindcircles(test_fig_binary,[rot_min rot_max],'ObjectPolarity','dark','Sensitivity',rot_sens);
% find dark circles in the range of 10 to 30 pixel radii (in this case, this will be the "rotating point”)
% sensitivity denotes threshold for detection of a circle; a lower value will detect fewer circles
% https://www.mathworks.com/help/images/detect-and-measure-circular-objects-in-an-image.html
% function returns a vector of the center coordinates of each circle, and a vector of each circle s radius
viscircles(rotatingpoint.center,rotatingpoint.radii);
% plot the rotating point (overlay on binary plot)
[centerpoint.center,centerpoint.radii] = imfindcircles(test_fig_binary,[ctr_min ctr_max],'ObjectPolarity','dark', 'Sensitivity',ctr_sens);
% find the “center” point
viscircles(centerpoint.center,centerpoint.radii);
% plot the center point (overlay on binary plot)

line([rotatingpoint.center(1) centerpoint.center(1)], [rotatingpoint.center(2) centerpoint.center(2)],'Color','k','LineWidth',2);
% plot a line from the rotating point to the center point (overlay it on the binary plot)
line([centerpoint.center(1) centerpoint.center(1)+width/4], [centerpoint.center(2) centerpoint.center(2)],'Color','g','LineWidth',2);
% plot a line corresponding to a starting angle (overlay it on the binary plot)
hold off % turn the plot hold off

zerovector=[1 0 0]; % initialize a zero vector
pointvector=[rotatingpoint.center-centerpoint.center, 0];
% Calculate vector from center to rotating point
angle_sign=cross(zerovector,pointvector);
% Check what the sign of the angle should be resulting from the next calculation
angle=sign(angle_sign(3))*atan2(norm(cross(zerovector,pointvector)),dot(zerovector,pointvector));
% Calculate the angle in radians
angled=angle*180/pi; % Convert to degrees

%% Loop through all the frames
rot_min = rot_min; % change these if needed
rot_max = rot_max; % change these if needed
rot_sens = rot_sens; % change these if needed
for k=1:frames
if k<1000 % Concatenate to dynamically obtain the filename
name = ['' int2str(k) '.jpg']; % Use the function int2str() to convert integer to string
end
if k<100
name = ['0' int2str(k) '.jpg'];
end
if k<10
name = ['00' int2str(k) '.jpg'];
end
filename = fullfile(workingDir,'images',name);
testfig=imread(filename);
testfig_crop=imcrop(testfig,[topleft_x topleft_y width height]);
testfig_crop_gray=rgb2gray(testfig_crop);
test_fig_binary=uint8(zeros(dims_img));
for i=1:dims_img(1)
for j=1:dims_img(2)
if double(testfig_crop_gray(i,j))>threshold
test_fig_binary(i,j)=255;
end
end
end
figure(04)
imshow(test_fig_binary,'Colormap',jet(255));
colorbar;
h=gca;
h.Visible='On';
title(['Cropped Binary Image ' num2str(k) ' with Identified Points']);
% dynamically adjust the plot title
hold on
[rotatingpoint.center,rotatingpoint.radii] = imfindcircles(test_fig_binary,[rot_min rot_max],'ObjectPolarity','dark', 'Sensitivity',rot_sens);
viscircles(rotatingpoint.center(1,:),rotatingpoint.radii(1,:));
viscircles(centerpoint.center,centerpoint.radii);
line([rotatingpoint.center(1,1) centerpoint.center(1)],...
[rotatingpoint.center(1,2)
centerpoint.center(2)],'Color','k','LineWidth',2);
line([centerpoint.center(1) centerpoint.center(1)+width/4],...
[centerpoint.center(2) centerpoint.center(2)],'Color','g','LineWidth',2);
hold off
zerovector=[1 0 0];
pointvector=[rotatingpoint.center(1,:)-centerpoint.center, 0];
angle_sign=cross(zerovector,pointvector);
angle=sign(angle_sign(3))*atan2(norm(cross(zerovector,pointvector)),dot(zerovector,pointvector));
angle_degrees=angle*180/pi
angled(k)=angle_degrees;
if mod(k,10)==0 % display every 10 frames to the command line
k

end
%pause(0.2); % pause for 200 ms for each frame to allow time for plotting
end
%shift measured angles to be from 0 to 360 instead of -180 to 180 degrees


%% setup an adjusted angle vector (for total accumulated angle)
angled=angled+180;
adjustedangle=angled;
frames=length(angled);

for i=2:frames
    if angled(i)<180 && angled(i-1)>180 % check for crossing from 360 to 0
        adjustedangle(i:frames)=adjustedangle(i:frames)+360;
    end
    % check for >180 degree motion
    if adjustedangle(i)-adjustedangle(i-1)>180
        % if so, undo the prior addition
        adjustedangle(i:frames)=adjustedangle(i:frames)-360;
    end
end

%% PLOTS

t = (1:length(angled))/30;
dt = t(2)-t(1);
figure(1);
subplot(3, 1, 1); hold on;
plot(t, angled, 'b-'); hold on;
xline(4.3, 'r-'); hold on;
xlabel('Time (s)'); ylabel('Angle Measured (deg)');
xlim([0 6.7]);

subplot(3, 1, 2); hold on;
plot(t, adjustedangle, 'b-'); hold on;
xline(4.3, 'r-'); hold on;
xlabel('Time (s)'); ylabel('Total Rotation Angle (deg)');
xlim([0 6.7]);

subplot(3, 1, 3);
omega = gradient(adjustedangle)./gradient(t);

plot(t, omega, 'b-'); hold on;
xline(4.3, 'r-'); hold on;
xlabel('Time (s)'); ylabel('Angular Velocity (deg/s)');
xlim([0 6.7]);

