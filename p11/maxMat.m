function [r, c] = maxMat(g)
% Find the index of the largest element of g
    [temp,r] = max(g);
    [~,c] = max(temp);
    r = r(c);
end