%% The main function
function p9
    clc; clear all; close all;
    world = {'red', 'green', 'green', 'red' ,   'red';
             'red', 'red',   'green', 'red',    'red';
             'red', 'red',   'green', 'green',  'red';
             'red', 'red',   'red',   'red',    'red'}; % Map
    nRow = size(world, 1);
    nCol = size(world, 2);
    stop  = [0, 0];
    right = [0, 1];
    left  = [0,-1];
    down  = [1, 0];
    up    = [-1,0];
    
    pMoveCorrect = 0.8;

    pStart = 0.7;
    p = (1 - pStart) / (nRow * nCol - 1) * ones(nRow, nCol);        % Prior
    %% Fisrt configuration
    p(3, 2) = pStart; 
    motions = {right};
    %% Second configuration
%     p(1, 3) = pStart; 
%     motions = {up};
    %% Motion propagation
    q = move(p, cell2mat(motions(1)), pMoveCorrect);
    
    %% Disp information
    disp('The Prior:');
    disp(p);  
    disp('The probability after moving:');
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

function q = move(p, u, pMoveCorrect)
    nRow = size(p, 1);
    nCol = size(p, 2);
    q = zeros(nRow, nCol);
    for r = 1 : nRow
        for c = 1 : nCol
            q(r, c) = pMoveCorrect * ...
                p(mod(r-1-u(1), nRow) + 1, mod(c-1-u(2), nCol) + 1)...
                + (1 - pMoveCorrect) * p(r, c); 
        end
    end
end

function [r, c] = maxMat(g)
% Find the index of the largest element of g
    [temp,r] = max(g);
    [~,c] = max(temp);
    r = r(c);
end