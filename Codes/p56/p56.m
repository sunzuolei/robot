%% Calculate the Jacobians
close all; clc; clear all;
%%
syms x y theta xs ys;
X = [x y theta];
%%
h = [atan((y - ys) / (x - xs));...
    sqrt((x-xs)^2 + (y-ys)^2)];
H = jacobian(h, X);
disp(H);
simplify(H)