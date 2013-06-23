% The linear information filter demo with CV model.
% It is modified from p39, the LKF demo.

clear all; clc; close all;
path(path, '../p16'); % For calling getSigmaEllipse
path(path, '../p39'); % For calling simTruthCV
rng(123); % Control random number generation
%%
visualize    = 0;
%%
dt           = 1;
step         = 100;
xInit        = [1, 1, 1, 0.8]';
OmegaInit    = 1e-9 * eye(4);
xLen         = length(xInit);
%% Tune noises
proNoiseScalar = 1.0;
obsNoiseScalar = 1.0;
%% Process noise for filter
sigmaVxNoise = 0.01;
sigmaVyNoise = 0.01;
Q  = (proNoiseScalar * [sigmaVxNoise, 0;  0, sigmaVyNoise]).^2;
%% Measurement noise for filter
sigmaXNoise  = 0.1;
sigmaYNoise  = 0.1; 
R  = (obsNoiseScalar * diag([sigmaXNoise, sigmaYNoise])).^2;
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
xiPred           = zeros(xLen, step);
xiPred(:,1)      = OmegaInit * xInit; % \xi = \Omega * \mu
OmegaPred        = zeros(xLen, xLen, step);
OmegaPred(:,:,1) = OmegaInit;
xiPost           = zeros(xLen, step);
OmegaPost        = zeros(xLen, xLen, step);
muPost           = zeros(xLen, step);
muPost(:, 1)     = xInit;
zRows            = size(zTrue, 1);
timePredLIF      = zeros(1, step);
timeUpdateLIF    = zeros(1, step);

%% Linear information filtering main loop
xi               = OmegaInit * xInit;
Omega            = OmegaInit;

for i = 1 : step
    if i ~= 1
        predStart = tic;
        [xi, Omega] = predictLIF(xi, Omega, F, Q, 'processNoiseMat', E);
        timePredLIF(i) = toc(predStart);
        xiPred(:,i)      = xi;
        OmegaPred(:,:,i) = Omega;
%         muPred = Omega \ xi
    end
    updateStart = tic;
    [xi, Omega] = updateLIF(xi, Omega, zTrue(:,i), H, R);
    timeUpdateLIF(i) = toc(updateStart);
    xiPost(:,i)      = xi;
    OmegaPost(:,:,i) = Omega;
    %% State recovery
    muPost(:,i)      = Omega \ xi;
end

%% The animation is implemented in a separated script
if visualize
    p66.animation;
end
