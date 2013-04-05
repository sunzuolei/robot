%% The main function
function p7
    clc; clear all; close all;
    p = [1, 0, 0, 0, 0]; 
    u = 1; 
    step = 100;
    pExact = 0.8;
    pOvershoot = 0.1;
    pUndershoot = 0.1;
    entropy = zeros(1, step);
    for i = 1 : step
        p = move(p, u, pExact, pOvershoot, pUndershoot);
        entropy(i) = -sum(p .* log2(p) );        
        disp(i);
        disp(p);
    end  
    h = figure(1);
    hold on;    
    plot(1:step, entropy, '-', 'linewidth', 2,   'color', 'g');
    plot(1:step, entropy, '^', 'linewidth', 1.5, 'color', 'r');
    xlabel('Motion step');
    ylabel('Entropy');
    print(h, '-dpng', 'entropy.png');
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