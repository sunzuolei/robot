clc; close all; clear all;
syms t x y t;

X    = [x; y; t];
negX = -X;

R    = [ cos(negX(3)), -sin(negX(3)), 0;
          sin(negX(3)), cos(negX(3)), 0;
           0,               0,        1];
invR = [ -cos(X(3)), -sin(X(3)),      0;
          sin(X(3)), -cos(X(3)),      0;
           0,               0,       -1];
r1   = R * negX;
r2   = invR * X;
r3   = r1 - r2;

%% 
disp('R * (-X) is:');
disp(r1);
disp('inv(R) * X is:');
disp(r2);