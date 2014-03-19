path(path, '../p45');
% path(path, '../p43');
p45;
close all;
width = 1;
%%
noiseState = sprintf('proNoiseScalar = %.1f, obsNoiseScalar = %.1f',...
   proNoiseScalar, obsNoiseScalar);
%% Innovation and innovation SD
s = 1 : step;
sigmaYx = sqrt(reshape(SigmaInnov(1,1,s),1,[]));
sigmaYy = sqrt(reshape(SigmaInnov(2,2,s),1,[]));
figure('Name', 'Innovation and innovation SD',...
    'units','normalized', 'outerposition',[0 0 1 1])
hold on; box on; 
subplot(2, 1, 1)
grid minor;
h = plot(s, innov(1, s), 'b-',...
         s, sigmaYx, 'r-',...
         s, 2 * sigmaYx, 'c-',...
         s, 3 * sigmaYx, 'g-',...
         s, -sigmaYx, 'r-',...
         s, -2 * sigmaYx, 'c-',...
         s, -3 * sigmaYx, 'g-');
set(h, 'linewidth', width);
xlim([min(s), max(s)]);
idx = floor(length(s)*0.5) : length(s);
ylim(max(sigmaYx(s(idx))) * 7 * [-1, +1]);
hLeg = legend('Y_{x}', '1-\sigma', '2-\sigma', '3-\sigma');
set(hLeg, 'location', 'south', 'orientation', 'horizontal');
ylabel('(m)');
title({noiseState,'Innoviation and its SD in x'});
%
subplot(2, 1, 2)
grid minor;
h = plot(s, innov(2, s), 'b-',...
         s, sigmaYy, 'r-',...
         s, 2 * sigmaYy, 'c-',...
         s, 3 * sigmaYy, 'g-',...
         s, -sigmaYy, 'r-',...
         s, -2 * sigmaYy, 'c-',...
         s, -3 * sigmaYy, 'g-');
set(h, 'linewidth', width);
xlim([min(s), max(s)]);
ylim(max(sigmaYx(s(idx))) * 10 * [-1, +1]);
hLeg = legend('Y_{y}', '1-\sigma ', '2-\sigma', '3-\sigma');
set(hLeg, 'location', 'south', 'orientation', 'horizontal');
ylabel('(m)');
title({noiseState,'Innoviation and its SD in y'});
print('-dpng', 'innovandsigma.png');
%% Normalized innovation squared
s = 1 : step;
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
s = 1 : step;
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