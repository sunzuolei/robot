function Xwb = compound(Xwa, Xab)
% 
% For details, please refer to Section 3.2.1 of R. Smith, M. Self, 
% "Estimating uncertain spatial relationships in robotics," 
% Autonomous Robot Vehicles, pp. 167-193, 1990. 
%   Xwa - should be of size 3*1 or 1*3
%   Xab - can be 3*n or 2*n matrix
% Seeded by Tim Bailey
% Modified by Samuel on 7 May 2013

   rot = [cos(Xwa(3))    -sin(Xwa(3)); 
          sin(Xwa(3))     cos(Xwa(3))];
   
   Xwb(1:2,:) = rot * Xab(1:2,:) + repmat(Xwa(1:2), 1, size(Xab,2));

    %% if Xwb is a pose and not a point
    if size(Xab,1) == 3
       Xwb(3,:) = piTopi(Xwa(3,:) + Xab(3));
    end
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

    i = find(angle >= pi);
    angle(i) = angle(i) - twopi;

    i = find(angle < -pi);
    angle(i) = angle(i) + twopi;
end