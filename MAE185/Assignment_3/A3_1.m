%% MAE185 Assignment 3 Problem 1
% Eric Foss
% A17068006

%load and store initial state
load('gotritons.mat', 'T', 'xx', 'yy');
T1 = T;

%define constants
alpha = 2;
dy = yy(1, 2) - yy(1, 1);
dx = xx(2, 1) - xx(1, 1);
SF = 1.2; %1.2 safety factor
t_final = 0.001;

%find time step based on safety factor
dt = (dx^2*dy^2/(dx^2 + dy^2))/(4*SF*alpha);
dt = t_final/ceil(t_final/dt); %so its nice and whole
t = 0:dt:t_final;

%initialize tempurature vector
T = zeros(length(t), length(T), width(T));
T(1, :, :) = T1;

%time march in temperature
for n = 2:length(t)

    T(n, :, :) = squeeze(T(n-1, :, :)) + alpha*dt*(d2dx2PB(squeeze(T(n-1, :, :)), dx) + d2dy2PB(squeeze(T(n-1, :, :)), dy));

end


%Animation Loop
figure(1);
for i = 1:length(t)
    
    pcolor(xx, yy, squeeze(T(i, :, :)));
    shading interp;
    axis equal tight;
    colorbar;
    title('T'); xlabel('x'); ylabel('y');
    drawnow;
    clim([0 1]);

end




%% FUNCTIONS 

function df = d2dx2PB(f, dx)
%D2DX2PB Second Order Central Second Difference w/ Periodic Boundries

df = zeros(size(f)); %define df array

for i= 1:length(f)
    for j = 1:width(f)
        %Check Boundary Condition
        if i == 1
            df(i, j) =  (f(i+1, j) - 2*f(i, j) + f(length(f), j))/(dx^2); %loop to end
            continue;
        end
        if i == length(f)
            df(i, j) = (f(1, j) - 2*f(i, j) + f(i-1, j))/(dx^2); %loop to beginning
            continue;
        end

        df(i, j) = (f(i+1, j) -2*f(i, j) + f(i-1, j))/(dx^2); %2nd order central

    end
end

end

function df = d2dy2PB(f, dy)
%D2DY2PB Second Order Central Second Difference w/ Periodic Boundries

df = zeros(size(f)); %define df array

for j = 1:width(f)
    for i = 1:length(f)
        %Check Boundary Condition
        if j == 1
            df(i, j) =  (f(i, j+1) - 2*f(i, j) + f(i, width(f)))/(dy^2); %loop to end
            continue;
        end
        if j == width(f)
            df(i, j) = (f(i, 1) - 2*f(i, j) + f(i, j-1))/(dy^2); %loop to beginning
            continue;
        end

        df(i, j) = (f(i, j+1) -2*f(i, j) + f(i, j-1))/(dy^2); %2nd order central

    end
end

end
