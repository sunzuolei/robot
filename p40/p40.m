% Visualize CV-based linear KF
path(path, '../p39');
p39;
close all;
width = 1;
%%
sigmaXXPred    = sqrt(reshape(SigmaPred(1,1,:),1,[]));
sigmaVxVxPred  = sqrt(reshape(SigmaPred(2,2,:),1,[]));
sigmaYYPred    = sqrt(reshape(SigmaPred(3,3,:),1,[]));
sigmaVyVyPred  = sqrt(reshape(SigmaPred(4,4,:),1,[]));
sigmaXVxPred   = sqrt(reshape(SigmaPred(1,2,:),1,[]));
sigmaXYPred    = sqrt(reshape(SigmaPred(1,3,:),1,[]));
sigmaXVyPred   = sqrt(reshape(SigmaPred(1,4,:),1,[]));
sigmaYVyPred   = sqrt(reshape(SigmaPred(3,4,:),1,[]));
%
rhoXVxPred     = sigmaXVxPred ./ (sigmaXXPred .* sigmaVxVxPred);
rhoXYPred      = sigmaXYPred  ./ (sigmaXXPred .* sigmaYYPred);
rhoXVyPred     = sigmaXVyPred ./ (sigmaXXPred .* sigmaVyVyPred);
rhoYVyPred     = sigmaYVyPred ./ (sigmaYYPred .* sigmaVyVyPred);
%
sigmaXXPost    = sqrt(reshape(SigmaPost(1,1,:),1,[]));
sigmaVxVxPost  = sqrt(reshape(SigmaPost(2,2,:),1,[]));
sigmaYYPost    = sqrt(reshape(SigmaPost(3,3,:),1,[]));
sigmaVyVyPost  = sqrt(reshape(SigmaPost(4,4,:),1,[]));
sigmaXVxPost   = sqrt(reshape(SigmaPost(1,2,:),1,[]));
sigmaXYPost    = sqrt(reshape(SigmaPost(1,3,:),1,[]));
sigmaXVyPost   = sqrt(reshape(SigmaPost(1,4,:),1,[]));
sigmaYVyPost   = sqrt(reshape(SigmaPost(3,4,:),1,[]));
%
rhoXVxPost     = sigmaXVxPost ./ (sigmaXXPost .* sigmaVxVxPost);
rhoXYPost      = sigmaXYPost  ./ (sigmaXXPost .* sigmaYYPost);
rhoXVyPost     = sigmaXVyPost ./ (sigmaXXPost .* sigmaVyVyPost);
rhoYVyPost     = sigmaYVyPost ./ (sigmaYYPost .* sigmaVyVyPost);
%% States
s     = 1 : step;
figure('Name', 'states','units','normalized', 'outerposition',[0 0 1 1])
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
figure('Name', 'standard deviation ',...
    'units','normalized', 'outerposition',[0 0 1 1],...
    'papertype', 'A0')
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
    'units','normalized', 'outerposition',[0 0 1 1])
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
%% Innovation and innovation SD
s = 1 : step;
sigmaYx = sqrt(reshape(SigmaInnov(1,1,s),1,[]));
sigmaYy = sqrt(reshape(SigmaInnov(2,2,s),1,[]));
figure('Name', 'Innovation and innovation SD',...
    'units','normalized', 'outerposition',[0 0 1 1])
hold on; box on; grid minor;
subplot(2, 1, 1)
h = plot(s, innov(1, s), 'b-',...
         s, sigmaYx, 'r-',...
         s, 2 * sigmaYx, 'c-',...
         s, 3 * sigmaYx, 'g-',...
         s, -sigmaYx, 'r-',...
         s, -2 * sigmaYx, 'c-',...
         s, -3 * sigmaYx, 'g-');
set(h, 'linewidth', width);
xlim([min(s), max(s)]);
idx = floor(length(s)*0.5) : length(s);
ylim(max(sigmaYx(s(idx))) * 7 * [-1, +1]);
hLeg = legend('Y_{x}', '1-\sigma', '2-\sigma', '3-\sigma');
set(hLeg, 'location', 'south', 'orientation', 'horizontal');
ylabel('(m)');
title('Innoviation and its SD in x');
%
subplot(2, 1, 2)
h = plot(s, innov(2, s), 'b-',...
         s, sigmaYy, 'r-',...
         s, 2 * sigmaYy, 'c-',...
         s, 3 * sigmaYy, 'g-',...
         s, -sigmaYy, 'r-',...
         s, -2 * sigmaYy, 'c-',...
         s, -3 * sigmaYy, 'g-');
set(h, 'linewidth', width);
xlim([min(s), max(s)]);
ylim(max(sigmaYx(s(idx))) * 7 * [-1, +1]);
hLeg = legend('Y_{y}', '1-\sigma ', '2-\sigma', '3-\sigma');
set(hLeg, 'location', 'south', 'orientation', 'horizontal');
ylabel('(m)');
title('Innoviation and its SD in y');
print('-dpng', 'innovandsigma.png');
%% 
% s = 1 : step;
time = 0 : dt : dt * (step-1);
[normY, moveAverY, chiUp, chiLow] ...
    = analyseInnov(innov, SigmaInnov, time);
figure('Name', 'Innovation analysis',...
    'units','normalized', 'outerposition',[0 0 1 1]);
hold on; box on;
subplot(2, 1, 1);
h = plot(time, normY(1,:), 'g-', time, moveAverY(1,:), 'r-',...
         time, chiUp(1,:), 'b-', time, chiLow(1,:), 'b-');
set(h, 'linewidth', width);
% legend('Normalised innovations','Moving average',...
%     '95% Confidence bounds');
title('Normalised Innovations and Innovation Confidence Bounds in x');
% xlim([min(s), max(s)]);
ylabel('Innovation (m)');
%
subplot(2, 1, 2);
h = plot(time, normY(2,:), 'g-', time, moveAverY(2,:), 'r-',...
         time, chiUp(2,:), 'b-', time, chiLow(2,:), 'b-');
set(h, 'linewidth', width);
legend('Normalised innovations','Moving average',...
    '95% Confidence bounds');
title('Normalised Innovations and Innovation Confidence Bounds in y');
% xlim([min(s), max(s)]);
ylabel('Innovation (m)');
xlabel('Time (s)');
print('-dpng', 'innovationchitest.png');
%% Correlation
s = 1 : step;
% 
figure('Name', 'Correlation',...
    'units','normalized', 'outerposition',[0 0 1 1])
hold on; box on; grid minor;
subplot(4, 1, 1)
h = plot(s, rhoXVxPred(s), 'b-', s, rhoXVxPost(s), 'r-');
set(h, 'linewidth', width);
xlim([min(s), max(s)]);
legend('\rho^{xv_x}_{pred}', '\rho^{xv_x}_{post}',...
     'location', 'south', 'orientation', 'horizontal');
ylabel({'Correlation','Coefficient'});
title('Cross correlation between x and v_x');
%
subplot(4, 1, 2)
h = plot(s, rhoXYPred(s), 'b-', s, rhoXYPost(s), 'ro');
set(h, 'linewidth', width);
xlim([min(s), max(s)]);
legend('\rho^{xy}_{pred}', '\rho^{xy}_{post}',...
     'location', 'south', 'orientation', 'horizontal');
ylabel({'Correlation','Coefficient'});
title('Cross correlation between x and y');
%
subplot(4, 1, 3)
h = plot(s, rhoXVyPred(s), 'b-', s, rhoXVyPost(s), 'ro');
set(h, 'linewidth', width);
xlim([min(s), max(s)]);
legend('\rho^{xv_y}_{pred}', '\rho^{xv_y}_{post}',...
     'location', 'south', 'orientation', 'horizontal');
ylabel({'Correlation','Coefficient'});
title('Cross correlation between x and v_y');
%
subplot(4, 1, 4)
h = plot(s, rhoYVyPred(s), 'b-', s, rhoYVyPost(s), 'r-');
set(h, 'linewidth', width);
xlim([min(s), max(s)]);
legend('\rho^{yv_y}_{pred}', '\rho^{yv_y}_{post}',...
     'location', 'south', 'orientation', 'horizontal');
ylabel({'Correlation','Coefficient'});
xlabel('step');
title('Cross correlation between y and v_y');
print('-dpng', 'statecorrelation.png');