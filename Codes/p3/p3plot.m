 %% Plot distributions
    figure('Name', 'Plot all', 'NumberTitle', 'on')
    subplot(3,1,1)   
    bar(p,'hist');
    ylabel('Prior');
    ylim([0, 0.5]);
    title(['Measurement = ', measurements(i)]);
    %
    subplot(3,1,2);
    obs = zeros(size(world));
    for j = 1:length(world)
        hit = strcmp(measurements(i), world(j));
        obs(j) = hit * pHit + (1-hit) * pMiss; 
    end
    bar(obs,'hist');
    ylabel('Observation');
    ylim([0, 0.9]);
    %
    subplot(3,1,3);
    bar(q,'hist');
    colormap spring 
    xlabel('Position');
    ylabel('Posterior');
    ylim([0, 0.5]);
    
    
    