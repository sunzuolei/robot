close all; clear all; clc;
path(path, '../p16');
rng(555); 

%%
dt        = 0.1;
step      = 100;
x         = [0, 0.5, 0, 0.4]';
sigmaVx   = 0.2;
sigmaVy   = 0.1;
%%
sigmaZx   = 0.8;
sigmaZy   = 0.6;
%%
F = [1, dt,  0,  0;
     0,  1,  0,  0;
     0,  0,  1,  dt;
     0,  0,  0,  1];
E = [dt^2/2,    0;
       dt,      0;
       0,       dt^2/2;
       0,       dt];
Q = [sigmaVx^2,   0;
       0,    sigmaVx^2 ];
w = chol(Q) * randn(size(Q, 1), step);
%%
H = [1, 0, 0, 0;
     0, 0, 1, 0];
R = [sigmaZx^2,   0;
       0,    sigmaZy^2 ]; 
v = sqrt(R) * randn(size(R, 1), step);
%%
xAll      = zeros(length(x), step);
xAll(:,1) = x;
zAll      = zeros(size(R, 1), step);
zAll(:,1) = H * x + v(:, 1);
%%
for i = 2 : step
    x = F * x + E * w(:, i);
    z = H * x + v(:, i);
    xAll(:, i) = x;
    zAll(:, i) = z;
end

%% 
figure('name', 'CV Motion and Obs.Truth', 'color', 'w');
hold on; box on; grid minor;
pathPlot  = plot(0, 0, 'r-', 'linewidth', 2, 'erasemode','normal');
robPlot   = plot(0, 0, 'o', 'markerfacecolor', 'g', 'markersize', 10,...
                'erasemode', 'normal');
sigmaPlot = plot(0, 0, 'b-', 'linewidth', 1, 'erasemode','normal');
xlabel('X(m)');
ylabel('Y(m)');
axis equal;
axis([min(xAll(1, :))  max(xAll(1, :))...
      min(xAll(3, :))  max(xAll(3, :))]);

for i = 1 : step
   set(robPlot,  'xdata', xAll(1, i), 'ydata', xAll(3, i));
   set(pathPlot, 'xdata', xAll(1, 1:i), 'ydata', xAll(3, 1:i));
   Sigma      = E * Q * E';
   SigmaXy    = Sigma([1,3], [1,3]);
   threeSigma = getSigmaEllipse(xAll([1,3], i), SigmaXy, 3);
   set(sigmaPlot,'xdata', threeSigma(1, :), ...
       'ydata', threeSigma(2, :));
   %%
   plot(zAll(1, 1:i), zAll(2, 1:i), '-c',...
       'linewidth', 1);
   plot(zAll(1, 1:i), zAll(2, 1:i), 'b*',...
       'linewidth', 1.5, 'markersize', 8);
   pause(0.2);
   drawnow;
end
print('-dpng', 'truth.png');
