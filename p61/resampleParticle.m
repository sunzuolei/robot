function newIdx = resampleParticle(w, type)
    n = length(w);
    
    if nargin < 2
       type = 'improvedthrun'; 
    end
    
    newIdx = zeros(1, n);
    w    = w./sum(w);
    
    switch lower(strtrim(type))
        case 'thrun'   
            %%
            index = ceil(rand * n);
            beta = 0;
            maxW = max(w);
            for i = 1 : n
               beta = beta + rand * 2 * maxW;
               while beta > w(index)
                   beta = beta - w(index);
                   index = mod(index + 1, n);
                   if index == 0;
                       index = n;
                   end
               end
               newIdx(i) = index;
            end
        case 'improvedthrun'
            %%
            index = 1;
            wSum  = sum(w);
            step  = wSum / n;
            beta  = mod(wSum * wSum, step);
            for i = 1 : n
                while beta > w(index)
                   beta = beta - w(index);
                   index = mod(index + 1, n);
                   if index == 0;
                       index = n;
                   end
                end
               beta = beta + step;
               newIdx(i) = index;
            end
        case 'hugh'
            %%
            csW = cumsum(w);
            csW = csW / max(csW);
            u = sortedUniform(n);
%             u = sort(rand(1,n));
            j = 1;
            for i = 1 : n
               while csW(j) < u(i)
                  j = j + 1;
               end
               newIdx(i)    = j;
            end
%         case 'sam'
%             %% It is not reasonable.
%             csW = cumsum(w);
%             csW = csW / max(csW);            
%             for i = 1 : n
%                j = 1;
%                while csW(j) < rand
%                   j = j + 1;
%                end
%                newIdx(i)    = j;
%             end
        case 'residual'
            %%
            q_res = n .* w;
            N_babies = fix(q_res);
            % residual number of particles to sample
            res = n - sum(N_babies);
            if (res ~= 0)
                q_res=(q_res-N_babies)/res;
                cumDist= cumsum(q_res);   
                % generate N_res ordered random variables uniformly distributed in [0,1]
                u = fliplr(cumprod(rand(1,res).^(1./(res:-1:1))));
                j=1;
                for i=1:res
                    while (u(1,i)>cumDist(1,j))
                        j=j+1;
                    end
                    N_babies(1,j)=N_babies(1,j)+1;
                end;
                
                index = 1;
                inIndex = 1 : n;
                for i=1 : n
                  if (N_babies(1,i)>0)
                    for j=index:index+N_babies(1,i)-1
                      outIndex(j) = inIndex(i);
                    end;
                  end;   
                  index = index+N_babies(1,i);   
                end
                newIdx = outIndex;
            end
        otherwise
            error(['The wrong type: ', type]);
    end
end

function u = sortedUniform(n)
    % an algorithm to compute an ordered set of uniformly 
    % distributed random numbers

    u       = zeros(n,1); % a column
    c       = 1/n;
    c2      = c/2;
    u(1)    = c2;
    ur      = c2 * (rand( size(u) ) - 0.5);

    for i = 2 : n
       u(i)  = u(i-1) + c;
       u(i-1)= u(i-1) + ur(i-1);
    end
    u(n) = u(n) + ur(n);
end