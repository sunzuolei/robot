function sigma2 = compVariance(x)
    mean = inline('sum(sum(x))/ (size(x,1)*size(x,2))');
    mu = mean(x);
    x2 = (x-mu).^2;
    sigma2 = mean(x2);
end