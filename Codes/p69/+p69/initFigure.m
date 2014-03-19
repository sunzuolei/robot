function h = initFigure( xTrue, xPost, sensorPos )
    h.all = figure('name', 'EIF Demo' ,'color', 'w',...
        'units','normalized', 'outerposition',[0 0 1 1]);
%     h.all = figure(1);
    hold on;
    box on;
    %%
    h.truePat = plot (0, 0,  'b:', 'linewidth',2, 'erasemode', 'normal');
    % ====== Just for legend ====
    plot(1e10, 0, 'Marker','<','Markersize',10,...
        'MarkerFaceColor', 'y', 'MarkerEdgeColor', 'k');
    plot(1e10, 0, 'Marker','<','Markersize',10,...
        'MarkerFaceColor', 'c', 'MarkerEdgeColor', 'k');
    plot(1e10, 0, 'Marker','<','Markersize',10,...
        'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'k'); 
    % =========== end ===========
    h.predPat = plot (0, 0, 'color',[30,144,255]/255, ...
        'linestyle', '-', 'linewidth',1.8,'erasemode','normal'); %
    h.postPat = plot (0, 0, 'color',[0, 100,  0]/255, ...
        'linestyle', '-', 'linewidth',1.8,'erasemode','normal'); %
    h.trueObs = plot (0, 0, 'g:','linewidth', 4, 'erasemode','normal');
    h.sensor  = plot (sensorPos(1),sensorPos(2),'mo',...
        'markersize',15,'linewidth',2, 'MarkerFaceColor','y');   
    h.trueRob = patch(0, 0, 'y', 'linewidth',2, 'erasemode', 'normal');
    h.predRob = patch(0, 0, 'c', 'linewidth',2, 'erasemode', 'normal');
    h.postRob = patch(0, 0, 'r.', 'markersize', 30, 'erasemode', 'normal'); 
    
    title('The bearing-only extended information filter demo');
    h.legend  = legend('True Path', 'True Rob','Predicted Rob',...
        'Updated Rob', 'Predicted Path', 'Updated Path',...
        'True Bearing-only Obs', 'Sensor');
    set(h.legend ,'box','off','location','NorthWestOutside',...
        'orientation','vertical','fontsize',15);
    axis equal;
    %%
    minX = min([xTrue(1, :), sensorPos(1), xPost(1, :)]);
    maxX = max([xTrue(1, :), sensorPos(1), xPost(1, :)]);
    minY = min([xTrue(2, :), sensorPos(2), xPost(2, :)]);
    maxY = max([xTrue(2, :), sensorPos(2), xPost(2, :)]);
    lenX = maxX - minX;
    lenY = maxY - minY;
    a    = 0.1;
    axis([minX - lenX * a, maxX + lenX * a,...
          minY - lenY * a, maxY + lenY * a]);
    xlabel('x (m)');
    ylabel('y (m)');
end

