clear all; clc; close all;
path(path, '../p39');
path(path, '../p44');
rng('default');
rng(123); % Control random number generation

%%
enableVis    = false;
%%
step         = 300;
stEdge       = 10;
v            = 3;
dt           = 1;
xInit        = [0, 0, 0, 0]';
SigmaInit    = 1^2 * eye(4);
xLen         = length(xInit);
%% Tune noises
proNoiseScalar = 1.0;
obsNoiseScalar = 1.0;
%% Process noise sigma
sigmaCxNoise = 0.1;
sigmaCyNoise = 0.1;
Q  = (proNoiseScalar * [sigmaCxNoise, 0;  0, sigmaCyNoise]).^2;
%% Measurement noise sigma
sigmaXNoise  = 0.3;
sigmaYNoise  = 0.3; 
R  = (obsNoiseScalar * diag([sigmaXNoise, sigmaYNoise])).^2;
%% Noise for simulating truths
% NOTE: the simQ and simR can be different from Q and R!!
simQ =  diag([sigmaCxNoise,sigmaCxNoise].^2);
simR =  diag([sigmaXNoise,  sigmaYNoise].^2);
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
H = [1, 0, 0, 0;
     0, 0, 1, 0];

%% 
u                = simControlSqaure(step, stEdge, v);
[xTrue, zTrue]   = simTruthSqaure(xInit, F, B, u, E, simQ, H, simR, step);

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
        [mu, Sigma] = predictLKF(mu, Sigma, F, Q, ...
            'processNoiseMat', E, 'controlMat', B,...
            'control', u(:, i));
        muPred(:,i)      = mu;
        SigmaPred(:,:,i) = Sigma;
    end
    [mu, Sigma, innov(:,i), SigmaInnov(:,:,i)] =...
        updateLKF(mu, Sigma, zTrue(:,i), H, R);
    muPost(:,i)      = mu;
    SigmaPost(:,:,i) = Sigma;
end
toc;
%% Visualization
if enableVis
    videoObj           = VideoWriter('squarelkf.avi');
    videoObj.FrameRate = 5;
    videoObj.Quality   = 100;
    open(videoObj);

    h = initFigure(zTrue, xTrue);
    for i = 1 : step
        set(h.trueObs, 'xdata', zTrue (1, 1:i), 'ydata', zTrue (2, 1:i));
        set(h.predPat, 'xdata', muPred(1, 1:i), 'ydata', muPred(3, 1:i));
        set(h.postPat, 'xdata', muPost(1, 1:i), 'ydata', muPost(3, 1:i));
        set(h.predRob, 'xdata', muPred(1, i),   'ydata', muPred(3, i));
        set(h.postRob, 'xdata', muPost(1, i),   'ydata', muPost(3, i));
        drawnow;
        frame = getframe(h.all);
        writeVideo(videoObj, frame);
        pause(0.05);
    end
    close(videoObj);
    print('-dpng', 'squarelkf.png');
end