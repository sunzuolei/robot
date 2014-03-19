close all; clear all; clc;
%%
rng(222);               % Control random number generation to ensure the 
                        % noise can be reproduced exactly.
noiseA = randn(1, 5);
%%
% rng(223);   
noiseB = randn(1, 5);
%%
disp(noiseA - noiseB);