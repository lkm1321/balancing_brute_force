% Find all possible expressions with binary operators ops and varnames.

function rpn_array = generate_rpn(varnames, ops)
    
    rpn_base = generate_rpn_base(length(varnames)); 

    var_perms = perms(varnames);
    op_perms = perms(ops); 
    
    if (size(op_perms, 2) > ( size(var_perms, 2) - 1) )
        op_perms = op_perms(:, 1:size(var_perms,2)-1);
    end
    
    no_var_perms = size(var_perms, 1);
    no_op_perms = size(op_perms, 1); 
    no_base = size(rpn_base, 1); 
    
    no_permutations = no_var_perms * no_op_perms * no_base;  
    rpn_array = cell( no_permutations, 1); 
    
    for i = 1:no_var_perms
        for j = 1:no_op_perms
            for k = 1:no_base
                current_base = rpn_base{k}; 
                current_var_perm = var_perms(i, :);
                current_op_perm = op_perms(j, :); 

                % Find idxs before modifying. 
                var_idx = strfind(current_base, 'v'); 
                op_idx = strfind(current_base, 'o'); 
                
                % Assign. 
                current_base(var_idx) = current_var_perm; 
                current_base(op_idx) = current_op_perm; 
                
                rpn_array{ sub2ind([no_var_perms, no_op_perms, no_base], ...
                           i, j, k) } = current_base; 
            end
        end
    end
    
end
