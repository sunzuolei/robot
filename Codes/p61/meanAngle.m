function outAng = meanAngle(inAng, dim, sens)

% Seeded by J.A. Dunne, 10-20-05
% http://www.mathworks.com/matlabcentral/fileexchange/12631-mean-angle
% Modified by Samuel, Jun, 13, 2013
% based on: http://rosettacode.org/wiki/Averages/Mean_angle
% =========================================================
% It calculates the mean of a set of angles (in rad) based
% on polar considerations.
% 
% Inputs:
%   inAng - a vector or matrix of angles (in rad)
%   dim   - the dimension it operates along, if not specified, 
%           the first non-singleton dimension is used.
%   sense - the sensitivity factor to determine oppositeness, 
%           and is how close the mean of the complex representations
%           of the angles can be to zero before being called zero.  
%           For nearly all cases, this parameter is fine at its default 
%           (1e-12), but it can be readjusted as a third parameter if
%           necessary.
% Outputs:
%   outAng - the resulting angles.
%

if nargin < 3
    sens = 1e-12;
end

if nargin < 2
    ind = find( size(inAng) > 1, 1 );
    if isempty(ind)
        % This is a scalar
        outAng = inAng;
        return
    end
    dim = ind;
end

in     = exp( inAng * 1i );   % According to Euler's formula
mid    = mean( in, dim );
outAng = atan2( imag(mid),  real(mid) );
% outAng( abs(mid) < sens ) = nan;
