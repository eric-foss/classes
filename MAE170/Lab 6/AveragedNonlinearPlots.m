 close all; clear all; clc;

Tamb = 22;

%% Acrylic Free

load('lab6AcrylicFree1.mat'); clc;

plateT1 = tempPlateC;
ambT1 = tempAmbC;

load('lab6AcrylicFree2.mat'); clc;

plateT2 = tempPlateC;
ambT2 = tempAmbC;

load('lab6AcrylicFree3.mat'); clc;

plateT3 = tempPlateC;
ambT3 = tempAmbC;

[max1, ind1] = max(plateT1);
[max2, ind2] = max(plateT2);
[max3, ind3] = max(plateT3);

T1 = plateT1(ind1: end);
T1_amb = ambT1(ind1:end);
T2 = plateT2(ind2: end);
T2_amb = ambT2(ind2:end);
T3 = plateT3(ind3: end);
T3_amb = ambT3(ind3:end);

len(1) = length(T1);
len(2) = length(T2);
len(3) = length(T3);

minlen = min(len);

T(1, :) = T1(1:minlen);
T(2, :) = T2(1:minlen);
T(3, :) = T3(1:minlen);

theta(1, :) = (T1(1:minlen)-T1_amb(1:minlen))./(T1(1)-T1_amb(1:minlen));
theta(2, :) = (T2(1:minlen)-T2_amb(1:minlen))./(T2(1)-T2_amb(1:minlen));
theta(3, :) = (T3(1:minlen)-T3_amb(1:minlen))./(T3(1)-T3_amb(1:minlen));

avgTheta_AcyFree = mean(theta);

avgT_AcyFree = mean(T);

clear T;
clear theta;

%% Acrylic Forced

load('lab6AcrylicForced1.mat'); clc;

plateT1 = tempPlateC;
ambT1 = tempAmbC;

load('lab6AcrylicForced2.mat'); clc;

plateT2 = tempPlateC;
ambT2 = tempAmbC;

load('lab6AcrylicForced3.mat'); clc;

plateT3 = tempPlateC;
ambT3 = tempAmbC;

[max1, ind1] = max(plateT1);
[max2, ind2] = max(plateT2);
[max3, ind3] = max(plateT3);

T1 = plateT1(ind1: end);
T1_amb = ambT1(ind1:end);
T2 = plateT2(ind2: end);
T2_amb = ambT2(ind2:end);
T3 = plateT3(ind3: end);
T3_amb = ambT3(ind3:end);

len(1) = length(T1);
len(2) = length(T2);
len(3) = length(T3);

minlen = min(len);

T(1, :) = T1(1:minlen);
T(2, :) = T2(1:minlen);
T(3, :) = T3(1:minlen);

theta(1, :) = (T1(1:minlen)-T1_amb(1:minlen))./(T1(1)-T1_amb(1:minlen));
theta(2, :) = (T2(1:minlen)-T2_amb(1:minlen))./(T2(1)-T2_amb(1:minlen));
theta(3, :) = (T3(1:minlen)-T3_amb(1:minlen))./(T3(1)-T3_amb(1:minlen));

avgTheta_AcyForced = mean(theta);

avgT_AcyForced = mean(T);
clear T;
clear theta;

%% Metal Free

load('lab6MetalFree1.mat'); clc;

plateT1 = tempPlateC;
ambT1 = tempAmbC;

load('lab6MetalFree2.mat'); clc;

plateT2 = tempPlateC;
ambT2 = tempAmbC;

load('lab6MetalFree3.mat'); clc;

plateT3 = tempPlateC;
ambT3 = tempAmbC;

[max1, ind1] = max(plateT1);
[max2, ind2] = max(plateT2);
[max3, ind3] = max(plateT3);

T1 = plateT1(ind1: end);
T1_amb = ambT1(ind1:end);
T2 = plateT2(ind2: end);
T2_amb = ambT2(ind2:end);
T3 = plateT3(ind3: end);
T3_amb = ambT3(ind3:end);

len(1) = length(T1);
len(2) = length(T2);
len(3) = length(T3);

minlen = min(len);

T(1, :) = T1(1:minlen);
T(2, :) = T2(1:minlen);
T(3, :) = T3(1:minlen);

theta(1, :) = (T1(1:minlen)-T1_amb(1:minlen))./(T1(1)-T1_amb(1:minlen));
theta(2, :) = (T2(1:minlen)-T2_amb(1:minlen))./(T2(1)-T2_amb(1:minlen));
theta(3, :) = (T3(1:minlen)-T3_amb(1:minlen))./(T3(1)-T3_amb(1:minlen));

avgTheta_MetalFree = mean(theta);

avgT_MetalFree = mean(T);
clear T;
clear theta;

%% MetalForced

load('lab6MetalForced1.mat'); clc;

plateT1 = tempPlateC;
ambT1 = tempAmbC;

load('lab6MetalForced2.mat'); clc;

plateT2 = tempPlateC;
ambT2 = tempAmbC;

load('lab6MetalForced3.mat'); clc;

plateT3 = tempPlateC;
ambT3 = tempAmbC;

[max1, ind1] = max(plateT1);
[max2, ind2] = max(plateT2);
[max3, ind3] = max(plateT3);

ind1 = ind1+7;
ind2 = ind2+6;
ind3 = ind3+6;


T1 = plateT1(ind1: end);
T1_amb = ambT1(ind1:end);
T2 = plateT2(ind2: end);
T2_amb = ambT2(ind2:end);
T3 = plateT3(ind3: end);
T3_amb = ambT3(ind3:end);

len(1) = length(T1);
len(2) = length(T2);
len(3) = length(T3);

minlen = min(len);

T(1, :) = T1(1:minlen);
T(2, :) = T2(1:minlen);
T(3, :) = T3(1:minlen);

theta(1, :) = (T1(1:minlen)-T1_amb(1:minlen))./(T1(1)-T1_amb(1:minlen));
theta(2, :) = (T2(1:minlen)-T2_amb(1:minlen))./(T2(1)-T2_amb(1:minlen));
theta(3, :) = (T3(1:minlen)-T3_amb(1:minlen))./(T3(1)-T3_amb(1:minlen));

avgTheta_MetalForced = mean(theta);

avgT_MetalForced = mean(T);
clear T;
clear theta;


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

    


figure(2);

y1 = log(avgTheta_AcyFree);
y2 = log(avgTheta_AcyForced);
y3 = log(avgTheta_MetalFree);
y4 = log(avgTheta_MetalForced);

x1 = 1:length(y1);
x2 = 1:length(y2);
x3 = 1:length(y3);
x4 = 1:length(y4);

subplot(2, 1, 1);
plot(y1, 'b--'); hold on;
plot(y2, 'g-.'); hold on;
plot(y3, 'r:'); hold on;
plot(y4, 'k-'); hold on;
xlabel('Time (s)'); ylabel('Ln(Theta)');
legend('Acrylic Free', 'Acrylic Forced', 'Metal Free', 'Metal Forced');

subplot(2, 1, 2);

f1 = polyfit(x1, y1, 1);
f2 = polyfit(x2, y2, 1);
f3 = polyfit(x3, y3, 1);
f4 = polyfit(x4, y4, 1);

rho_a = 1180; c_a = 2000; k_a = 0.2;
rho_m = 2707; c_m = 879; k_m = 204; L = 0.00041;


h1 = -f1(1)*rho_a*L*c_a;
h2 = -f2(1)*rho_a*L*c_a;
h3 = -f3(1)*rho_m*L*c_m;
h4 = -f4(1)*rho_m*L*c_m;

Bi1 = h1*L/k_a;
Bi2 = h2*L/k_a;
Bi3 = h3*L/k_m;
Bi4 = h4*L/k_m;



plot(x1, f1(1)*x1 + f1(2),'b--'); hold on;
plot(x2, f2(1)*x2 + f2(2), 'g-.'); hold on;
plot(x3, f3(1)*x3 + f3(2), 'r:'); hold on;
plot(x4, f4(1)*x4 + f4(2), 'k-'); hold on;
xlabel('Time (s)'); ylabel('Ln(Theta)');
legend('Acrylic Free', 'Acrylic Forced', 'Metal Free', 'Metal Forced');
