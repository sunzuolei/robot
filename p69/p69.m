%% The EIF demo with bearing-only sensor models.
close all; clear all; clc;
path(path, '../p34');           % For calling piTopi
path(path, genpath('../p22'));  % For calling compound
path(path, '../p54');           % For calling models, Jacobians and 
rng(853); % Control random number generation
%%
enableVis = 1;
makeVideo = 1;
%%
load '../data/rose.mat'
clear laser;
relMotion = relMotion(:, 250:6:2400) * 10; % Only use a part of the data.
% relMotion = relMotion(:, 1 : 300);
step      = size(relMotion, 2);   
meanRel   = mean(abs(relMotion), 2);% 2250
meanRel(3)= radtodeg(meanRel(3));
disp(meanRel);
rob = [0 -3 -3; 0 -1 1] * 0.3;
%%
xInit        = [0.1, 0.1, 0.1]';
OmegaInit    = 1e-3 * eye(3);
xLen         = length(xInit);
%%
sensorPos    = [1.5, 3];
%% Tune noises
proNoiseScalar = 1.0;
obsNoiseScalar = 1.0;
%% Process noise sigma
sigmaXNoise    = 0.001;
sigmaYNoise    = 0.001;
sigmaThetaNoise = degtorad(0.001);
Q  = diag(proNoiseScalar * ...
    [sigmaXNoise, sigmaXNoise, sigmaXNoise]).^2;
%% Measurement noise sigma
sigmaBNoise  = degtorad(0.001);
R  = (obsNoiseScalar * sigmaBNoise).^2;
%% Noise for simulating truths
% NOTE: the simQ and simR can be different from Q and R!!
simQ = diag([sigmaXNoise, sigmaXNoise, sigmaXNoise]).^2;
simR = sigmaBNoise^2;
%%
[xTrue, zTrue] = p54.simTruth(xInit, @p54.motionModel, relMotion, simQ,...
    @p54.sensorModel, sensorPos, simR, step);
%%
%% Assign memory
muPred           = zeros(xLen, step);
muPred(:,1)      = xInit;
muPost           = zeros(xLen, step);
%
xiPred           = zeros(xLen, step);
xiPred(:,1)      = OmegaInit * xInit; % \xi = \Omega * \mu
OmegaPred        = zeros(xLen, xLen, step);
OmegaPred(:,:,1) = OmegaInit;
xiPost           = zeros(xLen, step);
OmegaPost        = zeros(xLen, xLen, step);
%
zRows            = size(zTrue, 1);
timePredEIF      = zeros(1, step);
timeUpdateEIF    = zeros(1, step);

%% Filtering loop
mu               = xInit;
xi               = OmegaInit * xInit;
Omega            = OmegaInit;

for i = 1 : step
    if i ~= 1
        u = relMotion(:, i-1);
        predStart = tic;
        F = p54.jacobF(mu, u);
        [mu, xi, Omega]  = predictEIF(mu, Omega, u,...
        @p54.motionModel, F, Q);
        timePredEIF(i)   = toc(predStart);
        %
        muPred(:,i)      = mu;
        xiPred(:,i)      = xi;
        OmegaPred(:,:,i) = Omega;
    end
    H = p54.jacobH(mu, sensorPos);
    updateStart = tic;
    [mu, Omega, xi] =...
        updateEIF(mu, Omega, xi, @p54.sensorModel, sensorPos,...
        zTrue(:,i), H, R, true, 1);
    timeUpdateEIF(i)   = toc(updateStart);
    %
    muPost(:,i)        = mu;
    xiPost(:,i)        = xi;
    OmegaPost(:,:,i)   = Omega;
end

%%
if enableVis 
    h = p69.initFigure(xTrue, muPost, sensorPos);
    if makeVideo
        videoObj           = VideoWriter('eifbearingonlydemo.avi');
        videoObj.FrameRate = 5;
        videoObj.Quality   = 50;
        open(videoObj);
    end
    for i = 1 : step
            [xEnd,yEnd] = pol2cart(zTrue(i),10000);
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