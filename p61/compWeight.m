function w = compWeight(zPred, zTrue, Sigma, hasAngle, idxAngle)

    if size(zPred, 2) ~= 1 || size(zTrue, 2) ~= 1
       error('zPred and zTrue should be column vector matrix!') 
    end

    if size(zPred, 1) ~= size(zTrue, 1) 
       error('zPred and zTrue should be of same size!'); 
    end

    if size(zPred, 1) ~= size(Sigma, 1) || size(zTrue, 2) ~= size(Sigma, 2)
        error('The wrong size of Sigma!');
    end
    
    %%
    if nargin < 4
        hasAngle = false;
    end
    
    if nargin == 4
        idxAngle = length(zTrue);
    end
    
    %%
    Y = abs(zPred - zTrue);
    if hasAngle
       Y(idxAngle) = piTopi( Y(idxAngle) ); 
    end
    w = det(2 * pi * Sigma)^(-0.5) * exp(-0.5 * Y'/Sigma * Y) + 1e-99;
end