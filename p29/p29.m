close all; clear all; clc;
path(path, genpath('../p22'));
path(path, genpath('../p28'));
dbstop if error;
rob = [0 -3 -3; 0 -1 1] * 0.5;

%%
load '../data/rose.mat'
maxR  = 7.9; 
vedio = 1;
n     = 3;
len   = size(relMotion, 2);
%% Initialize vedio maker
if vedio
    videoObj           = VideoWriter('map.avi');
    videoObj.FrameRate = 5;
    videoObj.Quality   = 50;
    open(videoObj);
end
%% Initialize figure
figPos    = get(0, 'ScreenSize'); % [left, bottom, width, height]
figPos(3) = figPos(3) - 100;
figure('name', 'Motion animation',...
       'position', figPos,...
       'color', 'w', 'Menu', 'none');
hold on; box on; grid off;
robPlot  = patch(0, 0, 'b', 'erasemode', 'normal');
pathPlot = plot (0, 0, 'r-', 'linewidth', 5, 'erasemode','normal');
lsrPlot  = plot (0, 0, 'g.', 'markersize', 7, 'erasemode','normal');
xlabel('X(m)');
ylabel('Y(m)');
axis equal;
axis([-5  15  -5 15]);
set(gca,'Visible','off');
%%
pos  = zeros(3, 1);
path = zeros(3, len + 1);
for i = 1 : len
    pos          = compound(pos, relMotion(:, i));
    path(:, i+1) = pos;
    robPos       = compound(pos, rob);
    points       = getLaserPoint(laser(i+1, :), maxR);
    pointsWorld  = compound(pos, points);
    set(robPlot,  'xdata', robPos(1, :), 'ydata', robPos(2, :));
    set(pathPlot, 'xdata', path(1, 1:i), 'ydata', path(2, 1:i));
    set(lsrPlot,  'xdata', pointsWorld(1, :), ...
                  'ydata', pointsWorld(2, :));
    plot(pointsWorld(1, 1: n : end), pointsWorld(2, 1: n : end),...
        '.', 'markersize', 3, 'color', [169,169,169] / 255);
    drawnow;
    if mod(i, 6) == 0 && vedio
        frame = getframe;
        writeVideo(videoObj, frame);
    end
end
if vedio
    close(videoObj);
end
print('-dpng', 'map.png');
