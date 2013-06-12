function angle = piTopi(angle)
    % Input: array of angles.
    % Output: normalised angles.
    % Tim Bailey 2000, modified 2005.
    % Samuel modifies it to bound the angle at 
    % [-pi, pi).

    % Note: either rem or mod will work correctly
    %angle = mod(angle, 2*pi); % mod() is very slow for some versions of MatLab (not a builtin function)
    %angle = rem(angle, 2*pi); % rem() is typically builtin

    twopi = 2*pi;
    angle = angle - twopi*fix(angle/twopi); % this is a stripped-down version of rem(angle, 2*pi)

    i = find(angle >= pi); % Samuel modifies.
    angle(i) = angle(i) - twopi;

    i = find(angle < -pi);
    angle(i) = angle(i) + twopi;
end