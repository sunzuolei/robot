close all; clear all; clc;
x = [7, 38, 4, 23, 18];
% x = [17, 19, 18, 17, 19];
x = [18, 18, 18, 18, 18];
mu = compMean(x);
sigma2 = compVariance(x);
fprintf('The Expectation / Mean:\t %.1f \n', mu);
fprintf('The Variance is:\t\t %.1f \n', sigma2);
fprintf('The Standard Deviation is:\t %.1f \n', sqrt(sigma2));
