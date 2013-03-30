%% The main function
function p6
    clc; clear all; close all;
    p = [1, 0, 0, 0, 0]; 
    u = 1; 
    step = 100;
    pExact = 0.8;
    pOvershoot = 0.1;
    pUndershoot = 0.1;
    for i = 1 : step
        p = move(p, u, pExact, pOvershoot, pUndershoot);
        disp(i);
        disp(p);
        h = figure(1);
        bar(p,'hist');
        ylabel('Probability');
        ylim([0, 0.7]);
        title(['step = ', int2str(i)]);
        colormap spring ;
%         print(h, '-depsc2', ['./Figs/step', int2str(i), '.eps']);
        print(h, '-dpng', ['./Figs/step', int2str(i), '.png']);
        pause(0.2);
    end    
end

%%
function q = move(p, u, pExact, pOvershoot, pUndershoot)
    n = length(p);
    q = zeros(1, n);
    for i = 1 : n
        q(i) = pExact * p(mod(i-1-u, n) + 1); 
        q(i) = q(i) + pOvershoot * p(mod(i-2-u, n) + 1);
        q(i) = q(i) + pUndershoot * p(mod(i-u, n) + 1);
    end
end