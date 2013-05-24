clear all; clc; close all;
path(path, '../p16');
rng(555); % Control random number generation
%%
dt           = 1;
step         = 100;
xInit        = [0, 4, 0, 4]';
SigmaInit    = 2^2 * eye(4);
xLen         = length(xInit);
%% Process noise for filter
sigmaVxNoise = 0.01;
sigmaVyNoise = 0.01;
Q  = (1.0 * [sigmaVxNoise, 0;  0, sigmaVyNoise]).^2;
%% Measurement noise for filter
sigmaXNoise  = 0.1;
sigmaYNoise  = 0.1;
R  = (1.0 * diag([sigmaXNoise, sigmaYNoise])).^2;
%% Noise for simulating truths
% NOTE: the simQ and simR can be different from Q and R!!
simQ =  diag([sigmaVxNoise,sigmaVxNoise].^2);
simR =  diag([sigmaXNoise,  sigmaYNoise].^2);
%% Transition matrices
F = [1, dt,  0,  0;
     0,  1,  0,  0;
     0,  0,  1,  dt;
     0,  0,  0,  1];
E = [dt^2/2,    0;
       dt,      0;
       0,       dt^2/2;
       0,       dt];
H = [1, 0, 0, 0;
     0, 0, 1, 0];
%% Generate truth
[xTrue, zTrue]   = simTruthCV(xInit, F, E, simQ, H, simR, step);
%% Assign memory
muPred           = zeros(xLen, step);
muPred(:,1)      = xInit;
SigmaPred        = zeros(xLen, xLen, step);
SigmaPred(:,:,1) = SigmaInit;
muPost           = zeros(xLen, step);
SigmaPost        = zeros(xLen, xLen, step);
zRows            = size(zTrue, 1);
innov            = zeros(zRows, step);
SigmaInnov       = zeros(zRows, zRows, step);

%% Filtering loop
mu               = xInit;
Sigma            = SigmaInit;
tic;
for i = 1 : step
    if i ~= 1
        [mu, Sigma] = predictLKF(mu, Sigma, F, Q, 'processNoiseMat', E);
        muPred(:,i)      = mu;
        SigmaPred(:,:,i) = Sigma;
    end
    [mu, Sigma, innov(:,i), SigmaInnov(:,:,i)] =...
        updateLKF(mu, Sigma, zTrue(:,i), H, R);
    muPost(:,i)      = mu;
    SigmaPost(:,:,i) = Sigma;
end
toc;
%% The animation is implemented in a separated script
% animation
