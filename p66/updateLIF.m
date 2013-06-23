function [xiPost, OmegaPost] = updateLIF(xi, Omega, z, H, R)
%%
    r = size(xi, 1);
    if r ~= size(Omega, 1) || r ~= size(Omega, 2)
       error('Wrong size of xi or Omega.'); 
    end
    
    if size(H, 1) ~= size(z, 1)
        error('Wrong size of z or H.');
    end
    
    if size(H, 2) ~= size(xi, 1)
        error('Wrong size of H or xi');
    end
%%
    xiPost    = H'/ R * z + xi;
    OmegaPost = H'/ R * H + Omega;
end