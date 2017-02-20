clear all; clc; close all;
path(path, '../p34'); % For calling piTopi
path(path, '../p39');
path(path, '../p44');
rng('default');
rng(123); % Control random number generation

enableVis    = 1;
squareMot    = 1;
%%
step         = 500;
stEdge       = 30;
v            = 6;
dt           = 1;
xInit        = [0, 0, 0, 0]';
SigmaInit    = 0.8^2 * eye(4);
xLen         = length(xInit);
%%
sensorPos    = [80, 60];
%% Tune noises
proNoiseScalar = 0.3;
obsNoiseScalar = 0.3;
%% Process noise sigma
sigmaCxNoise = 0.024;
sigmaCyNoise = 0.024;
Q  = (proNoiseScalar * [sigmaCxNoise, 0;  0, sigmaCyNoise]).^2;
%% Measurement noise sigma
sigmaBNoise  = degtorad(0.98);
R  = (obsNoiseScalar * sigmaBNoise).^2;
%% Noise for simulating truths
% NOTE: the simQ and simR can be different from Q and R!!
simQ =  diag([sigmaCxNoise,sigmaCxNoise].^2);
simR =  sigmaBNoise^2;
%% Transition matrices
F = [1, dt,  0,  0;
     0,  0,  0,  0;
     0,  0,  1,  dt;
     0,  0,  0,  0];
B = [0,  0;
     1,  0;
     0,  0;
     0,  1];
E = [dt,  0;
     1,   0;
     0,   dt;
     0,   1];
%% 
if squareMot
    u            = simControlSqaure(step, stEdge, v);
else
    u            = ones(2,step) * v; 
end
[xTrue, zTrue]   = p49.simTruth(xInit, F, B, u, E, simQ,...
    @p49.sensorModel, sensorPos, simR, step);
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
%%
%% Filtering loop
mu               = xInit;
Sigma            = SigmaInit;
tic;
for i = 1 : step
    if i ~= 1
        [mu, Sigma] = predictLKF(mu, Sigma, F, Q, ...
            'processNoiseMat', E, 'controlMat', B,...
            'control', u(:, i));
        muPred(:,i)      = mu;
        SigmaPred(:,:,i) = Sigma;
    end
    H = p49.jacobH(mu, sensorPos);
    [mu, Sigma, innov(:,i), SigmaInnov(:,:,i)] =...
        updateEKF(mu, Sigma, @p49.sensorModel, sensorPos,...
        zTrue(:,i), H, R, true, 1);
    muPost(:,i)      = mu;
    SigmaPost(:,:,i) = Sigma;
end
toc;
% Visualization
if enableVis
    videoObj           = VideoWriter('squareekf.avi');
    videoObj.FrameRate = 5;
    videoObj.Quality   = 100;
    open(videoObj);

    h = p49.initFigure(xTrue, muPost, sensorPos);
    for i = 1 : step
        [xEnd,yEnd] = pol2cart(zTrue(i),10000);
        set(h.trueObs, 'xdata', [sensorPos(1),xEnd + sensorPos(1)],...
                       'ydata', [sensorPos(2),yEnd + sensorPos(2)]);
        set(h.predPat, 'xdata', muPred(1, 1:i), 'ydata', muPred(3, 1:i));
        set(h.postPat, 'xdata', muPost(1, 1:i), 'ydata', muPost(3, 1:i));
        set(h.predRob, 'xdata', muPred(1, i),   'ydata', muPred(3, i));
        set(h.postRob, 'xdata', muPost(1, i),   'ydata', muPost(3, i));
        set(h.truePat, 'xdata', xTrue(1, 1:i), 'ydata', xTrue(3, 1:i))
        figure(h.all);
        title(['step = ', num2str(i)]);
        drawnow;
        frame = getframe(h.all);
        writeVideo(videoObj, frame);
        pause(0.05);
    end
    close(videoObj);
    print('-dpng', 'squarelkf.png');
end
