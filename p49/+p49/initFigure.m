function h = initFigure( xTrue, xPost, sensorPos )

    h.all = figure('name', 'True motions and observations' ,'color', 'w',...
        'units','normalized', 'outerposition',[0 0 1 1]);
%     h.all = figure(1);
    hold on;
    box on;
    %%
    h.truePat = plot(0, 0, 'b:', 'linewidth',2, 'erasemode', 'normal');
    h.predRob = plot(0, 0, 'y.', 'markersize', 30, 'erasemode', 'normal');
    h.postRob = plot(0, 0, 'r.', 'markersize', 30, 'erasemode', 'normal'); 
    h.predPat = plot(0, 0, 'color',[30,144,255]/255, ...
        'linestyle', '-', 'linewidth',1.8,'erasemode','normal'); %
    h.postPat = plot(0, 0, 'color',[0, 100,  0]/255, ...
        'linestyle', '-', 'linewidth',1.8,'erasemode','normal'); %
    h.trueObs = plot(0, 0, 'g:','linewidth', 4, 'erasemode','normal');
    h.sensor  = plot(sensorPos(1),sensorPos(2),'mo',...
        'markersize',15,'linewidth',2, 'MarkerFaceColor','y');

    h.legend  = legend('True Path', 'Predicted Rob','Updated Rob', ...
        'Predicted Path', 'Updated Path', 'True Bearing-only Obs', 'Sensor');
    set(h.legend ,'box','off','location','NorthWestOutside',...
        'orientation','vertical','fontsize',15);
    axis square;
    %%
    minX = min([xTrue(1, :), sensorPos(1), xPost(1, :)]);
    maxX = max([xTrue(1, :), sensorPos(1), xPost(1, :)]);
    minY = min([xTrue(3, :), sensorPos(2), xPost(3, :)]);
    maxY = max([xTrue(3, :), sensorPos(2), xPost(3, :)]);
    lenX = maxX - minX;
    lenY = maxY - minY;
    a    = 0.1;
    axis([minX - lenX * a, maxX + lenX * a,...
          minY - lenY * a, maxY + lenY * a]);
    xlabel('x (m)');
    ylabel('y (m)');
end

