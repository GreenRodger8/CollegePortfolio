%Program for MATLAB Problem 1, Assignment 1
%Author: Gerardo E. Rodriguez, ger150030
%Computes P(-2) in the least amount of flops
%P(x) is the polynomial in Problem 1 of the Theoretical Problems
format long e

%Original x in problem
x = -2;

%New variable that will optomize nesting
y = x^5;

%Degree of polynomial using new variable
degree = 5;

%Array of coefficients, starting with constant term first
coefficients = [-1 4 -1 7 0 2];

%Using nest function, result not suppressed 
result = nest(degree, coefficients, y)
