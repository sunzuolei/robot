% Show state correlation.
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

%% Correlation
s = 1 : step;
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