function [muPred, SigmaPred] = predictLKF(mu, Sigma, F, Q, varargin)
 
    %% Verify the dimentions
    muLen  = size(mu, 1);
    argLen = nargin - 4;

    if mod(argLen, 2) ~= 0 || argLen > 6
        error('Wrong number of arguments.');
    end
    if nargin < 4
        error('Not enough input arguments.');
    end
    if size(mu, 2) ~= 1
        error('The state shoud be column vector.');
    end
    if size(Sigma, 1) ~= size(Sigma, 2)
        error('The covariance matrix should be symmetrical.');
    end
    if size(Sigma, 1) ~= muLen
        error('Wrong size of state or covariance matrix.');
    end
    %% Extract the arguments
    hasU    = false;
    hasUMat = false;
    hasE    = false;
    for i = 1 : 2 : argLen
        switch lower(strtrim(cell2mat(varargin(i))))
            case 'control'
                u = cell2mat(varargin(i + 1));
                hasU = true;
                if size(u, 2) ~= 1
                    error('The control shoud be column vector.');
                end  
            case 'controlmat'
                B = cell2mat(varargin(i + 1));
                hasUMat = true;            
            case 'processnoisemat'
                E = cell2mat(varargin(i + 1));
                if size(Q, 1) ~= size(E, 2) || size(Q, 2) ~= size(E, 2)
                    error('Wrong size of noise matrix or noise covariance matrix.');
                end
                hasE = true;
            otherwise 
                error(['Invalid argument: ', cell2mat(varargin(i))]);
        end
    end
    %% Refine the arguments
    if hasUMat && hasU == false
        error('''control'' is needed.')
    end

    if hasUMat && hasU
        if size(B, 2) ~= size(u, 1) || size(B, 1) ~= muLen
            error('Wrong size of control matrix.');
        end 
    end

    if hasU && hasUMat == false
        B = eye(size(u, 1));
    end

    if hasE == false 
        if sum(size(Q, 1) - size(Sigma, 1)) ~= 0
            error('Wrong size of Q.');
        end
    end

    %% Linear KF prediction
    if hasU
        muPred   = F * mu + B * u;
    else
        muPred   = F * mu;
    end
    
    if hasE
        SigmaPred   = F * Sigma * F' + E * Q * E';
    else
        SigmaPred   = F * Sigma * F' + Q;
    end
end