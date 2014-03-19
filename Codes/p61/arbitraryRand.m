function r = arbitraryRand(nRow, nCol, minR, maxR)
    if minR > maxR
        error('minR should be smaller than maxR!');
    end    
    r = rand(nRow, nCol) * (maxR - minR) + minR;
end