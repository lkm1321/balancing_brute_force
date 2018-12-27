%% Function balancing finds expressions that evaluate to zero for a given numberset 
% Numberset: C x N where C is the number of given observations, N is the
% number of integers
% uncertain_set: 1 x N-1. We pick a number from candidates that satisfy the
% same relation as numberset. 
% candidates: 1 x Nc candidate numbers to use
% optional_numbers: 1 x No optional numbers to be used in expressions
% results 

function [results] = balancing(numberset, uncertain_set, candidates, optional_numbers)

    if (isempty(optional_numbers))
        num_vars = size(numberset, 2);
        optional_numbers = nan; 
    else
        num_vars = size(numberset, 2)+1; 
    end

    results = {}; 
    
    var_names = 'a':char('a'+num_vars-1); 
    % replace variables with numbers later. 
    trial_rpns = generate_rpn(var_names, '+-*'); 

    for i = 1:size(trial_rpns, 1)
        for iOpt = 1:length(optional_numbers)
            current_rpn = trial_rpns{i}; 

            % evaluate each ones. 
            trial_results = zeros(size(numberset, 1), 1);         
            for j = 1:length(trial_results)
                % replace alphabets with numbers. 
                rpn_to_eval = populate_rpn( current_rpn, var_names, numberset(j, :), optional_numbers(iOpt) ); 
                trial_results(j) = eval_rpn(rpn_to_eval); 
            end % foreach numberset/trial_result.  

            % all the trial results are the same. 
            if (all(trial_results == trial_results(1)))
                fprintf('symmetry found with rpn %s,\n value %d, optional_no %d\n',... 
                        current_rpn, trial_results(1), optional_numbers(iOpt)); 
                fprintf('trying candidates\n'); 
                for iCan = 1:length(candidates)
                    rpn_to_eval = populate_rpn(current_rpn, var_names, [uncertain_set(:)', candidates(iCan)], optional_numbers(iOpt)); 
                    candidate_result = eval_rpn(rpn_to_eval); 
                    if (candidate_result == trial_results(1))
                        
                        fprintf('candidate %d is verified\n', candidates(iCan) ); 
                        
                        result_struct = struct('candidate', candidates(iCan),...
                                               'optional_number', optional_numbers(iOpt),...
                                               'rpn', current_rpn, ...
                                               'numberset', numberset, ...
                                               'uncertain_set', uncertain_set, ...
                                               'value', trial_results(1)); 
                        results = [results; {result_struct}]; 
                    end
                end % foreach candidate. 

            end % if symmetry found.        
        end
    end % foreach trial_rpn    
end

function rpn_cell = populate_rpn(base, var_names, numberset, optional_number)

    num_vars = size(numberset, 2); 
    rpn_cell = cell(length(base), 1); 
    
    
    
    for i = 1:length(base)
        var_idx = strfind(var_names, base(i));
        if (~isempty(var_idx))
            if (var_idx <= length(numberset))
                rpn_cell{i} = numberset(var_idx);
            % HACK: var_idx is greater than length of numberset if optional_number is set.     
            elseif (~isnan(optional_number))
                rpn_cell{i} = optional_number; 
            else
                error('Something is weird');     
            end
        else
            rpn_cell{i} = base(i); 
        end
    end
%     for ivars = 1:num_vars
%         
% %         rpn_str = strrep(rpn_str, var_names(ivars), num2str(numberset(ivars))); 
%     end

end