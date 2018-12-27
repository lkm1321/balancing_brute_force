## Finding solutions to 'balancing problems'. 

This repo solves questions of the following form: 

If [5, 4, 19], [8 7 31] share a pattern, fill in [2, 1, ?]: 

a. 7, b. 8, c. 9, d. 10

The answer is then (of course!) pattern: a + c - 4 = 5b, answer: 7. 

## How does it work? 

It works by generating a bunch of expressions and brute-forcing it. We assume that: 

* None of the numbers are duplicated or unused in the pattern.
* There may be one 'optional' number in the pattern (e.g. 5 in the example). 
* We only consider binary operators.  

## Reverse polish notation

We use reverse Polish notation (RPN) to parameterise each expression. An example of RPN and a normal expression is provided below: 

Normal expression: (3 + 5) * 2 - 4 * 2
RPN: 235+*42*-

The evaluation rule is: 
- Go left to right. 
- When you see an operand, push it to a stack
- When you see an operator, pop two operands and evaluate. Push result back to stack. 

So, in the example, we first see +, compute 3+5, then see *, so we compute (3 + 5) * 2, and so forth.
Any expression can be converted to RPN, and vice versa. 

## Properties of RPN

An RPN expression having N operands must satisfy the following: 
- There are N - 1 binary operators. 
- The RPN expression is 2*N-1 long. 

Suppose the expression consists of substrings vi, oi, where vi is made up of operands and oi of operators. Then, we must have:
- vi and oi must alternate. RPN is of the form v1o1v2o2 ...
- length(v1) = length(o1) + 1, and length(vi) = length(oi) otherwise. 

## Generating RPN

Given these rules, we can construct all possible RPNs with N operands via the following. 
- Find all possible n_i such that such that sum of n_i is N. 
- Create a base string with vi, oi, where length of vi is n_i found before. Length of oi is determined based on the rule from before. 
- Generate all possible permutations of the operand symbols and operators. For each base type constructed from before, fill in the string with these permutations (substrings marked with v are filled with operand permutation sequentially, and the same for operators). 

## Brute-forcing. 

With the RPNs generated, it is now simple to brute-force the problem from before. 
Outline: 
- Generate RPNs. 
- For each generated RPN type, try given examples of the pattern. 
- If an RPN produces the same result for each pattern, try each candidate solution. 
- If a candidate solution also produces the same result, report as answer. 



