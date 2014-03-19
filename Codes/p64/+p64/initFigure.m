function h = initFigure( xTrue, xPost, sensorPos )
    h.all = figure('name', 'PF Demo' ,'color', 'w',...
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
        'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'k'); 
    % =========== end ===========
    h.postPat = plot (0, 0, 'color',[0, 100,  0]/255, ...
        'linestyle', '-', 'linewidth',1.8,'erasemode','normal'); 
    h.trueObs = plot (0, 0, 'r-','linewidth', 4, 'erasemode','normal');
    h.sensor  = plot (sensorPos(1),sensorPos(2),'mo',...
        'markersize',15,'linewidth',2, 'MarkerFaceColor','y');   
    h.trueRob = patch(0, 0, 'y', 'linewidth',2, 'erasemode', 'normal');
    h.postRob = patch(0, 0, 'r.', 'markersize', 30, 'erasemode', 'normal'); 
    
    h.legend  = legend('True Path', 'True Rob',...
        'Filtered Rob', 'Filtered Path',...
        'True Bearing & Range Obs', 'Sensor');
    set(h.legend ,'box','off','location','NorthWestOutside',...
        'orientation','vertical','fontsize',15);
    axis square ;
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
    h.bigAxes = get(gcf,'CurrentAxes');
    %%
    h.eyeAxes = axes('Units', 'normalized', ...
        'Position', [.04, .12, .32, .55]); %[left bottom width height]
    axes(h.eyeAxes)
    hold on;
    box on;
    h.eye.truePat = plot (0, 0,  'b:', 'linewidth',2,...
        'erasemode', 'normal');
    h.eye.postPat = plot (0, 0, 'color',[0, 100,  0]/255, ...
        'linestyle', '-', 'linewidth',1.8,'erasemode','normal'); 
    h.eye.trueObs = plot (0, 0, 'r-','linewidth', 4, 'erasemode','normal');
    h.eye.sensor  = plot (sensorPos(1),sensorPos(2),'mo',...
        'markersize',15,'linewidth',2, 'MarkerFaceColor','y');   
    h.eye.trueRob = patch(0, 0, 'y', 'linewidth', 2, 'erasemode', 'normal');
    h.eye.postRob = patch(0, 0, 'r.', 'markersize', 30, 'erasemode', 'normal');
    axis square ;
    %%
    scalar    = 0.02;
    h.eye.rX  = lenX * scalar;
    h.eye.rY  = lenY * scalar;
end

