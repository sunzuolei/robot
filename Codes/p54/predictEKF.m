function [muPred, SigmaPred] = predictEKF(mu, Sigma, u, motionModel, F, Q)
    muPred    = motionModel(mu, u);
    SigmaPred = F * Sigma * F' + Q;
end