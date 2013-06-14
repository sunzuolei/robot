% Test the mean of angle
clear all; close all; clc;
path(path, '../p61');  % For calling meanAngle

angs = degtorad([-177, 179]);
disp(radtodeg(meanAngle(angs)));

angs = degtorad([350, 10]);
disp(radtodeg(meanAngle(angs)));

angs = degtorad([10, 20, 30]);
disp(radtodeg(meanAngle(angs)));

angs = degtorad([90, 180, 270, 360]);
disp(radtodeg(meanAngle(angs)));