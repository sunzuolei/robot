clc; clear all; close all;
load '../data/rose.mat'
maxR  = 7.9; 
vedio = 0;
len   = size(laser, 1);
%% Initialize figure
figPos    = get(0, 'ScreenSize'); % [left, bottom, width, height]
figPos(3) = figPos(3) - 100;
figure('name', 'Raw laser data',...
       'position', figPos,...
       'color', 'w', 'Menu', 'none');
hold on; box on; 
lsrFig = plot (0, 0, 'r.', 'linewidth', 4, 'erasemode','normal');
xlabel('X(m)');
ylabel('Y(m)');
axis equal;
axis([0  maxR  -maxR  maxR]);

%% Initialize vedio maker
if vedio
    videoObj           = VideoWriter('laserpointclouds.avi');
    videoObj.FrameRate = 5;
    videoObj.Quality   = 50;
    open(videoObj);
end
%%
for i = 1 : len
    points = getLaserPoint(laser(i, :), maxR);
    set(lsrFig, 'xdata', points(1,:), ...
        'ydata', points(2, :));
    title(sprintf('Laser image Frame %d', i));
    drawnow;
    
    if mod(i, 4) == 0 && vedio
        frame = getframe;
        writeVideo(videoObj, frame);
    end
    if vedio == 0
        pause(0.02);
    end
end
if vedio
    close(videoObj);
end