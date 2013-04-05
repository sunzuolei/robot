%% The main function
function p10
    clc; clear all; close all;
    world = {'red', 'green', 'green', 'red' ,   'red';
             'red', 'red',   'green', 'red',    'red';
             'red', 'red',   'green', 'green',  'red';
             'red', 'red',   'red',   'red',    'red'}; % Map
    nRow = size(world, 1);
    nCol = size(world, 2);
    pStart = 0.7;
    p = (1 - pStart) / (nRow * nCol) * ones(nRow, nCol);        % Prior
    
    pSenseCorrect = 0.7;
    %%
    p(3, 2) = pStart; 
    measurements = {'green'};
    %% Measurment update
    q = sense(p, cell2mat(measurements(1)), world, pSenseCorrect);
    %% Disp information
    disp('The Prior:');
    disp(p);  
    disp('The probability after sensing:');
    disp(q);
    [r, c] = maxMat(q);
    fprintf('The largest probability %.4f occurs at cell (%d, %d)\n ',...
        q(r,c), r, c);
    %% Plot figures
    h = figure(1);
    bar3(p, 1);
    colormap(cool);
    title('The prior');
    print(h, '-dpng', 'prior.png');
    %
    h2 = figure(2);
    bar3(q, 1);
    colormap(cool); 
    title('The probability distribution after moving');
    print(h2, '-dpng', 'aftermotion.png');
end
%%
function q = sense(p, z, world, pSenseCorrect)
    nRow = size(p, 1);
    nCol = size(p, 2);
    q = zeros(nRow, nCol);
    for r = 1 : nRow
        for c = 1 : nCol
            hit = strcmp(z, world(r, c));
            q(r, c) = p(r, c) *...
                (hit * pSenseCorrect + (1-hit) * (1 - pSenseCorrect)); 
        end            
    end
    q = q / sum(sum(q)); 
end
%%
function [r, c] = maxMat(g)
% Find the index of the largest element of g
    [temp,r] = max(g);
    [~,c] = max(temp);
    r = r(c);
end