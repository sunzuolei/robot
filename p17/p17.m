close all; clc; clear all;
x     = -2 : 0.01 : 12;
mu    = 5;
sigma = 0.5;
p = gaussian1d(mu, sigma, x);
fprintf('The integration of p with respect to x is %.f\n', trapz(x, p));
%%
h = figure('name','One D Gaussian distribution');
hold on;
plot(x, p, 'b-', 'linewidth', 4);
plot([mu, mu], [min(p), max(p)], 'r-', 'linewidth', 4);
box on;
title(sprintf('\\mu = %.1f, \\sigma = %.1f', mu, sigma))
% set(gca,'Visible','off');
xlabel('x');
ylabel('P(x)');
grid on;
grid minor;
print(h, '-dpng', 'guassian1d.png');