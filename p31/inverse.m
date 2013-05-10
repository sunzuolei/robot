function Xba = inverse(Xab)

    if size(Xab, 1) ~= 3 || size(Xab, 2) ~= 1
        error('Xab should be of the size 3*1!');
    end
    R   = [ -cos(Xab(3)), -sin(Xab(3)), 0;
            sin(Xab(3)),  -cos(Xab(3)), 0;
                0,        0,            -1];
    Xba = R * Xab;
    
    Xba(3) = piTopi(Xba(3));
end

function angle = piTopi(angle)
    % Input: array of angles.
    % Output: normalised angles.
    % Tim Bailey 2000, modified 2005.

    % Note: either rem or mod will work correctly
    %angle = mod(angle, 2*pi); % mod() is very slow for some versions of MatLab (not a builtin function)
    %angle = rem(angle, 2*pi); % rem() is typically builtin

    twopi = 2*pi;
    angle = angle - twopi*fix(angle/twopi); % this is a stripped-down version of rem(angle, 2*pi)

    i = find(angle > pi);
    angle(i) = angle(i) - twopi;

    i = find(angle < -pi);
    angle(i) = angle(i) + twopi;
end
