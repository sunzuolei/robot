clear all; clc; close all;
path(path, '../p16');
rng(123); % Control random number generation
%%
dt           = 1;
step         = 100;
xInit        = [0, 4, 0, 2]';
SigmaInit    = 1^2 * eye(4);
xLen         = length(xInit);
%% Process noise for filter
sigmaVxNoise = 0.01;
sigmaVyNoise = 0.01;
Q  = (1.0 * [sigmaVxNoise, 0;  0, sigmaVyNoise]).^2;
%% Measurement noise for filter
sigmaXNoise  = 0.1;
sigmaYNoise  = 0.1; 
R  = (1 * diag([sigmaXNoise, sigmaYNoise])).^2;
%% Noise for simulating truths
% NOTE: the simQ and simR can be different from Q and R!!
simQ =  diag([sigmaVxNoise,sigmaVxNoise].^2);
simR =  diag([sigmaXNoise,  sigmaYNoise].^2);
%% Main loop of the LKF implemented in a separated script
mainLoop;
%% The animation is implemented in a separated script
% animation
