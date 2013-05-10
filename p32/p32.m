close all; clc; clear all;
path(path, genpath('../p31'));
Xab     = [5; 3; degtorad(50)];
Xba     = inverse(Xab);
disp('Xba = ')
disp(Xba);