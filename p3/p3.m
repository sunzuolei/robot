%% The main function
function p3
    clc; clear all; close all;
    world = {'green', 'red', 'red', 'green', 'green'};  % Map
    p = [0.2, 0.2, 0.2, 0.2, 0.2];        % Prior
    measurements = {'red', 'green'};      % Observation
    pHit = 0.6;                           % Observation model
    pMiss = 0.2;
    for i = 1 : length(measurements)
        q = sense(p, measurements(i), world, pHit, pMiss); % Update
        p3plot;
        p = q;
    end
    disp(p);
    p3plot;
end

%% 
function q = sense(p, z, world, pHit, pMiss)
    q = zeros(size(p));
    for i = 1:length(p)
        hit = strcmp(z, world(i));
        q(i) = p(i) * (hit * pHit + (1-hit) * pMiss); 
    end
    q = q / sum(q);     % Normalization
end