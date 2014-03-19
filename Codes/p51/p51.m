%%
path(path, '../p49');
path(path, '../p43');
p49;
close all;
width = 1;
%%
sigmaXXPred    = reshape(SigmaPred(1,1,:),1,[]);
sigmaVxVxPred  = reshape(SigmaPred(2,2,:),1,[]);
sigmaYYPred    = reshape(SigmaPred(3,3,:),1,[]);
sigmaVyVyPred  = reshape(SigmaPred(4,4,:),1,[]);
sigmaXVxPred   = reshape(SigmaPred(1,2,:),1,[]);
sigmaXYPred    = reshape(SigmaPred(1,3,:),1,[]);
sigmaXVyPred   = reshape(SigmaPred(1,4,:),1,[]);
sigmaYVyPred   = reshape(SigmaPred(3,4,:),1,[]);
%
rhoXVxPred     = sigmaXVxPred ./ sqrt(sigmaXXPred .* sigmaVxVxPred);
rhoXYPred      = sigmaXYPred  ./ sqrt(sigmaXXPred .* sigmaYYPred);
rhoXVyPred     = sigmaXVyPred ./ sqrt(sigmaXXPred .* sigmaVyVyPred);
rhoYVyPred     = sigmaYVyPred ./ sqrt(sigmaYYPred .* sigmaVyVyPred);
%
sigmaXXPost    = reshape(SigmaPost(1,1,:),1,[]);
sigmaVxVxPost  = reshape(SigmaPost(2,2,:),1,[]);
sigmaYYPost    = reshape(SigmaPost(3,3,:),1,[]);
sigmaVyVyPost  = reshape(SigmaPost(4,4,:),1,[]);
sigmaXVxPost   = reshape(SigmaPost(1,2,:),1,[]);
sigmaXYPost    = reshape(SigmaPost(1,3,:),1,[]);
sigmaXVyPost   = reshape(SigmaPost(1,4,:),1,[]);
sigmaYVyPost   = reshape(SigmaPost(3,4,:),1,[]);
%
rhoXVxPost     = sigmaXVxPost ./ sqrt(sigmaXXPost .* sigmaVxVxPost);
rhoXYPost      = sigmaXYPost  ./ sqrt(sigmaXXPost .* sigmaYYPost);
rhoXVyPost     = sigmaXVyPost ./ sqrt(sigmaXXPost .* sigmaVyVyPost);
rhoYVyPost     = sigmaYVyPost ./ sqrt(sigmaYYPost .* sigmaVyVyPost);

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