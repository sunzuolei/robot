%% p11
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
pSenseCorrect = 0.7;
compEntropy = inline('-sum(sum(p .* log2(p)))'); % Inline function

p = 1 / (nRow * nCol) * ones(nRow, nCol);        % Prior
%% Fisrt configuration
motions = {stop, right, down, down, right};
measurements = {'green', 'green', 'green' ,'green', 'green'};
%% Check the size
if length(motions) ~= length(measurements)
    error('The variable ''motions'' should be of the same size as ''measurements''!');
end
entropy = zeros(2, length(motions));
%% The main loop
for i = 1 : length(motions)
    p = move(p, cell2mat(motions(i)), pMoveCorrect);
    p0 = p;
    p = sense(p, cell2mat(measurements(i)), world, pSenseCorrect);
    %% Compute entropy
    entropy(:, i) = [compEntropy(p0); compEntropy(p)];
    %% Make figures
    h = figure(1);
    set(h, 'position', get(0,'ScreenSize'));
    subplot(2, 1, 1)
    bar3(p0, 1);
    colormap(cool);
    title(sprintf('Step %d\n The probability before sensing', i));
    zlim([0, 0.3]);
    ylim([0.5, 4.5]);
    subplot(2, 1, 2)
    bar3(p, 1);
    colormap(cool);
    title('The probability after sensing');
    zlim([0, 0.3]);
    ylim([0.5, 4.5]);
    print(h, '-dpng', sprintf('step%d.png', i));
end
%% Display posterior
disp('The Posterior:');
disp(p);  

%% Visualize entropy
h2 = figure(2);
hold on;
plot(entropy(1,:), 'bo', 'linewidth', 3, 'markersize', 10);
plot(entropy(2,:), 'rx', 'linewidth', 3, 'markersize', 10);
xlim([0, length(motions)+1]);
xlabel('Step');
ylabel('Entropy');
legend('Before sensing', 'After sensing', 'Location', 'Best');
print(h2, '-dpng', 'entropy.png');

close all;
%% Locate the final cell
[r, c] = maxMat(p);
fprintf('The largest probability %.4f occurs at cell (%d, %d)\n ',...
        p(r,c), r, c);



