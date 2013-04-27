function [pMat, xMat, yMat] = gaussian2d(mu, Sigma, x, y)
    xLen = length(x);
    yLen = length(y);
    %%
    if (xLen ~= yLen)
        error('The size of x and y should be the same!');
    end
    
    if (length(mu) ~= 2)
        error('The size of mu should be (2 * 1)!');
    end
    
    if (size(Sigma, 1) ~= size(Sigma, 2))
        error('The covariance matrix should be symmetric!');
    end
    
    if (size(Sigma, 1) ~= 2)
        error('The size of covariance matrix is invalid!');
    end
    
    if det(Sigma) < eps
        error('Covariance must be positive semidefinite!');
    end
    pMat = zeros(xLen, yLen);
    
    %%
    [xMat, yMat] = ndgrid(x, y);
%   xMat = [x1, x1;
%           x2, x2],
%   yMat = [y1, y2;
%           y1, y2]
    for i = 1 : xLen
        for j = 1 : yLen
            xMinusMu = [xMat(i, j) - mu(1); yMat(i, j) - mu(2)];
            p = exp(-0.5 * xMinusMu'* inv(Sigma) * xMinusMu);
            p = p * det(2 * pi * Sigma)^(-0.5);
            pMat(i, j) = p;
        end
    end

end