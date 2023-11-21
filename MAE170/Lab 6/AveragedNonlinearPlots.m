close all; clear all; clc;

Tamb = 22;

%% Acrylic Free

load('lab6AcrylicFree1.mat'); clc;

plateT1 = tempPlateC;

load('lab6AcrylicFree2.mat'); clc;

plateT2 = tempPlateC;

load('lab6AcrylicFree3.mat'); clc;

plateT3 = tempPlateC;

[max1, ind1] = max(plateT1);
[max2, ind2] = max(plateT2);
[max3, ind3] = max(plateT3);

T1 = plateT1(ind1: end);
T2 = plateT2(ind2: end);
T3 = plateT3(ind3: end);

len(1) = length(T1);
len(2) = length(T2);
len(3) = length(T3);

minlen = min(len);

T(1, :) = T1(1:minlen);
T(2, :) = T2(1:minlen);
T(3, :) = T3(1:minlen);

avgT_AcyFree = mean(T);
clear T;

%% Acrylic Forced

load('lab6AcrylicForced1.mat'); clc;

plateT1 = tempPlateC;

load('lab6AcrylicForced2.mat'); clc;

plateT2 = tempPlateC;

load('lab6AcrylicForced3.mat'); clc;

plateT3 = tempPlateC;

[max1, ind1] = max(plateT1);
[max2, ind2] = max(plateT2);
[max3, ind3] = max(plateT3);

T1 = plateT1(ind1: end);
T2 = plateT2(ind2: end);
T3 = plateT3(ind3: end);

len(1) = length(T1);
len(2) = length(T2);
len(3) = length(T3);

minlen = min(len);

T(1, :) = T1(1:minlen);
T(2, :) = T2(1:minlen);
T(3, :) = T3(1:minlen);

avgT_AcyForced = mean(T);
clear T;

%% Metal Free

load('lab6MetalFree1.mat'); clc;

plateT1 = tempPlateC;

load('lab6MetalFree2.mat'); clc;

plateT2 = tempPlateC;

load('lab6MetalFree3.mat'); clc;

plateT3 = tempPlateC;

[max1, ind1] = max(plateT1);
[max2, ind2] = max(plateT2);
[max3, ind3] = max(plateT3);

T1 = plateT1(ind1: end);
T2 = plateT2(ind2: end);
T3 = plateT3(ind3: end);

len(1) = length(T1);
len(2) = length(T2);
len(3) = length(T3);

minlen = min(len);

T(1, :) = T1(1:minlen);
T(2, :) = T2(1:minlen);
T(3, :) = T3(1:minlen);

avgT_MetalFree = mean(T);
clear T;

%% MetalForced

load('lab6MetalForced1.mat'); clc;

plateT1 = tempPlateC;

load('lab6MetalForced2.mat'); clc;

plateT2 = tempPlateC;

load('lab6MetalForced3.mat'); clc;

plateT3 = tempPlateC;

[max1, ind1] = max(plateT1);
[max2, ind2] = max(plateT2);
[max3, ind3] = max(plateT3);

T1 = plateT1(ind1+5: end);
T2 = plateT2(ind2+5: end);
T3 = plateT3(ind3+5: end);

len(1) = length(T1);
len(2) = length(T2);
len(3) = length(T3);

minlen = min(len);

T(1, :) = T1(1:minlen);
T(2, :) = T2(1:minlen);
T(3, :) = T3(1:minlen);

avgT_MetalForced = mean(T);
clear T;


%% Plot

figure(1);

plot(avgT_AcyFree, 'b--'); hold on;
plot(avgT_AcyForced, 'g-.'); hold on;
plot(avgT_MetalFree, 'r:'); hold on;
plot(avgT_MetalForced, 'k-'); hold on;

legend('Acrylic Plate Temperature w/ Free Convection', ...
'Acrylic Plate Temperature w/ Forced Convection', ... 
'Metal Plate Temperature w/ Free Convection', ...
'Metal Plate Temperature w/ Forced Convection');
xlabel('Time (s)'); ylabel('Temperature (C)');

    
theta_AcyFree = (avgT_AcyFree-Tamb)/(avgT_AcyFree(1)-Tamb);
theta_AcyForced = (avgT_AcyForced-Tamb)/(avgT_AcyForced(1)-Tamb);
theta_MetalFree = (avgT_MetalFree-Tamb)/(avgT_MetalFree(1)-Tamb);
theta_MetalForced = (avgT_MetalForced-Tamb)/(avgT_MetalForced(1)-Tamb);

figure(2);

y1 = log(theta_AcyFree);
y2 = log(theta_AcyForced);
y3 = log(theta_MetalFree);
y4 = log(theta_MetalForced);

x1 = 1:length(y1);
x2 = 1:length(y2);
x3 = 1:length(y3);
x4 = 1:length(y4);

subplot(2, 1, 1);
plot(y1, 'b--'); hold on;
plot(y2, 'g-.'); hold on;
plot(y3, 'r:'); hold on;
plot(y4, 'k-'); hold on;
xlabel('Time Constant'); ylabel('Ln(Theta)');
legend('Acrylic Free', 'Acrylic Forced', 'Metal Free', 'Metal Forced');

subplot(2, 1, 2);

f1 = polyfit(x1, y1, 1);
f2 = polyfit(x2, y2, 1);
f3 = polyfit(x3, y3, 1);
f4 = polyfit(x4, y4, 1);

plot(x1, f1(1)*x1 + f1(2),'b--'); hold on;
plot(x2, f2(1)*x2 + f2(2), 'g-.'); hold on;
plot(x3, f3(1)*x3 + f3(2), 'r:'); hold on;
plot(x4, f4(1)*x4 + f4(2), 'k-'); hold on;
xlabel('Time Constant'); ylabel('Ln(Theta)');
legend('Acrylic Free', 'Acrylic Forced', 'Metal Free', 'Metal Forced');
