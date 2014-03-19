function u = simControlSqaure(st, stEdge, v)

% generate the control batch forming a square
% 
% input:
%     st     - number of step
%     stEdge - number of step for each edge
%     v      - the constant velocity for generate control
% output:
%     u      - control batch for x-velocity and y-velocity. [2 * st]
%     
% Author: Samuel (sunzuolei@gmail.com)
%         May 30 2013

u            = zeros(2, st);
iSquare      = 0;
iGlobal      = 1;
while iGlobal <= st
    iSquare = iSquare + 1;
    if iSquare > 0 && iSquare <= stEdge
        u(:, iGlobal) = [0, v];
        iGlobal       = iGlobal + 1;
    elseif iSquare > stEdge  && iSquare <= 2 * stEdge
        u(:, iGlobal) = [v, 0];
        iGlobal       = iGlobal + 1;
    elseif iSquare > 2*stEdge && iSquare <= 3 * stEdge
        u(:, iGlobal) = [0, -v];
        iGlobal       = iGlobal + 1;
    elseif iSquare > 3 * stEdge && iSquare <= 4 * stEdge
        u(:, iGlobal) = [-v, 0];
        iGlobal       = iGlobal + 1;
    elseif iSquare > 4 * stEdge
        iSquare = 0; 
    end
end
