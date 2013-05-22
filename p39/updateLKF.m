function [muPost, SigmaPost, Y, S, K] = updateLKF(mu, Sigma, z, H, R)

    Y         = z - H * mu;
    S         = H * Sigma * H' + R;
    K         = Sigma * H' / S;
    muPost    = mu + K * Y;
    SigmaPost = Sigma - K * S * K';
end