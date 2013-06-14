%% Test sequential importance resampling (SIR)
close all;
clear all;
clc;
path(path, '../p61');  % For calling resampleParticle
%%
rng('default');
rng(940);
%%
n = 500;
m = 5;
particle = zeros(2, n);
% weight   = randn(1,n).^2;
weight   = exp(randn(1,n));


%%
figure('name', 'Test resampling', 'units','normalized',...
    'outerposition',[0 0 1 1]);
subplot(m, 1, 1)
stem(weight, 'markersize', 3, 'MarkerFaceColor','red','MarkerEdgeColor','red');
ylabel('Weight');
xlim([1, n]);

%%
subplot(m, 1, 2)
newI     = resampleParticle(weight, 'hugh');
nSampled = getTimesSampled(newI);
stem(nSampled, 'markersize', 3,...
    'MarkerFaceColor','green','MarkerEdgeColor','green');
% ylabel('Times of being sampled');
xlim([1, n]);
ylabel('Hugh');
grid minor;
%%
subplot(m, 1, 3)
newI     = resampleParticle(weight, 'thrun');
nSampled = getTimesSampled(newI);
stem(nSampled, 'markersize', 3,...
    'MarkerFaceColor','green','MarkerEdgeColor','green');
% ylabel('Times of being sampled');
xlim([1, n]);
ylabel('Thrun');
grid minor;
%%
subplot(m, 1, 4)
newI     = resampleParticle(weight, 'improvedthrun');
nSampled = getTimesSampled(newI);
stem(nSampled, 'markersize', 3,...
    'MarkerFaceColor','green','MarkerEdgeColor','green');
% ylabel('Times of being sampled');
xlim([1, n]);
ylabel('Improved Thrun');
grid minor;
%%
subplot(m, 1, 5)
newI     = resampleParticle(weight, 'residual');
nSampled = getTimesSampled(newI);
stem(nSampled, 'markersize', 3,...
    'MarkerFaceColor','green','MarkerEdgeColor','green');
% ylabel('Times of being sampled');
xlim([1, n]);
ylabel('Residual');
grid minor;
print('-dpng', 'testresample.png');


