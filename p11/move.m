function q = move(p, u, pMoveCorrect)
    nRow = size(p, 1);
    nCol = size(p, 2);
    q = zeros(nRow, nCol);
    for r = 1 : nRow
        for c = 1 : nCol
            q(r, c) = pMoveCorrect * ...
                p(mod(r-1-u(1), nRow) + 1, mod(c-1-u(2), nCol) + 1)...
                + (1 - pMoveCorrect) * p(r, c); 
        end
    end
end