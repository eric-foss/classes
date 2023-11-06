%% MAE170 Lab 5 Eric Foss A17068006
clc; close all; clear all;



%% Question2
load('lab5p1.mat');

figure(1);

%x = linspace(0, 6, 588);
x = [1:588]/100;
yavg = recMatrix_sig;
ylast = wave_sig;

plot(x, yavg, 'r--', 'LineWidth', 1); hold on;
plot(x, ylast, 'b-', 'LineWidth', 1); hold on;
legend('Average Signal', 'Final Signal', 'Location', 'northwest');
xlabel('Time (ms)'); ylabel('Voltage (V)');


%% Question 4
load('lab5pt2.mat');

dx = 23/30; dy = 10/15; %totalreal/totalexpected = realincrement

delay = zeros(30, 15);
for i = 1:30
    for j = 1:15
        %stupid edge cases
        if i == 1
            if j == 15
                delay(i, j) = delay(i, j-1);
                continue;
            end
        end

        if i == 27
            if j == 9
                delay(i, j) = 191;
                continue;
            end
        end

        sig = recMatrix_sig(:, i, j);
        maxs = islocalmax(sig);
        mins = islocalmin(sig);
        maxs_index = find(maxs);
        mins_index = find(mins);

        for o = 1:length(maxs_index)
            bool = 0;
            if maxs_index(o+1) - maxs_index(o) > 15
                if maxs_index(o+2) - maxs_index(o+1) > 15
                    for o2 = 1:length(mins_index)
                        if mins_index(o2+1) - mins_index(o2) > 15
                            if mins_index(o2+2) - mins_index(o2+1) > 15
                                if (mins_index(o2)-maxs_index(o)) > 7 && (mins_index(o2)-maxs_index(o)) < 13
                                    bool = 1;
                                    break;
                                end
                            end
                        end
                    end
                    if bool == 1
                        break;
                    end
                end
            end
        end



        delay(i, j) = maxs_index(o); %- 100;

    end
end