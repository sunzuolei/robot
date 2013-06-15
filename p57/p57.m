%% The EKF demo with nolinear motion and sensor models.
close all; clear all; clc;
path(path, '../p34');           % For calling piTopi
path(path, genpath('../p22'));  % For calling compound
path(path, '../p49');
path(path, genpath('../p54'));  % For calling models and simtruth
rng(853); % Control random number generation
%%
enableVis = 0;
makeVideo = 0;
%%
load '../data/rose.mat'
clear laser;
relMotion = relMotion(:, 250:5:2400) * 7; % Only use a part of the data.
% relMotion = relMotion(:, 1 : 300);
step      = size(relMotion, 2);   
meanRel   = mean(abs(relMotion), 2);% 2250
meanRel(3)= radtodeg(meanRel(3));
disp(meanRel);
rob = [0 -3 -3; 0 -1 1] * 0.3;
%%
xInit        = [0, 0, 0]';
SigmaInit    = diag([0.1, 0.1, degtorad(0.01)].^2);
xLen         = length(xInit);
%%
sensorPos    = [1.5, 3];
%% Tune noises
proNoiseScalar = 1.0;
obsNoiseScalar = 1.0;
%% Process noise sigma
sigmaXNoise    = 0.01;
sigmaYNoise    = 0.01;
sigmaThetaNoise = degtorad(0.01);
Q  = diag(proNoiseScalar * ...
    [sigmaXNoise, sigmaXNoise, sigmaXNoise]).^2;
%% Measurement noise sigma
sigmaBNoise  = degtorad(0.1);
sigmaRNoise  = 0.1;
R  = diag(obsNoiseScalar * [sigmaBNoise, sigmaRNoise]).^2;
%% Noise for simulating truths
% NOTE: the simQ and simR can be different from Q and R!!
simQ =  diag([sigmaXNoise, sigmaXNoise, sigmaXNoise]).^2;
simR =  diag([sigmaBNoise, sigmaRNoise]).^2;
%%
[xTrue, zTrue] = p54.simTruth(xInit, @p54.motionModel, relMotion, simQ,...
    @p57.sensorModel, sensorPos, simR, step);

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
        u = relMotion(:, i-1);
        F = p54.jacobF(mu, u);
        [mu, Sigma] = predictEKF(mu, Sigma, u,...
        @p54.motionModel, F, Q);
        muPred(:,i)      = mu;
        SigmaPred(:,:,i) = Sigma;
    end
    H = p57.jacobH(mu, sensorPos);
    [mu, Sigma, innov(:,i), SigmaInnov(:,:,i)] =...
        updateEKF(mu, Sigma, @p57.sensorModel, sensorPos,...
        zTrue(:,i), H, R, true, 1);
    muPost(:,i)      = mu;
    SigmaPost(:,:,i) = Sigma;
end
toc;
%%
if enableVis 
    h = p57.initFigure(xTrue, muPost, sensorPos);
    if makeVideo
        videoObj           = VideoWriter('bearingrangeekfdemo.avi');
        videoObj.FrameRate = 5;
        videoObj.Quality   = 50;
        open(videoObj);
    end
    for i = 1 : step
            [xEnd,yEnd] = pol2cart(zTrue(1, i),zTrue(2, i));
            set(h.trueObs, 'xdata', [sensorPos(1),xEnd + sensorPos(1)],...
                           'ydata', [sensorPos(2),yEnd + sensorPos(2)]);
            set(h.truePat, 'xdata', xTrue(1, 1:i), 'ydata', xTrue(2, 1:i));
            set(h.predPat, 'xdata', muPred(1, 1:i), 'ydata', muPred(2, 1:i));
            set(h.postPat, 'xdata', muPost(1, 1:i), 'ydata', muPost(2, 1:i));
            %%
            trueRobBody     = compound(xTrue(:,i), rob);
            set(h.trueRob, 'xdata', trueRobBody(1, :), ...
                'ydata', trueRobBody(2, :));
            %
            predRobBody     = compound(muPred(:,i),rob);
            set(h.predRob, 'xdata', predRobBody(1, :), ...
                'ydata', predRobBody(2, :));
            %
            postRobBody     = compound(muPost(:,i),rob);
            set(h.postRob, 'xdata', postRobBody(1, :), ...
                'ydata', postRobBody(2, :));
            drawnow;
            if mod(i, 5) == 0 && makeVideo
                writeVideo(videoObj, getframe(h.all));
            end
    %         pause(0.2);
    end
    if makeVideo
        close(videoObj);
    end
end