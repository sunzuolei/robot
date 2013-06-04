%% Simulate the nonlinear motion and observation.
close all; clear all; clc;
path(path, genpath('../p22'));
path(path, genpath('../p54'));
rng(853); % Control random number generation
%%
load '../data/rose.mat'
clear laser;
relMotion = relMotion(:, 530:2250); % Only use a part of the data.
step      = size(relMotion, 2);
rob = [0 -3 -3; 0 -1 1] * 0.5;
%%
xInit        = [0, 0, 0]';

%%
sensorPos    = [-9, 14];
%% Tune noises
proNoiseScalar = 1.0;
obsNoiseScalar = 1.0;
%% Process noise sigma
sigmaXNoise    = 0.002;
sigmaYNoise    = 0.002;
sigmaThetaNoise = degtorad(0.04);
Q  = diag(proNoiseScalar * ...
    [sigmaXNoise, sigmaXNoise, sigmaXNoise]).^2;
%% Measurement noise sigma
sigmaBNoise  = degtorad(0.08);
R  = (obsNoiseScalar * sigmaBNoise).^2;
%% Noise for simulating truths
% NOTE: the simQ and simR can be different from Q and R!!
simQ =  diag([sigmaXNoise, sigmaXNoise, sigmaXNoise]).^2;
simR =  sigmaBNoise^2;
%%
[xTrue, zTrue] = p54.simTruth(xInit, @p54.motionModel, relMotion, simQ,...
    @p54.sensorModel, sensorPos, simR, step);

%%
videoObj           = VideoWriter('truthfullynonlinear.avi');
videoObj.FrameRate = 5;
videoObj.Quality   = 50;
open(videoObj);
    
h.all = figure('name', 'True motions and observations' ,'color', 'w',...
        'units','normalized', 'outerposition',[0 0 1 1]);
hold on;
box on;
h.trueObs = plot(0, 0, 'g:','linewidth', 4, 'erasemode','normal');
h.sensor  = plot(sensorPos(1),sensorPos(2),'mo',...
    'markersize',15,'linewidth',2, 'MarkerFaceColor','y');
h.truePat = plot (0, 0, 'b:', 'linewidth',2, 'erasemode','normal');
h.trueRob = patch(0, 0, 'r', 'linewidth',2, 'erasemode', 'normal');
axis square;
%%
minX = min([xTrue(1, :), sensorPos(1)]);
maxX = max([xTrue(1, :), sensorPos(1)]);
minY = min([xTrue(2, :), sensorPos(2)]);
maxY = max([xTrue(2, :), sensorPos(2)]);
lenX = maxX - minX;
lenY = maxY - minY;
a    = 0.1;
axis([minX - lenX * a, maxX + lenX * a,...
      minY - lenY * a, maxY + lenY * a]);
xlabel('x (m)');
ylabel('y (m)');
for i = 1 : step
        [xEnd,yEnd] = pol2cart(zTrue(i),10000);
        set(h.trueObs, 'xdata', [sensorPos(1),xEnd + sensorPos(1)],...
                       'ydata', [sensorPos(2),yEnd + sensorPos(2)]);
        set(h.truePat, 'xdata', xTrue(1, 1:i), 'ydata', xTrue(2, 1:i));
        robBody     = compound(xTrue(:,i), rob);
        set(h.trueRob, 'xdata', robBody(1, :), 'ydata', robBody(2, :));
        drawnow;
        if mod(i, 5) == 0
            writeVideo(videoObj, getframe);
        end
%         pause(0.2);
end
close(videoObj);