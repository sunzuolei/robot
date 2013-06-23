close all; clear all; clc;

a = 1;
b = 2;
c = 3;
d = 4;
e = 5;
f = 6;
g = 7;


mu = [a b]';
invSigma = [ c  d;
             d  e ];
x  = [f g]';
first  = mu' * invSigma * x ;
second = x' * invSigma * mu ;
disp(first);
disp(second);
