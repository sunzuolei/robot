function h = initFigure( zTrue, xTrue )

    h.all = figure('name', 'True motions and observations' ,'color', 'w',...
        'units','normalized', 'outerposition',[0 0 1 1]);
    hold on;
    box on;
    %%
    h.predRob = plot(0, 0, 'y.', 'markersize', 30, 'erasemode', 'normal');
    h.postRob = plot(0, 0, 'r.', 'markersize', 30, 'erasemode', 'normal'); 
    h.predPat = plot(0, 0, 'color',[30,144,255]/255, ...
        'linestyle', '-', 'linewidth',1.8,'erasemode','normal'); %
    h.postPat = plot(0, 0, 'color',[0, 100,  0]/255, ...
        'linestyle', '-', 'linewidth',1.8,'erasemode','normal'); %
    h.trueObs = plot(0, 0, 'g*-','markersize', 4, 'erasemode','normal');
    h.legend  = legend('Predicted Rob','Updated Rob',  'Predicted Path',...
        'Updated Path', 'True Obs');
    set(h.legend ,'box','off','location','NorthWestOutside',...
        'orientation','vertical','fontsize',15);
    axis square;
    %%
    minX = min([zTrue(1,:), xTrue(1, :)]);
    maxX = max([zTrue(1,:), xTrue(1, :)]);
    minY = min([zTrue(2,:), xTrue(3, :)]);
    maxY = max([zTrue(2,:), xTrue(3, :)]);
    lenX = maxX - minX;
    lenY = maxY - minY;
    a    = 0.1;
    axis([minX - lenX * a, maxX + lenX * a,...
          minY - lenY * a, maxY + lenY * a]);
    xlabel('x (m)');
    ylabel('y (m)');
end

