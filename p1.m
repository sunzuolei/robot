clc; clear all; close all;
%% The first method
n = 10;
p = zeros(1, n);
for i = 1 : n
    p(1, i) = 1/n;
end
disp(p);

%% The optional methods that are fairly expensive for Matlab
% n = 10;
% p = [ ];
% for i = 1 : n
%     p = [p, 1/n];
% end
% disp(p);


n = 10;
p = [ ];
for i = 1 : n
    p = [p; 1/n];
end
disp(p);