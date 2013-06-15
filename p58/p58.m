clear all; close all; clc;
path(path, '../p57');
path(path, '../p43');
p57;
width = 1;
%%
noiseState = sprintf('proNoiseScalar = %.1f, obsNoiseScalar = %.1f',...
   proNoiseScalar, obsNoiseScalar);
%% Innovation and innovation SD
s = 1 : step;
sigmaYb = sqrt(reshape(SigmaInnov(1, 1, s),1,[]));
figure('Name', 'Innovation and innovation SD',...
    'units','normalized', 'outerposition',[0 0 1 1])
hold on; box on; 
grid minor;
h = plot(s, innov(1, s), 'b-',...
         s, sigmaYb, 'r-',...
         s, 2 * sigmaYb, 'c-',...
         s, 3 * sigmaYb, 'g-',...
         s, -sigmaYb, 'r-',...
         s, -2 * sigmaYb, 'c-',...
         s, -3 * sigmaYb, 'g-');
set(h, 'linewidth', width);
xlim([min(s), max(s)]);
idx = floor(length(s)*0.5) : length(s);
ylim(max(sigmaYb(s(idx))) * 7 * [-1, +1]);
hLeg = legend('Y', '1-\sigma', '2-\sigma', '3-\sigma');
set(hLeg, 'location', 'south', 'orientation', 'horizontal');
ylabel('(m)');
title({noiseState,'Innoviation and its SD'});
print('-dpng', 'innovandsigma.png');
%% Normalized innovation squared
[normY, meanY, chiUp, chiLow] ...
    = chiSquareTest(innov, SigmaInnov, 'movingAverage');

figure('Name', 'Innovation analysis',...
    'units','normalized', 'outerposition',[0 0 1 1]);
hold on; box on;
grid minor;
h = plot(s, normY, 'g-', s, meanY, 'r-',...
         s, chiUp, 'b-', s, chiLow, 'b-');
set(h, 'linewidth', width);
legend('Normalised innovations squared',...
'Mean of the normalised innovations',...
    '95% Confidence bounds');
title({noiseState,...
    'Normalised Innovations and Innovation Confidence Interval'});
xlim([min(s), max(s)]);
ylabel('Normalised innovations');
print('-dpng', 'innovationchitest.png');

%% Normalised state estimation error square
[p, meanP, chiUp, chiLow] ...
    = chiSquareTest(muPost - xTrue, SigmaPost, 'batch');
figure('Name', 'Consistency check using ture state',...
    'units','normalized', 'outerposition',[0 0 1 1]);
hold on; box on;
grid minor;
h = plot(s, p, 'g-', s, meanP, 'r-',...
         s, chiUp, 'b-', s, chiLow, 'b-');
set(h, 'linewidth', width);
legend('Normalised state estimation error square','Mean',...
    '95% Confidence bounds');
title({noiseState, ...
    'Normalised State Estimation Error Square and Confidence Interval'});
xlim([min(s), max(s)]);
ylabel('Normalised State Estimation Error Square');
print('-dpng', 'normlisedstateerror.png');