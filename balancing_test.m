
% a + b -c = 2
numberset = [5 4 19;
             8 7 31];
         
uncertain = [2 1]; 

candidates = 7:12; 

result = balancing(numberset, uncertain, candidates, 5)

sol = nan(size(result,1), 2); 

for i = 1:length(result)
    sol(i, 1) = result{i}.candidate;
    sol(i, 2) = result{i}.optional_number; 
    
end

hist(sol(:, 1)); 