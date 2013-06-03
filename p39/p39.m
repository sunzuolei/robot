clear all; clc; close all;
path(path, '../p16');
rng(123); % Control random number generation
%%
dt           = 1;
step         = 100;
xInit        = [0, 4, 0, 2]';
SigmaInit    = 1^2 * eye(4);
xLen         = length(xInit);
%% Tune noises
proNoiseScalar = 1.0;
obsNoiseScalar = 10.0;
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
%% Main loop of the LKF implemented in a separated script
mainLoop;
%% The animation is implemented in a separated script
animation
