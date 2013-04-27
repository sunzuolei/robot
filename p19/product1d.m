function fxy = product1d(fx,fy,x)
%
%	function to multiply two probability distirbutions
%	FX, FY vectors of probability density
%  X range of values over which density is defined
%
% Algorithm: FFT of data (general version would use fftn and ifftn)
% seeded by Hugh
% revised by Samuel

fxLen = length(fx);
fyLen = length(fy);
xLen  = length(x);
if fxLen ~= fyLen
   error('Probability vectors must be of the same length');
end

if xLen ~= fxLen
      error('X range and probability vectors must be of the same length');
end

% trivial 
fxy = fx.*fy;             % multiply
fxy = fxy / trapz(x,fxy); % normalize
