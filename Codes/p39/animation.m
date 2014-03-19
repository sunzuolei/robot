%% Plot the dynamic motion
figPos    = get(0, 'ScreenSize'); % [left, bottom, width, height]
figPos(3) = figPos(3) - 100;
figure('name', 'Motion animation',...
       'position', figPos,...
       'color', 'w');
% subplot('Position',[0.05 0.05 0.9 0.9])
hold on; box on; grid off;
robPlot   = plot(0, 0, 'o', 'markerfacecolor', 'g', 'markersize', 10,...
                'erasemode', 'normal');
xlabel('X(m)');
ylabel('Y(m)');
axis equal;
axis(1.1 * [min(xTrue(1, :))-0.5  max(xTrue(1, :))...
      min(xTrue(3, :))-0.5  max(xTrue(3, :))]);

for i = 1 : step
    if i == 1 || mod(i, 1) == 0
        SigmaPostNow   = SigmaPost(:,:,i);
        SigmaPostNowXy = SigmaPostNow([1,3], [1,3]);
        threeSigma     = getSigmaEllipse(muPost([1,3], i),...
                            SigmaPostNowXy, 3);
        plot(threeSigma(1,:), threeSigma(2,:), '-g');
    end
    set(robPlot,  'xdata', xTrue(1, i), 'ydata', xTrue(3, i));   
    h(1) = plot(xTrue(1, 1:i), xTrue(3, 1:i), '-c',...
       'linewidth', 2);
    h(2) = plot(zTrue(1, 1:i), zTrue(2, 1:i), 'b+',...
        'linewidth', 1, 'markersize', 8);
    h(3) = plot(muPred(1, 1:i), muPred(3, 1:i), '-r',...
       'linewidth', 1);
    h(4) = plot(muPost(1, 1:i), muPost(3, 1:i), '-k',...
       'linewidth', 1.5);
    plot(zTrue(1, 1:i), zTrue(2, 1:i), 'b:',...
        'linewidth', 1); 
    legend(h, 'Ground truth', 'Observation', 'Predicted', 'Posterior',...
        'location', 'NorthWest');
    pause(0.2);
    drawnow;
end
print('-dpng', 'all.png');