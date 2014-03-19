close all;clear all;clc;
%%
path(path, genpath('..\..\robotcourse'));
load '../data/tim.mat'
clear lm;
steering  = 0;       % initial steering
velocity  = 4.0;     % the velocity of the vehicle
wheelbase = 8;       % the length of wheelbase
dt        = 0.05;    % time interval
iWp       = 1;% index to first waypoint 
iPos      = 1;
rob       = [0  -wheelbase  -wheelbase;   
            0        -4           4  ];

%% Initialize figure
figPos    = get(0, 'ScreenSize'); % [left, bottom, width, height]
figPos(3) = figPos(3) - 100;
figure('name', 'Motion animation',...
       'position', figPos,...
       'color', 'w', 'Menu', 'none');
hold on; box on; grid minor;
pathPlot  = plot (0, 0, 'r-', 'linewidth', 5, 'erasemode','normal');
robPlot   = patch(0, 0, 'b', 'erasemode', 'normal');
plot(wp(1, :), wp(2, :), 'g*', 'markersize', 10, 'linewidth',2);
plot(wp(1, :), wp(2, :), 'c:', 'linewidth', 2);
xlabel('X(m)');
ylabel('Y(m)');
axis equal;
axis([-110  100  -110  100]);
pos  = zeros(3,1);
path = zeros(3,3390);

%% Main loop
while iWp ~=0
     [steering, iWp]= compSteer(pos, wp, iWp, steering, dt);% compute the steering and next waypoint
     %%
     pos(1) = pos(1) + velocity * dt * cos(steering + pos(3,:)); 
     pos(2) = pos(2) + velocity * dt * sin(steering + pos(3,:));
     pos(3) = pos(3) + velocity * dt * sin(steering) / wheelbase;% compute new vehicle pose
     pos(3) = piTopi(pos(3));
     robPos = compound(pos,rob);
     path(:, iPos + 1) = pos;
     iPos = iPos + 1;
     %%     
     set(pathPlot, 'xdata', path(1, 1:iPos), 'ydata', path(2, 1:iPos));
     set(robPlot,  'xdata', robPos(1, :), 'ydata', robPos(2, :)); 
     drawnow;
end
print('-dpng', 'path.png');


 
