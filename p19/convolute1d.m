function fxy=convolute1d(fx,fy,x)
%
%	function to convolve two one-dimensional probability distributions
%	FX, FY vectors of probability density
%  X range of values over which density is defined
%
% Algorithm: FFT of data (general version would use fftn and ifftn)
% seeded by Hugh
% revised by Samuel

% The following is Hugh's version. The conv is implemented manully
% fxLen = length(fx); 
% fy    = fliplr(fy); % get fy(tau-t)
% X     = fft(fx);
% Y     = fft(fy);
% Fxy   = X.* conj(Y)/fxLen;  % product of FTs 
% % then inverse is convolution  
% fxy   = ifftshift(real(ifft(Fxy))); % only use real part and center

fxy = conv(fx, fy, 'same');
fxy = fxy / trapz(x,fxy); % normalize
