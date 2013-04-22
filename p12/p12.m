
clc; clear all; close all;
pCan = 0.001;
pNon = 0.999;       
z = 'positive';   
% z = 'negative'; 
pPosCan = 0.8;                          
pPosNon = 0.1;

if strcmp('positive', z)
   p = [pPosCan * pCan, pPosNon * pNon];
else
   p = [(1 - pPosCan) * pCan, (1 - pPosNon) * pNon]; 
end
p = p / sum(p); 
fprintf('The probability of having cancer given the %s test:\n', z);
disp(p(1));
fprintf('The probability of cancer free given the %s test:\n', z);
disp(p(2));


