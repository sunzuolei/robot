% Visualize state and its standard deviation.
path(path, '../p39');
p39;
close all;
width = 1;
%%
sigmaXXPred    = sqrt(reshape(SigmaPred(1,1,:),1,[]));
sigmaVxVxPred  = sqrt(reshape(SigmaPred(2,2,:),1,[]));
sigmaYYPred    = sqrt(reshape(SigmaPred(3,3,:),1,[]));
sigmaVyVyPred  = sqrt(reshape(SigmaPred(4,4,:),1,[]));
%
sigmaXXPost    = sqrt(reshape(SigmaPost(1,1,:),1,[]));
sigmaVxVxPost  = sqrt(reshape(SigmaPost(2,2,:),1,[]));
sigmaYYPost    = sqrt(reshape(SigmaPost(3,3,:),1,[]));
sigmaVyVyPost  = sqrt(reshape(SigmaPost(4,4,:),1,[]));

%% States
s     = 1 : step;
figure('Name', 'states', 'color', 'w', ...
    'units','normalized', 'outerposition',[0 0 1 1])
hold on; box on; grid minor;
subplot(2, 2, 1)
h = plot(s, xTrue(1,s), 'k-',  s, zTrue(1,s), 'b-', ...
     s, muPred(1,s), 'g-',  s, muPost(1,s), 'r-');
set(h, 'linewidth', width);
xlim([min(s), max(s)]);
legend('x_{true}', 'z_x', 'x_{pred}', 'x_{post}', 'location', 'best');
ylabel('Positon (m)');
title('Position in x');
%
subplot(2, 2, 2)
h = plot(s, xTrue(3,s), 'k-',  s, zTrue(2,s), 'b-', ...
     s, muPred(3,s), 'g-',  s, muPost(3,s), 'r-');
set(h, 'linewidth', width);
xlim([min(s), max(s)]);
legend('y_{true}', 'z_y', 'y_{pred}', 'y_{post}', 'location', 'best');
title('Position in y');
%
subplot(2, 2, 3)
h = plot(s, xTrue(2,s), 'k-', s, muPred(2,s), 'g-',  s, muPost(2,s), 'r-');
set(h, 'linewidth', width);
xlim([min(s), max(s)]);
legend('V^x_{true}', 'V^x_{pred}', 'V^x_{post}', 'location', 'best');
title('Velocity in x');
xlabel('Step');
ylabel('Velocity (m/s)');
%
subplot(2, 2, 4)
h = plot(s, xTrue(4,s), 'k-', s, muPred(4,s), 'g-',  s, muPost(4,s), 'r-');
set(h, 'linewidth', width);
xlim([min(s), max(s)]);
legend('V^y_{true}', 'V^y_{pred}', 'V^y_{post}', 'location', 'best');
title('Velocity in y');
xlabel('step');
print('-dpng', 'mu.png');

%% SD of states
figure('Name', 'standard deviation ', 'color', 'w', ...
    'units','normalized', 'outerposition',[0 0 1 1]);
hold on; box on; grid minor;
subplot(2, 2, 1)
h = plot(s, sigmaXXPred(s), 'b-', s, sigmaXXPost(s), 'r-');
set(h, 'linewidth', width);
xlim([min(s), max(s)]);
legend('\sigma^x_{pred}', '\sigma^x_{post}', 'location', 'best');
ylabel('\sigma (m)');
title('SD in x');
%
subplot(2, 2, 2)
h = plot(s, sigmaYYPred(s), 'b-', s, sigmaYYPost(s), 'r-');
set(h, 'linewidth', width);
xlim([min(s), max(s)]);
legend('\sigma^y_{pred}', '\sigma^y_{post}', 'location', 'best');
title('SD in y');
%
subplot(2, 2, 3)
h = plot(s, sigmaVxVxPred(s), 'b-', s, sigmaVxVxPost(s), 'r-');
set(h, 'linewidth', width);
xlim([min(s), max(s)]);
legend('\sigma^{v_x}_{pred}', '\sigma^{v_x}_{post}', 'location', 'best');
ylabel('\sigma (m/s)');
xlabel('step');
title('SD in v_x');
%
subplot(2, 2, 4)
h = plot(s, sigmaVyVyPred(s), 'b-', s, sigmaVyVyPost(s), 'r-');
set(h, 'linewidth', width);
xlim([min(s), max(s)]);
legend('\sigma^{v_y}_{pred}', '\sigma^{v_y}_{post}', 'location', 'best');
xlabel('step');
title('SD in v_y');
print('-dpng', 'sigma.png');

%% Differences between predicted and updated state
s  = 1 : step;
diff = muPost - muPred;
figure('Name', 'Differences between predicted and updated state',...
   'color', 'w', 'units','normalized', 'outerposition',[0 0 1 1])
hold on; box on; 
subplot(2, 1, 1)
h = plot(s, diff(1,s), 'r-', s, sigmaXXPost(s), 'b-',...
         s, 2 * sigmaXXPost(s), 'c-', s, 3 * sigmaXXPost(s), 'g-', ...
         s, -sigmaXXPost(s), 'b-',    s, -2 * sigmaXXPost(s), 'c-', ...
         s, -3 * sigmaXXPost(s), 'g-');
set(h, 'linewidth', width);
xlim([min(s), max(s)]);
ylim(3 * [-3 * max(sigmaXXPost(10:step)),...
    3 * max(sigmaXXPost(10:step))]);
hLeg = legend('x_{post}-x_{pred}', '1-\sigma^x_{post}',...
       '2-\sigma^x_{post}', '3-\sigma^x_{post}');
set(hLeg, 'location', 'south', 'orientation', 'horizontal');
ylabel('Error (m)');
title('Differences between predicted and updated x');
%
subplot(2, 1, 2)
h = plot(s, diff(2,s), 'r-', s, sigmaVxVxPost(s), 'b-',...
         s, 2 * sigmaVxVxPost(s), 'c-', s, 3 * sigmaVxVxPost(s), 'g-', ...
         s, -sigmaVxVxPost(s), 'b-',    s, -2 * sigmaVxVxPost(s), 'c-', ...
         s, -3 * sigmaVxVxPost(s), 'g-');
set(h, 'linewidth', width);
xlim([min(s), max(s)]);
ylim(3 * [-3 * max(sigmaVxVxPost(10:step)),...
    3 * max(sigmaVxVxPost(10:step))]);
hLeg = legend('v^x_{post}-v^x_{pred}', '1-\sigma^{v_x}_{post}',...
       '2-\sigma^{v_x}_{post}', '3-\sigma^{v_x}_{post}');
set(hLeg, 'location', 'south', 'orientation', 'horizontal');
ylabel('Error (m/s)');
title('Differences between predicted and updated v_x');
print('-dpng', 'statediffer.png');
