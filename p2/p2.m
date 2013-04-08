%% The main function
function p2
    clc; clear all; close all;
    world = {'green', 'red', 'red', 'green', 'green'};  % Map
    p = [0.2, 0.2, 0.2, 0.2, 0.2];        % Prior
    z = 'red';                            % Observation
    pHit = 0.6;                           % Observation model
    pMiss = 0.2;
    q = sense(p, z, world, pHit, pMiss);  % Update
    disp(q);
    p2plot;
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

%% The optional implementation of function sense
function q = sense(p, z, world, pHit, pMiss)
    q = zeros(size(p));
    for i = 1:length(p)
        hit = strcmp(z, world(i));
        if hit
            q(i) = p(i) * pHit;
        else
            q(i) = p(i) * pMiss;
        end
    end
     q = q / sum(q); 
end