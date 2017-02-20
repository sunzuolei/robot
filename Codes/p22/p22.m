clc; clear; close all;

Xwa = [5; 3; degtorad(50)];
Xab = [4; 2; degtorad(20)];
Xwb = compound(Xwa, Xab);
fprintf('Xwb is (%.2fm, %.2fm, %.2fdegree)\n',...
    Xwb(1), Xwb(2), radtodeg(Xwb(3)));