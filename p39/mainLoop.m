%% Transition matrices
F = [1, dt,  0,  0;
     0,  1,  0,  0;
     0,  0,  1,  dt;
     0,  0,  0,  1];
E = [dt^2/2,    0;
       dt,      0;
       0,       dt^2/2;
       0,       dt];
H = [1, 0, 0, 0;
     0, 0, 1, 0];
%% Generate truth
[xTrue, zTrue]   = simTruthCV(xInit, F, E, simQ, H, simR, step);
%% Assign memory
muPred           = zeros(xLen, step);
muPred(:,1)      = xInit;
SigmaPred        = zeros(xLen, xLen, step);
SigmaPred(:,:,1) = SigmaInit;
muPost           = zeros(xLen, step);
SigmaPost        = zeros(xLen, xLen, step);
zRows            = size(zTrue, 1);
innov            = zeros(zRows, step);
SigmaInnov       = zeros(zRows, zRows, step);

%% Filtering loop
mu               = xInit;
Sigma            = SigmaInit;
tic;
for i = 1 : step
    if i ~= 1
        [mu, Sigma] = predictLKF(mu, Sigma, F, Q, 'processNoiseMat', E);
        muPred(:,i)      = mu;
        SigmaPred(:,:,i) = Sigma;
    end
    [mu, Sigma, innov(:,i), SigmaInnov(:,:,i)] =...
        updateLKF(mu, Sigma, zTrue(:,i), H, R);
    muPost(:,i)      = mu;
    SigmaPost(:,:,i) = Sigma;
end
toc;