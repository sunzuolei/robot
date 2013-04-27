function Sigma = makeSigma(sigmax, sigmay, rho)
    sigmaxy = sigmax * sigmay * rho;
    Sigma   = [sigmax^2,   sigmaxy;
               sigmaxy,    sigmay^2];
end