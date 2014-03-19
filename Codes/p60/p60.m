close all; clear all; clc;
path(path, '../p34'); % For calling piTopi
path(path, '../p61'); % For calling compWeight
Sigma  = 0.1;
zTrue  = degtorad(179);
zPredA = degtorad(178);  % error: 1
zPredB = degtorad(-179); % error: 2
zPredC = degtorad(-178); % error: 3
zPredD = degtorad(185);  % error: 6
zPredE = degtorad(0);    % error: 179
%% The bigger the error, the smaller the weight.
wA     = compWeight(zPredA, zTrue, Sigma, true)
wB     = compWeight(zPredB, zTrue, Sigma, true)
wC     = compWeight(zPredC, zTrue, Sigma, true)
wD     = compWeight(zPredD, zTrue, Sigma, true)
wE     = compWeight(zPredE, zTrue, Sigma, true)