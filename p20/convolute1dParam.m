function [muAfterMove, sdAterMove] = convolute1dParam(...
                            muPrior, sdPrior, muMotion, sdMotion)
    muAfterMove = muPrior + muMotion;
    sdAterMove  = sqrt(sdPrior^2 + sdMotion^2);
end