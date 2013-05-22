close all; clear all; clc;
%%
rng(222);               % Control random number generation to ensure the 
                        % noise can be reproduced exactly.
noiseA = randn(1, 5);
%%
rng(222);   
noiseB = randn(1, 5);
%%
disp(noiseA - noiseB);