%%
function q = sense(p, z, world, pSenseCorrect)
    nRow = size(p, 1);
    nCol = size(p, 2);
    q = zeros(nRow, nCol);
    for r = 1 : nRow
        for c = 1 : nCol
            hit = strcmp(z, world(r, c));
            q(r, c) = p(r, c) *...
                (hit * pSenseCorrect + (1-hit) * (1 - pSenseCorrect)); 
        end            
    end
    q = q / sum(sum(q)); 
end