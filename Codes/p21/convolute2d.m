function p = convolute2d(p1, p2, x, y)
    p = conv2(p1, p2, 'same');
    p = p / trapz(y, trapz(x,p));
end