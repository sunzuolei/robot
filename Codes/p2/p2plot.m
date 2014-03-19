 %% Plot distributions
    figure('Name','The Prior distribution','NumberTitle','off')
    bar(p,'hist');
    colormap summer 
    xlabel('Position');
    ylabel('Probability of being at the positon');
    ylim([0, 0.5]);
    %%
    figure('Name','Observation model','NumberTitle','off')
    obs = zeros(size(world));
    for i = 1:length(world)
        hit = strcmp(z, world(i));
        obs(i) = hit * pHit + (1-hit) * pMiss; 
    end
    bar(obs,'hist');
    colormap jet 
    xlabel('Position');
    ylabel('Likelihood');
    ylim([0, 0.9]);
    %%
    figure('Name','The Posterior distribution','NumberTitle','off')
    bar(q,'hist');
    colormap spring 
    xlabel('Position');
    ylabel('Probability of being at the positon');
    ylim([0, 0.5]);
    %%
    figure('Name', 'Plot all', 'NumberTitle', 'off')
    subplot(3,1,1)
    bar(p,'hist');
    colormap summer 
    ylabel('Probability');
    ylim([0, 0.5]);
    %
    subplot(3,1,2);
    bar(obs,'hist');
    colormap jet 
    ylabel('Likelihood');
    ylim([0, 0.9]);
    %
    subplot(3,1,3);
    bar(q,'hist');
    colormap spring 
    xlabel('Position');
    ylabel('Probability');
    ylim([0, 0.5]);
    
    