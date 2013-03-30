%% The main function
function p8
    clc; clear all; close all;
    p = [0.2, 0.2, 0.2, 0.2, 0.2];        % Prior
    world = {'green', 'red', 'red', 'green', 'green'};  % Map    
    %% First configuration of meas. & motion
    measurements = {'red', 'green'};      % Observation
    motions = [1, 1];                     % Motions
    %% Second configuration
%     measurements = {'red', 'green', 'green'};      % Observation
%     motions = [1, 1, 1];                     % Motions   
%     %% Third configuration
%     measurements = {'green', 'red'};
%     motions = [1, 1];
    %% Fourth configuration
%     measurements = {'green', 'green'};
%     motions = [3, 1];
    %% Fifth configuration, It is impossible case.
%     measurements = {'red', 'red'};
%     motions = [3, 1];
    %% Sixth configuration, It is impossible case.
%     measurements = {'red', 'red'};
%     motions = [2, 1];
    %% Observation model
    pHit = 0.6;                           
    pMiss = 0.2;
    %% Motion model / Process model
    pExact = 0.8;
    pOvershoot = 0.1;
    pUndershoot = 0.1;
    %% The recursive sensing and moving
    entropy = zeros(2, length(motions));
    for i = 1 : length(measurements)
        %% Update by sensing
        p = sense(p, measurements(i), world, pHit, pMiss); 
        entropy(1,i) = sum(p .* log(p) );  
        %% Predict by moving
        p = move(p, motions(i), pExact, pOvershoot, pUndershoot);
        entropy(2,i) = sum(p .* log(p) );    
    end
    disp(p)
    disp(entropy(end, end)); % Show the final distribution's entropy
    %% Show the posterior
    h1 = figure(1);
    hold on;
    hAllBar = bar(p, 'hist');
    set(hAllBar,'FaceColor','g');
    [pMaxCell, iMaxCell] = max(p);
    pMax = zeros(1, length(p));
    pMax(iMaxCell) = pMaxCell;
    hMaxBar = bar(pMax, 'hist');
    set(hMaxBar,'FaceColor','r');
    xlabel('Index of cell');
    ylabel('Posterior probability');
    print(h1, '-dpng', 'posterior.png');
    %% Show the entropy
    h2 = figure(2);
    hold on;
    plot(entropy(1,:), 'bo', 'linewidth', 3, 'markersize', 10);
    plot(entropy(2,:), 'rx', 'linewidth', 3, 'markersize', 10);
    xlim([0, length(motions)+1]);
    xlabel('Step');
    ylabel('Entropy');
    legend('After sensing', 'After moving but before sensing', 'Location', 'NorthWest');
    print(h2, '-dpng', 'entropy.png');
end

%% 
function q = sense(p, z, world, pHit, pMiss)
    q = zeros(size(p));
    for i = 1:length(p)
        hit = strcmp(z, world(i));
        q(i) = p(i) * (hit * pHit + (1-hit) * pMiss); 
    end
    q = q / sum(q);     
end
%%
function q = move(p, u, pExact, pOvershoot, pUndershoot)
    n = length(p);
    q = zeros(1, n);
    for i = 1 : n
        q(i) = pExact * p(mod(i-1-u, n) + 1); 
        q(i) = q(i) + pOvershoot * p(mod(i-2-u, n) + 1);
        q(i) = q(i) + pUndershoot * p(mod(i-u, n) + 1);
    end
end