function p = product2d(p1, p2, x, y)
    p = p1.* p2;
    p = p / trapz(y, trapz(x,p));
end