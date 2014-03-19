close all; clc; clear all;
path(path, genpath('../p31'));
path(path, genpath('../p22'));
%%
Xab     = [5; 3; degtorad(50)];
Xwb     = [9; 6; degtorad(70)];

%% First solution
Xba     = inverse(Xab);
Xwa     = compound(Xwb, Xba);
disp('Fisrt solution: ')
disp(Xwa);
%% Second solution
Xwa2    = inverse(compound(Xab, inverse(Xwb)));
disp('Second solution: ')
disp(Xwa2);