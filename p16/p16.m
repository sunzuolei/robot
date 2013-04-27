close all; clc; clear all;
mu      = [0, 0];
sigmax  = 3;
sigmay  = 5;
rho     = -0.2;
sigmaxy = sigmax * sigmay * rho;
Sigma   = [sigmax^2,   sigmaxy;
           sigmaxy,    sigmay^2];
ellipse = getSigmaEllipse(mu, Sigma, 1, 360);
%%
h = figure('name', 'The 1-sigma ellipse');
hold on;
plot(ellipse(1,:), ellipse(2, :), 'r-', 'linewidth', 6);
plot(mu(1), mu(2), 'xg', 'markersize', 20, 'linewidth', 6);
xlabel('x'); 
ylabel('y');
title(sprintf('\\sigma_x = %.1f, \\sigma_y = %.1f, \\rho = %.1f',...
                sigmax, sigmay, rho));
grid on;
axis equal;
xlim([-5.5, 5.5]);
ylim([-5.5, 5.5]);
set(gca, 'XTick', -5 : 1 : 5);
set(gca, 'YTick', -5 : 1 : 5);
grid minor;

print('-dpng','sigma.png');