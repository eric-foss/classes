clear all; close all; clc;


%%Metal Forced Plots

%% 1

load('lab6MetalForced1.mat');
clc;

plateT1 = tempPlateC(71: end-2);
ambT1 = tempAmbC(71: end-2);

load('lab6MetalForced2.mat');
clc;

plateT2 = tempPlateC(64: end-1);
ambT2 = tempAmbC(64: end-1);

load('lab6MetalForced3.mat');
clc;

plateT3 = tempPlateC(67: end);
ambT3 = tempAmbC(67: end);


avgPlateT = (plateT1+plateT2+plateT3)/3;
avgAmbT = mean((ambT1 + ambT2 + ambT3)/3);

t = 0:length(avgPlateT)-1;

theta = (avgPlateT-avgAmbT)/(avgPlateT(1)-avgAmbT);

plot(t, log(theta), 'bo');



%figure(1);
%plot(avgPlateT, 'bo'); hold on;










%f = fit(t', plateT', 'exp1');
%plot(f, 'b-'); hold on;





