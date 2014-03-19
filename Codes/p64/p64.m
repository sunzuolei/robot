%% Particle filtering demo with the same models as p54
close all; clear all; clc;
% dbstop if error;
path(path, '../p34');           % For calling piTopi
path(path, genpath('../p22'));  % For calling compound
path(path, genpath('../p54'));  % For models and truth generator.
path(path, genpath('../p57'));  % For sensor model.
path(path, genpath('../p61'));  % For PF framework.
rng('default');                 % Reinitialize the random number generator
rng(853);                       % Control random number generation
%%
load '../data/rose.mat'
clear laser;
relMotion = relMotion(:, 250:8:2400) * 9; % Only use a part of the data.
step      = size(relMotion, 2);   
meanRel   = mean(abs(relMotion), 2);
meanRel(3)= radtodeg(meanRel(3));
disp(meanRel);

%%
m      = 1000;  
% ptSize = 30;
vis    = true;
%%
ptInit       = zeros(3, m);
ptInit(1,:)  = arbitraryRand(1, m, -10, 10);
ptInit(2,:)  = arbitraryRand(1, m, -10,  10);
ptInit(3,:)  = arbitraryRand(1, m,  -pi/5, pi/5);
wInit        = ones(1, m) / m;
% %%
% figure(1)
% scatter(ptInit(1,:), ptInit(2, :), ptSize, wInit, 'fill');
%%
xInit        = [0, 0, 0]';
SigmaInit    = diag([0.1, 0.1, degtorad(0.01)].^2);
xLen         = length(xInit);
%%
% sensorPos    = [2, 10];
sensorPos    = [8, 4];
%% Tune noises
proNoiseScalar = 3.0;
obsNoiseScalar = 1.0;
%% Process noise sigma
sigmaXNoise    = 0.01;
sigmaYNoise    = 0.01;
sigmaThetaNoise = degtorad(0.01);
Q  = diag(proNoiseScalar * ...
    [sigmaXNoise, sigmaXNoise, sigmaXNoise]).^2;
%% Measurement noise sigma
sigmaBNoise  = degtorad(0.9);
sigmaRNoise  = 0.1;
R  = diag(obsNoiseScalar * [sigmaBNoise, sigmaRNoise]).^2;
%% Noise for simulating truths
% NOTE: the simQ and simR can be different from Q and R!!
simQ =  diag([sigmaXNoise, sigmaXNoise, sigmaXNoise]).^2;
simR =  diag([sigmaBNoise, sigmaRNoise]).^2;
%% Assign memory
ptPredAll        = zeros(xLen, m, step);
ptPredAll(:,:,1) = ptInit;
ptPostAll        = zeros(xLen, m, step);
wAll             = zeros(step, m);
ptMeanPost       = zeros(xLen, step);
%%
[xTrue, zTrue] = p54.simTruth(xInit, @p54.motionModel, relMotion, simQ,...
    @p57.sensorModel, sensorPos, simR, step);
%% PF loop
pt = ptInit;
mu = xInit;
w  = wInit;
tic;
for i = 1 : step
    if i ~= 1
        %% Prediction
        u = relMotion(:, i-1);
        for iPt = 1 : m
            ptPredAll(:, iPt, i) = p54.motionModel(pt(:, iPt), u)...
                + sqrt(Q) * randn(xLen, 1);
        end
        pt = ptPredAll(:, :, i);
    end
    
    %% Update
    z = zTrue(:, i);
    for iPt = 1 : m        
        zPred    = p57.sensorModel(pt(:, iPt), sensorPos);
        w(iPt)   = compWeight(zPred, z, R, true, 1);
    end
    
    wAll(i, :)         = w;
    resIdx             = resampleParticle(w);
    pt                 = pt(:, resIdx);
    ptPostAll(:,:,i)   = pt; 
    ptMeanPost(1:2, i) = mean( pt(1:2,:), 2);
    ptMeanPost(3, i)   = meanAngle( pt(3, :) );
end
elapsedTime = toc;
%% Log data
if exist('./data', 'dir') == 0
   mkdir('./data'); 
end
dataName = sprintf('./data/rangbearing%dparticles.mat', m);
save( dataName, 'm', 'step', 'ptPostAll', 'ptMeanPost', 'wAll',...
    'zTrue', 'xTrue', 'sensorPos', 'ptInit', 'wInit', 'elapsedTime');
%%
if vis 
    p64.visualizeDemo;
end
