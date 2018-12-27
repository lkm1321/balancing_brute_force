% generate_rpns generates reverse polish notation expressions of N
% variables. 
% N: number of variables
% ops: operators to use
% rpn_array: N_rpn x (2N - 1) string array containing rpn expressions

function rpn_array = generate_rpns(N)

    splittings = split(N, 1); 

%     if (~exist(varnames, 'var'))
%         varnames = 'a':char('a'+N);
%     end
    
    % base containing v for variable and o for operator. 
    rpn_base = cell(size(splittings, 1), 1); 
%     rpn_base = char(size(splittings, 1), 2*N-1); 
    
    % build a skeleton with v where variables go and o where operators go. 
    for i = 1:size(splittings, 1)
        current_split = splittings{i}; 
        current_rpn = [ repmat('v', 1, current_split(1)), repmat('o', 1, current_split(1)-1) ]; 
        for j = 2:length(current_split)
            current_rpn = [current_rpn, repmat('v', 1, current_split(j)), repmat('o', 1, current_split(j))]; 
        end
        rpn_base{i} = current_rpn; 
    end
    
    rpn_array = rpn_base; 
end