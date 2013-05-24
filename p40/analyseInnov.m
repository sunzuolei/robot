function [normY, moveAverY, chiUp, chiLow] = analyseInnov(Y, S, timeSeq)
% Modified from Hugh's 'inn_analyse' function.
% The dimention verification is required...TO DO...

    [r, c]      = size(Y);
    S2D         = zeros(r, c);
    for i = 1 : r
        S2D(i,:) = reshape(S(i,i,:), 1, []);
    end
    normY       = Y .* Y ./ S2D;

    cumsumY     = cumsum(normY, 2);
    numSeq      = repmat(1 : c, r, 1);

    moveAverY   = cumsumY ./ numSeq;

    x           = [1  10     50     100    500   ];
    low         = [0  0.325  0.650  0.740  0.8789];
    up          = [5  2.05   1.428  1.3    1.1267];

    timeSeqRep  = repmat(timeSeq, r, 1);

    chiUp       = interp1(x, up,  timeSeqRep);
    chiLow      = interp1(x, low, timeSeqRep);
end
