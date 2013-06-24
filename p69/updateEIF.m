function [muPost, OmegaPost, xiPost] = updateEIF(mu,  Omega, xi,...
    sensorModel, sensorPos, z, H, R, hasAngle, idxAngle)
%%
    if nargin < 9
        hasAngle = false;
    end
    
    if nargin == 8
        idxAngle = length(z);
    end
%%
    r = size(mu, 1);
    if r ~= size(Omega, 1) || r ~= size(Omega, 2)
       error('Wrong size of mu or Omega.'); 
    end
    
    if size(H, 1) ~= size(z, 1)
        error('Wrong size of z or H.');
    end
    
    if size(H, 2) ~= size(mu, 1)
        error('Wrong size of H or mu');
    end
%%
    Y         = z - sensorModel(mu, sensorPos) + H * mu;
    if hasAngle
       Y(idxAngle) = piTopi(Y(idxAngle)); 
    end
    xiPost    = H' / R * Y + xi;
    OmegaPost = H' / R * H + Omega;
    muPost    = OmegaPost \ xiPost;
%     muPost    = pinv(OmegaPost) * xiPost;
end