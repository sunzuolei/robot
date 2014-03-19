% To demonstrate entropy of a coin flip. 
% for more information please refer to 
% http://en.wikipedia.org/wiki/Entropy_(information_theory)
% http://upload.wikimedia.org/wikipedia/commons/thumb/2/22/Binary_entropy_plot.svg/200px-Binary_entropy_plot.svg.png
% 
clc; close all; clear all;
pHead = 0 : 0.01 : 1;
n = length(pHead);
H = zeros(1, n);
for i = 1 : n
    p = [pHead(i), 1 - pHead(i)];
    if (pHead(i) == 0)
        p = 1 - pHead(i);
    elseif 1 - pHead(i) == 0;
        p = pHead(i);
    end
        
    H(i) = -sum(p .* log2(p) );
    if mod(pHead(i), 0.1) == 0 && pHead(i)~= 0 && pHead(i) ~= 1
        htemp = figure(1);
        bar(p,1);
        ylim([0,1]);
        set(gca, 'XTickLabel', {'pHead', 'pTail'});
        ylabel('Probability');
        title(sprintf('pHead=%.2f, pTail=%.2f', pHead(i), 1 - pHead(i)));
        colormap(cool);
        print(htemp, '-dpng', sprintf('phead=%.2f.png', pHead(i)));
    end
end
h = figure(2);
plot(pHead, H, '-', 'linewidth', 2, 'color', 'r');
set(gca, 'XTick', 0:0.1:1);
xlabel('The probability of being head');
ylabel('Entropy');
grid on;
print(h, '-dpng', 'entropycoin.png');

disp(H);