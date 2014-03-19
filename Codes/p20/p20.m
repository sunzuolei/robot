close all; clc; clear all;
path(path, genpath('../p17'));
path(path, genpath('../p19'));

x  = -100:0.001:100; 

prior         = gaussian1d(2, 1, x); % a Gaussian Prior of mean 2 and SD 1
motionModel   = gaussian1d(1, 2, x);    % a Gaussian motion model of mean 1 and SD 2
sensorModel   = gaussian1d(5, 1, x);    % a Gaussian observation model of mean 5 and SD 1

probAfterMove  = convolute1d(motionModel, prior, x);      % prediction is convolution
probAfterSense = product1d(sensorModel, probAfterMove, x); % update is multiplication
%%
[muAfterMove, sdAfterMove]   = convolute1dParam(2, 1, 1, 2);
[muAfterSense, sdAfterSense] = product1dParam(...
                                muAfterMove, sdAfterMove, 5, 1);

probAfterMoveParam  = gaussian1d(muAfterMove, sdAfterMove, x);
probAfterSenseParam = gaussian1d(muAfterSense, sdAfterSense, x);

%%
probAfterSenseParamSeq = product1d(sensorModel, probAfterMoveParam, x); 
%%
h = figure('name','Bayes filtering');
set(h, 'position', get(0,'ScreenSize'));
subplot(2, 1, 1);
hold on;
box on;
grid minor;
plot(x, probAfterMove, 'r-', 'linewidth', 6);
plot(x, probAfterMoveParam, 'g:', 'linewidth', 3);
legend('Predicted prob', sprintf('Predicted prob \n with params'));
title('Bayes filtering (Prediction)')
ylabel('Probability');
ylim([0, 0.2]);
xlim([-5, 10]);

subplot(2, 1, 2);
hold on;
box on;
grid minor;
title('Update')
plot(x, probAfterSense, 'k-', 'linewidth', 6);
plot(x, probAfterSenseParam, 'c-', 'linewidth', 2);
plot(x, probAfterSenseParamSeq, 'y-', 'linewidth', 2);
legend('Posterior', 'Posterior with params as input and output',...
    'Posterior with params as input', 'Location', 'NorthWest');
ylabel('Probability');
ylim([0, 0.5]);
xlim([-5, 10]);
print('-dpng', 'bayesfilterwithparams.png');