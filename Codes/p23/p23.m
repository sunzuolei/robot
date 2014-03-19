clc; clear all; close all;
path(path, genpath('../p22'));
%%
Xwa  = [5; 3; degtorad(50)];
Xad  = [5; 2];
Xaf  = [3; 2.5];
Xadf = [Xad, Xaf];
Xwd  = compound(Xwa, Xad);
Xwf  = compound(Xwa, Xaf);
Xwdf = compound(Xwa, Xadf);
%% 
disp('Xwd   = ');
disp(Xwd);
disp('Xwf   = ');
disp(Xwf);
disp('Xwdf  = ');
disp(Xwdf);
