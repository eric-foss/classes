close all; clear all; clc;

figure(1);


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

theta(1, :) = (T1(1:minlen)-T1_amb(1:minlen))./(T1(1)-T1_amb(1:minlen));
theta(2, :) = (T2(1:minlen)-T2_amb(1:minlen))./(T2(1)-T2_amb(1:minlen));
theta(3, :) = (T3(1:minlen)-T3_amb(1:minlen))./(T3(1)-T3_amb(1:minlen));

avgTheta_AcyFree = mean(theta);

