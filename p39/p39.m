clear all; clc; close all;
rng(555); % Control random number generation
%%
dt           = 0.1;
step         = 100;
xInit        = [0, 0.5, 0, 0.4]';
SigmaInit    = 0.001 * eye(4);
xLen         = length(xInit);
%% Process noise for filter
sigmaVxNoise = 0.2;
sigmaVyNoise = 0.1;
Q  = [sigmaVxNoise^2, 0;  0, sigmaVyNoise^2];
%% Measurement noise for filter
sigmaXNoise  = 0.1;
sigmaYNoise  = 0.1;
R  = [sigmaXNoise^2,  0;  0, sigmaYNoise^2];
%% Noise for simulating truths
% NOTE: the simQ and simR can be different from Q and R!!
simQ = [0.2^2, 0;  0, 0.1^2];
simR = [0.1^2, 0;  0, 0.1^2];
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
        SigmaPred(:,:,1) = Sigma;
    end
    [mu, Sigma, innov(:,i), SigmaInnov(:,:,i)] =...
        updateLKF(mu, Sigma, zTrue(:,i), H, R);
    muPost(:,i)      = mu;
    SigmaPost(:,:,i) = Sigma;
end
toc;

%% Plot the dynamic motion
figPos    = get(0, 'ScreenSize'); % [left, bottom, width, height]
figPos(3) = figPos(3) - 100;
figure('name', 'Motion animation',...
       'position', figPos,...
       'color', 'w', 'Menu', 'none');
hold on; box on; grid off;
robPlot   = plot(0, 0, 'o', 'markerfacecolor', 'g', 'markersize', 10,...
                'erasemode', 'normal');
xlabel('X(m)');
ylabel('Y(m)');
axis equal;
axis(1.1 * [min(xTrue(1, :))  max(xTrue(1, :))...
      min(xTrue(3, :))  max(xTrue(3, :))]);

for i = 1 : step
    set(robPlot,  'xdata', xTrue(1, i), 'ydata', xTrue(3, i));   
    h(2) = plot(xTrue(1, 1:i), xTrue(3, 1:i), '-c',...
       'linewidth', 1);
    h(3) = plot(zTrue(1, 1:i), zTrue(2, 1:i), 'b*',...
        'linewidth', 1.5, 'markersize', 8);
    h(4) = plot(muPred(1, 1:i), muPred(3, 1:i), '-m',...
       'linewidth', 1);
    h(5) = plot(muPost(1, 1:i), muPost(3, 1:i), '-r',...
       'linewidth', 1);
    h(1) = plot(zTrue(1, 1:i), zTrue(2, 1:i), 'b:',...
        'linewidth', 1);    
    pause(0.2);
    drawnow;
end