function [muPred, xiPred, OmegaPred] = predictEIF(...
                                        mu, Omega, u, motionModel, F, Q)    
    n         = length(mu);                                
    muPred    = motionModel(mu, u);
    OmegaPred = eye(n) / (F / Omega * F' + Q);
%     OmegaPred = eye(n) / (F * pinv( Omega ) * F' + Q);
    xiPred    = OmegaPred * muPred;
end