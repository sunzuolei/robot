function [q, qMean, chiUp, chiLow] = chiSquareTest(Y, S, type)
%  Chi-square test on the sample Y with covariance S.
%  It is designed for innovation but can also work with states.
%  Modified from Hugh's 'inn_analyse' function. Please refer to p74-76 of 
% 'Introduction to Estimation and the Kalman Filter' for details.
%  Samuel (sunzuolei@gmail.com).
%  May 24 2013.
% 
%   Input arguments:
%       Y       - Innovation, should be column matrix;
%       S       - The covariance matrix of Y;
%       type    - 'movingAverage' or 'bunch';
%   Output arguments:
%       q       - Normalized innovations squared;
%       qMean   - The moving average mean or bunch average mean of q;
%       chiUp   - The up bound of the specified chi-square
%       chiLow  - The low bound...
    
    if nargin < 3
        type = 'bunch';
    end
        
    [r, c]      = size(Y);
    if c ~= size(S, 3) || r ~= size(S, 2) || r ~= size(S, 1)
       error('Wrong size of Y or S.'); 
    end
    
    lowGate = 0.05;
    upGate  = 1 - lowGate;
    
    type     = lower(strtrim(type));
    q        = zeros(1, c);
    for i = 1 : c
        q(i) = Y(:,i)' / S(:,:,i) * Y(:,i);
    end
    
    if strcmp(type, 'batch')
        qMean   = mean(q) * ones(1, c);    
        chiUp   = chi2inv(upGate,  (c - 0) * r) / c * ones(1, c);
        chiLow  = chi2inv(lowGate, (c - 0) * r) / c * ones(1, c);
    elseif strcmp(type, 'movingaverage')
        csumQ   = cumsum(q, 2);
        step    = 1 : c;
        qMean   = csumQ ./ step;
        chiUp   = chi2inv(upGate,  (step - 0) * r) ./ step;
        chiLow  = chi2inv(lowGate, (step - 0) * r) ./ step;
    else
        error(['Invalid input argument: ', type]);
    end    
end
