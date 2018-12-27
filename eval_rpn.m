function val = eval_rpn(expr)

    stack = []; 

    for i = 1:length(expr)
        
        current_element = expr{i}; 
        
        % push numeric digits onto stack. 
        if ( isnumeric(current_element) )
           stack = [ stack, current_element ]; 
        else
            % pop operands from stack (only considering binary ops). 
            operands = stack( (end-1):end ); 
            stack = stack(1:(end-2));
            
            % evaluate
            switch (current_element)
                case '+'
                    result = operands(1) + operands(2); 
                case 'x'
                    result = operands(1) * operands(2); 
                % overload. 
                case '*'
                    result = operands(1) * operands(2); 
                case '-' 
                    result = operands(1) - operands(2); 
                case '/' 
                    result = operands(1) / operands(2); 
                otherwise
                    error('Unknown operator %c', expr(i));                     
            end
            % push back onto stack 
            stack = [stack, result]; 
        end
    end
    
    % This should work. 
    val = stack(1); 
end
