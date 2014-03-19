function [xAll, zAll] = simTruth(xInit, motionModel, u, Q,...
                        sensorModel, sensorPos, R, step)
    %% Generate guassian distributed noise
    w = chol(Q) * randn(size(Q, 1), step); % Process noise
    v = chol(R) * randn(size(R, 1), step); % Snesor noise
    %%
    xAll      = zeros(length(xInit), step);
    xAll(:,1) = xInit;
    zAll      = zeros(size(R, 1), step);
    zAll(:,1) = sensorModel(xInit, sensorPos) + v(:, 1);   
    %%
    x = xInit;
    for i = 2 : step
        x = motionModel(x, u(:, i-1)) + w(:, i);
        z = sensorModel(x, sensorPos) + v(:, i);
        xAll(:, i) = x;
        zAll(:, i) = z;
    end   
end