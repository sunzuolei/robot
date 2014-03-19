% Check the steady-state performance on SD.
path(path, '../p39');
close all; clear all; clc;
width = 1;
%%
rng(123); % Control random number generation
%%
dt           = 1;
step         = 100;
xInit        = [0, 4, 0, 2]';
xLen         = length(xInit);
%% Process noise for filter
sigmaVxNoise = 0.1;
sigmaVyNoise = 0.3;
Q  = (1.0 * [sigmaVxNoise, 0;  0, sigmaVyNoise]).^2;
%% Measurement noise for filter
sigmaXNoise  = 0.8;
sigmaYNoise  = 0.9;
R  = (1 * diag([sigmaXNoise, sigmaYNoise])).^2;
%% Noise for simulating truths
% NOTE: the simQ and simR can be different from Q and R!!
simQ =  diag([sigmaVxNoise,sigmaVxNoise].^2);
simR =  diag([sigmaXNoise,  sigmaYNoise].^2);

%% SD of states
s              = 1 : 30;
figure('Name', 'standard deviation for different initial covariance',...
    'units','normalized', 'outerposition',[0 0 1 1],...
    'color', 'w')
%% ==================================================
SigmaInit      = 2^2 * eye(4);
mainLoop;
sigmaXXPost    = sqrt(reshape(SigmaPost(1,1,:),1,[]));
sigmaVxVxPost  = sqrt(reshape(SigmaPost(2,2,:),1,[]));
%
hFigTop        = subplot(1, 2, 1);
hPlotTop(1)    = plot(s, sigmaXXPost(s), 'r-');
title('SD in x');
hold on;
box on;
xlim([min(s), max(s)]);
%
hFigBtm        = subplot(1, 2, 2);
hPlotBtm(1)    = plot(s, sigmaVxVxPost(s), 'r-');
title('SD in Vx');
hold on;
box on;
xlim([min(s), max(s)]);
%% ==================================================
SigmaInit      = 0.2^2 * eye(4);
clear SigmaPost sigmaXXPost sigmaVxVxPost;
mainLoop;
sigmaXXPost    = sqrt(reshape(SigmaPost(1,1,:),1,[]));
sigmaVxVxPost  = sqrt(reshape(SigmaPost(2,2,:),1,[]));
subplot(hFigTop);
hPlotTop(2)    = plot(s, sigmaXXPost(s), 'b-');
subplot(hFigBtm);
hPlotBtm(2)    = plot(s, sigmaVxVxPost(s), 'b-');
%% ==================================================
SigmaInit      = 4^2 * eye(4);
clear SigmaPost sigmaXXPost sigmaVxVxPost;
mainLoop;
sigmaXXPost    = sqrt(reshape(SigmaPost(1,1,:),1,[]));
sigmaVxVxPost  = sqrt(reshape(SigmaPost(2,2,:),1,[]));
subplot(hFigTop);
hPlotTop(3)    = plot(s, sigmaXXPost(s), 'g-');
subplot(hFigBtm);
hPlotBtm(3)    = plot(s, sigmaVxVxPost(s), 'g-');
%% ==================================================
SigmaInit      = 8^2 * eye(4);
clear SigmaPost sigmaXXPost sigmaVxVxPost;
mainLoop;
sigmaXXPost    = sqrt(reshape(SigmaPost(1,1,:),1,[]));
sigmaVxVxPost  = sqrt(reshape(SigmaPost(2,2,:),1,[]));
subplot(hFigTop);
hPlotTop(4)    = plot(s, sigmaXXPost(s), 'c-');
subplot(hFigBtm);
hPlotBtm(4)    = plot(s, sigmaVxVxPost(s), 'c-');
%% ==================================================
SigmaInit      = 0 * eye(4);
clear SigmaPost sigmaXXPost sigmaVxVxPost;
mainLoop;
sigmaXXPost    = sqrt(reshape(SigmaPost(1,1,:),1,[]));
sigmaVxVxPost  = sqrt(reshape(SigmaPost(2,2,:),1,[]));
subplot(hFigTop);
hPlotTop(5)    = plot(s, sigmaXXPost(s), 'k-');
subplot(hFigBtm);
hPlotBtm(5)    = plot(s, sigmaVxVxPost(s), 'k-');
%% ==================================================
SigmaInit      = 0.4^2 * eye(4);
clear SigmaPost sigmaXXPost sigmaVxVxPost;
mainLoop;
sigmaXXPost    = sqrt(reshape(SigmaPost(1,1,:),1,[]));
sigmaVxVxPost  = sqrt(reshape(SigmaPost(2,2,:),1,[]));
subplot(hFigTop);
hPlotTop(6)    = plot(s, sigmaXXPost(s), 'y-');
subplot(hFigBtm);
hPlotBtm(6)    = plot(s, sigmaVxVxPost(s), 'y-');
%% ==================================================
SigmaInit      = 20^2 * eye(4);
clear SigmaPost sigmaXXPost sigmaVxVxPost;
mainLoop;
sigmaXXPost    = sqrt(reshape(SigmaPost(1,1,:),1,[]));
sigmaVxVxPost  = sqrt(reshape(SigmaPost(2,2,:),1,[]));
subplot(hFigTop);
hPlotTop(7)    = plot(s, sigmaXXPost(s), 'm-');
legend(hPlotTop, '\sigma_0 = 2', '\sigma_0 = 0.2', '\sigma_0 = 4',...
    '\sigma_0 = 8', '\sigma_0 = 0', '\sigma_0 = 0.4', '\sigma_0 = 20');
subplot(hFigBtm);
hPlotBtm(7)    = plot(s, sigmaVxVxPost(s), 'm-');
legend(hPlotBtm, '\sigma_0 = 2', '\sigma_0 = 0.2', '\sigma_0 = 4',...
    '\sigma_0 = 8', '\sigma_0 = 0', '\sigma_0 = 0.4', '\sigma_0 = 20');
%%
print('-dpng', 'steadysigma.png');