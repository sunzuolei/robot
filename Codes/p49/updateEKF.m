function [muPost, SigmaPost, Y, S, K] = updateEKF(mu, Sigma,...
    sensorModel, sensorPos, z, H, R, hasAngle, idxAngle)
%%
    if nargin < 8
        hasAngle = false;
    end
    
    if nargin == 8
        idxAngle = length(z);
    end
%%
    r = size(mu, 1);
    if r ~= size(Sigma, 1) || r ~= size(Sigma, 2)
       error('Wrong size of mu or Sigma.'); 
    end
    
    if size(H, 1) ~= size(z, 1)
        error('Wrong size of z or H.');
    end
    
    if size(H, 2) ~= size(mu, 1)
        error('Wrong size of H or mu');
    end
%%
    Y         = z - sensorModel(mu, sensorPos);
    if hasAngle
       Y(idxAngle) = piTopi(Y(idxAngle)); 
    end
    S         = H * Sigma * H' + R;
    K         = Sigma * H' / S;
    muPost    = mu + K * Y;
    SigmaPost = Sigma - K * S * K';
end