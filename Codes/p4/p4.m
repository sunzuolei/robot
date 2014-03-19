%% The main function
function p4
    clc; clear all; close all;
    p = [1/9, 1/3, 1/3, 1/9, 1/9];    
    u = -1;          % Control
    q = move(p, u); % Motion model
    disp('Before motion:');
    disp(p);
    disp('After motion:');
    disp(q);
end
%%
function q = move(p, u)
    n = length(p);
    q = zeros(1, n);
    for i = 1 : n
        q(i) = p(mod(i-1-u, n) + 1); % Circular convolution.
    end
%     If you are moving to the right, you may be tempted to use a plus sign. 
%     Don't! Instead of thinking of it as p shifting to a cell in q,think of 
%     this function as q grabbing from a cell in p. For example, if we are 
%     shifting p one to the right, each cell in q has to grab its value from 
%     the cell in p that is one to the left. 
end