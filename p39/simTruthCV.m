function [xAll, zAll] = simTruthCV(xInit, F, E, Q, H, R, step)
    %% Generate guassian distributed noise
    w = chol(Q) * randn(size(Q, 1), step); % Process noise
    v = chol(R) * randn(size(R, 1), step); % Snesor noise
    %%
    xAll      = zeros(length(xInit), step);
    xAll(:,1) = xInit;
    zAll      = zeros(size(R, 1), step);
    zAll(:,1) = H * xInit + v(:, 1);   
    %%
    x = xInit;
    for i = 2 : step
        x = F * x + E * w(:, i);
        z = H * x + v(:, i);
        xAll(:, i) = x;
        zAll(:, i) = z;
    end   
end