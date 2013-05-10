close all; clc; clear all;

Xab     = [96; 35; degtorad(62)];
Xba     = inverse(Xab);
Xab_    = inverse(Xba);
Xab_(3) = radtodeg(Xab_(3));
disp(Xab_);