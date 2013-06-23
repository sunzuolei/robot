close all; clear all; clc;
%%
path(path, '../p39'); % For LKF demo
path(path, '../p66'); % For LIF demo
%%
p39 
save('lkftime.mat', 'timePredLKF', 'timeUpdateLKF');
%%
p66 
save('liftime.mat', 'timePredLIF', 'timeUpdateLIF');
%%
clear all;
load lkftime.mat
load liftime.mat
%%
n    = length(timePredLKF);
step = 10: n;
%%
figure('units', 'normalized', 'outerposition',[0 0 1 1]);
hold on;
box on; 
grid off;
subplot(3, 1, 1)
plot(step, timePredLKF(step), 'bo-', step, timePredLIF(step), 'r*-');
legend('LKF', 'LIF');
xlim([min(step), max(step)]);
ylabel('Time (s)');
title('Elapsed time of prediction')
%
subplot(3, 1, 2)
plot(step, timeUpdateLKF(step), 'bo-', step, timeUpdateLIF(step), 'r*-');
legend('LKF', 'LIF');
xlim([min(step), max(step)]);
ylabel('Time (s)');
title('Elapsed time of update')
%
subplot(3, 1, 3)
plot(step, timeUpdateLKF(step) + timePredLKF(step), 'bo-', ...
     step, timeUpdateLIF(step) + timePredLIF(step), 'r*-');
legend('LKF', 'LIF');
xlim([min(step), max(step)]);
ylabel('Time (s)');
xlabel('Step');
title('Elapsed time of whole filtering')
%%
print('-dpng', 'elapsedtime.png');