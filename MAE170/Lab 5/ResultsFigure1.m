clear all; close all;

load('lab5pt2.mat');

%%

reference = recMatrix_ref;
signals = recMatrix_sig;
signals(:, 1, 15) = signals(:, 1, 14);
x = (1:588)/100;

figure(1);
subplot(2, 1, 1);
plot(x, reference(:, 3, 3), 'r-'); hold on;
xlabel('Time (ms)'); ylabel('Speaker Reference Voltage (V)');
subplot(2, 1, 2);
plot(x, signals(:, 3, 3), 'b-'); hold on;
xlabel('Time (ms)'); ylabel('Microphone Voltage Readings (V)');