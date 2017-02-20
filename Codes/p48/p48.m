close all; clc; clear all;

syms x y vx vy xs ys 
h = atan((y - ys) / (x - xs));
X = [x, vx, y, vy];
H = jacobian(h, X);
disp(H);
H2 = simplify(H)
pretty(H2);