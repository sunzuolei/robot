%% The main function
function p5
    clc; clear all; close all;
    p = [0, 0.5, 0, 0.5, 0]; 
%     p = [0,  1,  0,  0,  0]; 
%     p = [0.2,0.2,0.2,0.2,0.2]; 
    u = 2;                               
    pExact = 0.8;
    pOvershoot = 0.1;
    pUndershoot = 0.1;
    q = move(p, u, pExact, pOvershoot, pUndershoot);
    disp(p);
    disp(q);
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