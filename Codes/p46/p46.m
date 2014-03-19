path(path, '../p45');
p45;
close all;
width = 2;
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

%% SD of states
s     = 1 : step;
figure('Name', 'standard deviation ', 'color', 'w', ...
    'units','normalized', 'outerposition',[0 0 1 1]);
box on; 
subplot(2, 1, 1)
h = plot(s, sigmaXXPred(s), 'b-', s, sigmaXXPost(s), 'r-');
set(h, 'linewidth', width);
xlim([min(s), max(s)]);
hold on;
grid minor;
legend('\sigma^x_{pred}', '\sigma^x_{post}', 'location', 'best');
ylabel('\sigma (m)');
title('SD in x');
%
subplot(2, 1, 2)
h = plot(s, sigmaVxVxPred(s), 'b-', s, sigmaVxVxPost(s), 'r-');
set(h, 'linewidth', width);
xlim([min(s), max(s)]);
hold on;
grid minor;
legend('\sigma^{v_x}_{pred}', '\sigma^{v_x}_{post}', 'location', 'best');
ylabel('\sigma (m/s)');
xlabel('step');
title('SD in v_x');
print('-dpng', 'sigma.png');