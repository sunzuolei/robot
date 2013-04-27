close all; clc; clear all;
path(path, genpath('../p18'));
path(path, genpath('../p11'));
x = -2 : 0.02 : 10;
y = x;
%% Prior
[priorMat, xMat, yMat] ...
    = gaussian2d([5, 6], makeSigma(0.6, 0.9, 0.7), x, y);
%% Motion model
motMat = gaussian2d([3, 2], makeSigma(0.4, 0.7, 0.3), x, y);
%% Observation model
obsMat = gaussian2d([6, 4], makeSigma(0.6, 0.5, 0.5), x, y);

%% Prediction
predMat = convolute2d(priorMat, motMat, x, y);
%% Update
postMat = product2d(predMat, obsMat, x, y);
%%
figure('Name', 'Prediction')
hold on;
mesh(xMat, yMat, priorMat);
text(5, 6, max(max(priorMat)), 'Prior', 'fontweight','b');
mesh(xMat, yMat, motMat);
text(3, 2, max(max(motMat)), 'Motion model', 'fontweight','b');
mesh(xMat, yMat,predMat);
[r, c] = maxMat(predMat);
text(xMat(r,c), yMat(r,c), predMat(r, c), 'Predicted', 'fontweight','b');
xlabel('x');
ylabel('y');
zlabel('Probability');
xlim([min(x), max(x)]);
ylim([min(y), max(y)]);
view(3)
grid on;
print('-dpng', 'prediction.png');
%% 
figure('Name', 'Prediction contour')
hold on;
contour(xMat, yMat, priorMat);
text(5, 6, 'Prior', 'fontweight','b');
contour(xMat, yMat, motMat);
text(3, 2, 'Motion model', 'fontweight','b');
contour(xMat, yMat,predMat);
[r, c] = maxMat(predMat);
text(xMat(r,c), yMat(r,c), 'Predicted', 'fontweight','b');
xlabel('x');
ylabel('y');
xlim([min(x), max(x)]);
ylim([min(y), max(y)]);
grid minor;
print('-dpng', 'predictioncontour.png');
%%
figure('Name', 'Update')
hold on;
mesh(xMat, yMat,predMat);
[r, c] = maxMat(predMat);
text(xMat(r,c), yMat(r,c), predMat(r, c), 'Predicted', 'fontweight','b');
mesh(xMat, yMat,obsMat);
text(6, 4, max(max(obsMat)), 'Observation model', 'fontweight','b');
mesh(xMat, yMat,postMat);
[r, c] = maxMat(postMat);
text(xMat(r,c), yMat(r,c), postMat(r, c), 'Updated', 'fontweight','b');
xlabel('x');
ylabel('y');
zlabel('Probability');
xlim([min(x), max(x)]);
ylim([min(y), max(y)]);
view(3)
grid on;
print('-dpng', 'update.png');
%% 
figure('Name', 'Update contour')
hold on;
contour(xMat, yMat,predMat);
[r, c] = maxMat(predMat);
text(xMat(r,c), yMat(r,c), 'Predicted', 'fontweight','b');
contour(xMat, yMat,obsMat);
text(6, 4, max(max(obsMat)), 'Observation model', 'fontweight','b');
contour(xMat, yMat,postMat);
[r, c] = maxMat(postMat);
text(xMat(r,c), yMat(r,c),  'Updated', 'fontweight','b');
xlabel('x');
ylabel('y');
xlim([min(x), max(x)]);
ylim([min(y), max(y)]);
grid minor;
print('-dpng', 'updatecontour.png');