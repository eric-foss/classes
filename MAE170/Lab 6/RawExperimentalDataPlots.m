clear all; close all; clc;

%% First Plot(shows raw experimental results and compare to average for one)

load('lab6MetalForced1.mat'); clc;

ambT1 = tempAmbC;
plateT1 = tempPlateC;

load('lab6MetalForced2.mat'); clc;

ambT2 = tempAmbC;
plateT2 = tempPlateC;

load('lab6MetalForced3.mat'); clc;

ambT3 = tempAmbC;
plateT3 = tempPlateC;


figure(1);
plot(plateT1, 'r--'); hold on;
plot(plateT2, 'b-.'); hold on;
plot(plateT3, 'k-'); hold on;
plot(ambT1, 'r--'); hold on;
plot(ambT2, 'b-.'); hold on;
plot(ambT3, 'k-'); hold on;

legend('First Recording', 'Second Recording', 'Third Recording');
xlabel('Time (s)'); ylabel('Temperature (C)');
xlim([0 250]);


figure(2);
plot(ambT1); hold on;
plot(ambT2); hold on;
plot(ambT3); hold on;

[max1, ind1] = max(plateT1);
[max2, ind2] = max(plateT2);
[max3, ind3] = max(plateT3);

T1 = plateT1(ind1: end);
T2 = plateT2(ind2: end);
T3 = plateT3(ind3: end);

figure(3);
plot(T1, 'r--'); hold on;
plot(T2, 'b-.'); hold on;
plot(T3, 'k-'); hold on;

legend('First Recording', 'Second Recording', 'Third Recording');
xlabel('Time (s)'); ylabel('Temperature (C)');



