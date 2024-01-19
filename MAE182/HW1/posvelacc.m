function [pos, vel, acc] = posvelacc(t, x, mu, fig_num)

rt = x(:, 1:3); %propagated positions
vt = x(:, 4:6); %propagated velocities


%define position, velocity, and acceleration magnitude vectors
at = zeros(size(rt)); 
pos = zeros(length(t), 1);
vel = zeros(length(t), 1);
acc = zeros(length(t), 1);

%loop through each propagated state
for i = 1:length(t)
    
    at(i, :) = -mu*rt(i, :)/(norm(rt(i, :))^3); %propagated accelerations
    
    %magnitudes
    pos(i) = norm(rt(i, :));
    vel(i) = norm(vt(i, :));
    acc(i) = norm(at(i, :));

end

%PLOTS
figure(fig_num); hold on;

%postion Plot
subplot(3, 1, 1);
plot(t, pos, 'k-');
title('Position Magnitude');
xlabel('Time (s)'); ylabel('Position (km)');
xlim([0 t(end)]);

%velocity Plot
subplot(3, 1, 2)
plot(t, vel, 'b-');
title('Velocity Magnitude');
xlabel('Time (s)'); ylabel('Velocity (km/s)');
xlim([0 t(end)]);

%acceleration Plot
subplot(3, 1, 3);
plot(t, acc, 'r-');
title('Acceleration Magnitude');
xlabel('Time (s)'); ylabel('Acceleration (km/s^2)');
xlim([0 t(end)]);
hold off;


end


