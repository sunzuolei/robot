close all; clear all; clc;
path(path,genpath('../p13'));
x       = [7, 38, 4, 23, 18];
x2      = x.^2;
x2mu    = compMean(x2);
xmu     = compMean(x);
xvar    = compVariance(x);
fprintf('The Variance of X \t= %.2f \n', xvar);
fprintf('E[X^2]-E[X]^2 \t\t= %.2f \n', x2mu - xmu^2);
