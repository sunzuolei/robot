close all; clc; clear all;
mu      = [6, 5];
sigmax  = 2;
sigmay  = 1;
rho     = -0.2;
sigmaxy = sigmax * sigmay * rho;
Sigma   = [sigmax^2,   sigmaxy;
           sigmaxy,    sigmay^2];
x = 0 : 0.01 : 12;
y = x;
[pMat, xMat, yMat] = gaussian2d(mu, Sigma, x, y);
fprintf('The integration of p with respect to x and y is %.4f\n',...
        trapz(y, trapz(x,pMat)));
%%
figure('Name', '2D Gaussian distribution');
mesh(xMat, yMat, pMat);
xlabel('x');
ylabel('y');
zlabel('Probability');
xlim([min(x), max(x)]);
ylim([min(y), max(y)]);
print('-dpng', 'gaussian2d.png');
view(2)
print('-dpng', 'gaussian2dxy.png');

figure('name', 'The contour of 2D Gaussian distribution');
hold on;
plot (mu(1), mu(2), 'xg', 'markersize', 6, 'linewidth', 1);
[~,h] = contour(xMat, yMat, pMat);
set(h,'ShowText','on','TextStep',...
    get(h,'LevelStep')*2,'linewidth',2.0);
xlabel('x');
ylabel('y');
xlim([min(x), max(x)]);
ylim([min(y), max(y)]);
colormap Lines;
box on
axis equal
print('-dpng', 'gaussian2dcontour.png');

