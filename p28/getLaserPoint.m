function points = getLaserPoint(range, maxR)
len    = length(range);

if len ~= 361 && len ~= 181
    error('The raw range data is not valid.')
end

bear   = -pi/2 : pi/(len-1) : pi/2;
i      = find(range < maxR);
range  = range(i);
bear   = bear(i);
points = [range .* cos(bear);
          range .* sin(bear)];
end