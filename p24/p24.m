clc; clear all; close all;
path(path, genpath('../p22'));
%%
rob = [0 -3 -3; 
       0 -1  1] * 0.5;
%%
figure('name', 'Robot appearance')
patch(rob(1, :), rob(2, :), 'g');
axis equal;
box on;
print('-dpng', 'robotbody.png');
%%
Xwa  = [5; 3; degtorad(50)];
Xab  = [4; 2; degtorad(20)];
Xwb  = compound(Xwa, Xab);
%%
robA = compound(Xwa, rob);
robB = compound(Xwb, rob);
%% 
figure('name', 'Visualization of robot body')
hold on;
axis equal;
grid minor;
xlim([0, 8]);
ylim([0, 8]);
pRobA = patch(robA(1, :), robA(2, :), [255,215,0]/255);
text(Xwa(1), Xwa(2), '\leftarrow  X_{wa}', 'FontSize', 18);
pRobB = patch(robB(1, :), robB(2, :), [127,255,0]/255);
text(Xwb(1), Xwb(2), '\leftarrow  X_{wb}', 'FontSize', 18);
print('-dpng', 'tworobot.png');