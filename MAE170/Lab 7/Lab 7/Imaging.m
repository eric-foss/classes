workingDir = pwd; % set the working directory to the current directory
frames = 200; % set the number of frames to record
v_read = VideoReader('recorded_video_10_27_39.avi'); % setup the video reader
mkdir(workingDir,'images'); % make a subfolder to store your images
for i = 1:frames % Create a loop to move through each frame
img = readFrame(v_read); % read current frame as an image
name = [sprintf('%03d',i) '.jpg']; % dynamically create image filename
filename = fullfile(workingDir,'images',name); % add file path/directory
imwrite(img,filename); % create the image file
end