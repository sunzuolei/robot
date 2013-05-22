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
randnSamps  = randn(numSamples, 2);
%% Fist option
xNoise      = meanXNoise + sigmaXNoise .* randnSamps(:, 1);
yNoise      = meanYNoise + sigmaYNoise .* randnSamps(:, 2);
noise1      = [xNoise, yNoise];
%% Second option
noise2      = repmat(meanNoise, numSamples, 1) + ...
    repmat([sigmaXNoise, sigmaYNoise], numSamples, 1) .* randnSamps;
%% Third option
noise3      = repmat(meanNoise, numSamples, 1) + ...
    randnSamps * chol(SigmaNoise);
%% Fourth option
noise4      = repmat(meanNoise', 1, numSamples) + ...
    chol(SigmaNoise) * randnSamps';
noise4      = noise4';
%% Fifth option
noise5      = repmat(meanNoise, numSamples, 1) + ...
    randnSamps * sqrt(SigmaNoise);
%% Check the above options
disp(sum((noise1 - noise2) + ...
         (noise2 - noise3) + ...
         (noise3 - noise4) + ...
         (noise4 - noise5) )); 
%%
oneSigmaEps   = getSigmaEllipse(meanNoise, SigmaNoise, 1);
twoSigmaEps   = getSigmaEllipse(meanNoise, SigmaNoise, 2);
threeSigmaEps = getSigmaEllipse(meanNoise, SigmaNoise, 3);
%%
figure(1)
hold on;
axis equal;
plot(noise3(:, 1), noise3(:, 2),  '.g');
plot(meanNoise(1), meanNoise(2),  'xr', 'markersize', 15, 'linewidth', 3);
h(1) = plot(oneSigmaEps(1, :), oneSigmaEps(2, :), 'b-', 'linewidth', 2);
h(2) = plot(twoSigmaEps(1, :), twoSigmaEps(2, :), 'm-', 'linewidth', 2);
h(3) = plot(threeSigmaEps(1, :), threeSigmaEps(2, :), 'r-', 'linewidth', 2);
legend(h, '1-\sigma', '2-\sigma', '3-\sigma', 'location', 'best');
print('-dpng','randn.png');
