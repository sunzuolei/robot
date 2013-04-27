close all; clc; clear all;
path(path, genpath('../p17'));

x  = -10:0.01:10; 

prior         = gaussian1d(2, 1, x); % a Gaussian Prior of mean 2 and variance 1
motionModel   = gaussian1d(1, 2, x);    % a Gaussian motion model of mean 1 and variance 2
sensorModel   = gaussian1d(5, 1, x);    % a Gaussian observation model of mean 5 and variance 1

probAfterMove  = convolute1d(motionModel, prior, x);      % prediction is convolution
probAfterSense = product1d(sensorModel, probAfterMove, x); % update is multiplication

%%
h = figure('name','Bayes filtering');
set(h, 'position', get(0,'ScreenSize'));
subplot(2, 1, 1);
hold on;
box on;
grid minor;
plot(x, prior, 'b-', 'linewidth', 2);
plot(x, motionModel, 'g-', 'linewidth', 2);
plot(x, probAfterMove, 'r-', 'linewidth', 2);
legend('Prior', 'Motion model', 'Predicted prob')
title('Bayes filtering (Prediction)')
ylabel('Probability');
ylim([0, 0.5]);

subplot(2, 1, 2);
hold on;
box on;
grid minor;
title('Update')
plot(x, probAfterMove, 'r-', 'linewidth', 2);
plot(x, sensorModel, 'c-', 'linewidth', 2);
plot(x, probAfterSense, 'k-', 'linewidth', 2);
legend('Predicted prob',  'Sensor model', 'Posterior',...
    'Location', 'NorthWest');
ylabel('Probability');
ylim([0, 0.5]);
print('-dpng', 'bayesfiltering.png');