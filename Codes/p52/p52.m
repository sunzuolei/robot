%% Calculate the Jacobians
close all; clc; clear all;
%%
syms x y theta dx dy dtheta xs ys;
f = [dx * cos(theta) - dy * sin(theta) + x;
     dy * cos(theta) + dx * sin(theta) + y;
     dtheta + theta];
X = [x,  y, theta];
F = jacobian(f, X);
disp(F);
simplify(F)
%%
h = atan((y - ys) / (x - xs));
H = jacobian(h, X);
disp(H);
simplify(H)
pretty(H);