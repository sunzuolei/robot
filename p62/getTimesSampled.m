function nSampled = getTimesSampled(newI)
n = length(newI);
nSampled = zeros(n, 1);
for i = 1 : n
    ind = find(newI == i);
    if isempty(ind)
        nSampled(i) = 0;
    else
        nSampled(i) = length(ind);
    end
end