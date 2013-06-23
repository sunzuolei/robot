%% Plot the dynamic motion
figure('name', 'Linear information filter demo' ,'color', 'w',...
    'units','normalized', 'outerposition',[0 0 1 1]);
hold on; box on; grid off;
xlabel('X(m)');
ylabel('Y(m)');
axis equal;
axis(1.1 * [min(xTrue(1, :))-0.5  max(xTrue(1, :))...
      min(xTrue(3, :))-0.5  max(xTrue(3, :))]);

for i = 1 : step
    h(1) = plot(xTrue(1, 1:i), xTrue(3, 1:i), '-m',...
       'linewidth', 2);
    h(2) = plot(zTrue(1, 1:i), zTrue(2, 1:i), 'b*:',...
        'linewidth', 1, 'markersize', 7);
    h(3) = plot(muPost(1, 1:i), muPost(3, 1:i), 'k.-',...
       'linewidth', 2);
    legend(h, 'Ground truth', 'Observation', 'Updated path',...
        'location', 'NorthWest');
    pause(0.2);
    drawnow;
end
print('-dpng', 'linearinformationfilterdemo.png');