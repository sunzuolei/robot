clear all; clc; close all;
rng('default');
rng(123); % Control random number generation
%%
step         = 100;
stEdge       = 10;
v            = 2;
dt           = 1;
xInit        = [0, 0, 0, 0]';
SigmaInit    = 1^2 * eye(4);
xLen         = length(xInit);
%% 
u = simControlSqaure(step, stEdge, v);
%% Process noise sigma
sigmaCxNoise = 0.01;
sigmaCyNoise = 0.01;

%% Measurement noise sigma
sigmaXNoise  = 0.1;
sigmaYNoise  = 0.1; 
%% Noise for simulating truths
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
[xTrue, zTrue] = simTruthSqaure(xInit, F, B, u, E, simQ, H, simR, step);
%% Visualization and make video
h.all = figure('name', 'True motions and observations' ,'color', 'w',...
    'units','normalized', 'outerposition',[0 0 1 1]);
hold on;
box on;
h.trueRob = plot(0, 0, 'r.','markersize',60,'erasemode','normal'); 
h.truePat = plot(0, 0, 'color',[30,144,255]/255,'linestyle','-',...
    'linewidth',1.8,'erasemode','normal'); %
h.trueObs = plot(0, 0, 'g.','markersize', 4, 'erasemode','normal');
h.legend  = legend('True Rob', 'True Path', 'True Obs');
set(h.legend ,'box','off','location','NorthWestOutside',...
    'orientation','vertical','fontsize',15);
axis square;
minX = min(zTrue(1,:));
maxX = max(zTrue(1,:));
minY = min(zTrue(2,:));
maxY = max(zTrue(2,:));
lenX = maxX - minX;
lenY = maxY - minY;
a    = 0.1;
axis([minX - lenX * a, maxX + lenX * a,...
      minY - lenY * a, maxY + lenY * a]);
xlabel('x (m)');
ylabel('y (m)');

videoObj           = VideoWriter('squaretruth.avi');
videoObj.FrameRate = 5;
videoObj.Quality   = 100;
open(videoObj);

for i = 1 : step
    set(h.trueObs, 'xdata', zTrue(1,1:i), 'ydata', zTrue(2, 1:i));
    set(h.truePat, 'xdata', xTrue(1,1:i), 'ydata', xTrue(3, 1:i));
    set(h.trueRob, 'xdata', xTrue(1, i),  'ydata', xTrue(3,  i));
    title(['step = ', num2str(i)]);
    drawnow;
    frame = getframe(h.all);
    writeVideo(videoObj, frame);
end
close(videoObj);
print('-dpng', 'squaretruth.png');