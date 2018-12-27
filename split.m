% Function split finds %i% numbers that sum of to %N% 

function splittings = split(N, min_val)

    % Cannot be split any furter. 
    if N == min_val 
        splittings = {}; 
        return
    else
        splittings = {}; 
        
        for summand = min_val:(N-min_val)
            splittings = [splittings; {[summand, N-summand]}]; 
            split_sum = split(N-summand, min_val); 
            
            for j = 1:size(split_sum, 1)
               split_sum{j} = [summand, split_sum{j}];  
            end
            splittings = [splittings; split_sum]; 
        end
    end

end