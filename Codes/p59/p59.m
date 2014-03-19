% Test arbitrary random number generator
clear all; close all; clc;
path(path, '../p61');           % For calling arbitraryRand
m = 1000;
xLim = [-100, 100];
yLim = [30, 190];
p = [arbitraryRand(1, m, xLim(1), xLim(2));...
     arbitraryRand(1, m, yLim(1), yLim(2))];
w = rand(1, m);
%%
figure(1)
scatter(p(1,:), p(2,:), 31, w, 'fill');
axis([-130, 130, 0, 220]);
axis equal;
print('-dpng', 'testarbrand.png');

