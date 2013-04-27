function mu = compMean(x)
    mu = sum(sum(x))/ (size(x,1) * size(x,2));
end