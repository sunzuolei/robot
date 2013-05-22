close all; clear all; clc;
path(path, '../p16');
rng(222);               % Control random number generation to ensure the 
                        % noise can be reproduced exactly.
%%
meanXNoise  = 0;
meanYNoise  = 0;
sigmaXNoise = 0.1;
sigmaYNoise = 0.2;
numSamples  = 1000;
SigmaNoise  = [sigmaXNoise^2,       0;
                   0,          sigmaYNoise^2];
meanNoise   = [meanXNoise, meanYNoise];
randSamps  = rand(numSamples, 2);
%% Fist option
xNoise      = -sigmaXNoise + 2 * sigmaXNoise .* randSamps(:, 1);
yNoise      = -sigmaYNoise + 2 * sigmaYNoise .* randSamps(:, 2);
noise1      = [xNoise, yNoise];
%%
oneSigmaEps   = getSigmaEllipse(meanNoise, SigmaNoise, 1);
twoSigmaEps   = getSigmaEllipse(meanNoise, SigmaNoise, 2);
threeSigmaEps = getSigmaEllipse(meanNoise, SigmaNoise, 3);
%%
figure(1)
hold on;
axis equal;
plot(noise1(:, 1), noise1(:, 2),  '.g');
plot(meanNoise(1), meanNoise(2),  'xr', 'markersize', 15, 'linewidth', 3);
h(1) = plot(oneSigmaEps(1, :), oneSigmaEps(2, :), 'b-', 'linewidth', 2);
h(2) = plot(twoSigmaEps(1, :), twoSigmaEps(2, :), 'm-', 'linewidth', 2);
h(3) = plot(threeSigmaEps(1, :), threeSigmaEps(2, :), 'r-', 'linewidth', 2);
legend(h, '1-\sigma', '2-\sigma', '3-\sigma', 'location', 'best');
print('-dpng','rand.png');
