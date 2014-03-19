clear all; clc; close all;
path(path, genpath('../p22'));  % For calling compound
fileName = './data/2000particles.mat';
%%
try 
    load( fileName );
catch err
    error(['Demo data error: ', err.identifier]);
end
%%
rob = [0 -3 -3; 0 -1 1] * 0.3;
makeVideo = 1;
%%
if makeVideo
    videoObj           = VideoWriter(sprintf('pfdemo%dpts.avi', m));
    videoObj.FrameRate = 5;
    videoObj.Quality   = 50;
    open(videoObj);
end
h = pfDemo.initFigure(xTrue, ptMeanPost,sensorPos);
%%
axes(h.bigAxes);
ptH = scatter(ptInit(1,:), ptInit(2,:), 30, wInit, 'fill');
if makeVideo
    for t = 1 : 20
        writeVideo(videoObj, getframe(h.all));
    end
end
delete(ptH);

%%
for i = 1 : step
    if i > 1
        delete(ptH);
        delete(ptHEye);
    end
    axes(h.bigAxes);
    ptH = scatter(ptPostAll(1,:, i), ptPostAll(2, :, i), ...
       30, wAll(i, :), 'fill'); 
   
    [xEnd,yEnd] = pol2cart(zTrue(i),10000);
    set(h.trueObs, 'xdata', [sensorPos(1),xEnd + sensorPos(1)],...
                   'ydata', [sensorPos(2),yEnd + sensorPos(2)]);
    set(h.truePat, 'xdata', xTrue(1, 1:i),  'ydata', xTrue(2, 1:i));
    set(h.postPat, 'xdata', ptMeanPost(1, 1:i),...
        'ydata', ptMeanPost(2, 1:i));
    %%
    trueRobBody     = compound(xTrue(:,i), rob);
    set(h.trueRob, 'xdata', trueRobBody(1, :), ...
        'ydata', trueRobBody(2, :));
    %
    postRobBody     = compound(ptMeanPost(:,i),rob);
    set(h.postRob, 'xdata', postRobBody(1, :), ...
        'ydata', postRobBody(2, :));
    %% Eagle eye
    set(h.eye.truePat, 'xdata', xTrue(1, 1:i),  'ydata', xTrue(2, 1:i));
    set(h.eye.postPat, 'xdata', ptMeanPost(1, 1:i),...
        'ydata', ptMeanPost(2, 1:i));
    set(h.eye.trueObs, 'xdata', [sensorPos(1),xEnd + sensorPos(1)],...
                   'ydata', [sensorPos(2),yEnd + sensorPos(2)]);
    set(h.eye.truePat, 'xdata', xTrue(1, 1:i),  'ydata', xTrue(2, 1:i));
    set(h.eye.trueRob, 'xdata', trueRobBody(1, :), ...
        'ydata', trueRobBody(2, :));
    set(h.eye.postRob, 'xdata', postRobBody(1, :), ...
        'ydata', postRobBody(2, :));
    axes(h.eyeAxes);
    ptHEye = scatter(ptPostAll(1,:, i), ptPostAll(2, :, i), ...
       10, wAll(i, :), 'fill'); 
    axis([ptMeanPost(1, i) - h.eye.rX, ptMeanPost(1, i) + h.eye.rX,...
          ptMeanPost(2, i) - h.eye.rY, ptMeanPost(2, i) + h.eye.rY])
    %%
    drawnow;
    if mod(i, 1) == 0 && makeVideo
        writeVideo(videoObj, getframe(h.all));
    end
%     pause(0.2)
end
if makeVideo
        close(videoObj);
end