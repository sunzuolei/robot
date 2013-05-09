clc; clear all; close all;
path(path, genpath('../p22'));

Xwa         = [5; 3; degtorad(50)];
disB        = 7;
rotB        = degtorad(40);
[xab, yab]  = pol2cart(rotB, disB);
Xab         = [xab; yab; rotB];
Xwb         = compound(Xwa, Xab);
fprintf('Xwb is (%.2fm, %.2fm, %.2fdegree)\n',...
    Xwb(1), Xwb(2), radtodeg(Xwb(3)));