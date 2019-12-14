%Program for MATLAB Problem 3, Assignment 1
%Author: Gerardo E. Rodriguez, ger150030
%Computes the roots of two quadratic functions using function quadroots
%First function is f1(x)=x^2 - 100000x + 1
%Second function is f2(x)=x^2 + 100000x + 1
format long e

%Instantiate coefficients for both functions
a = 1;
b1 = -100000;
b2 = 100000;
c = 1;

%Calculate common term once to avoid redundancy 
commonTerm = sqrt((b1^2) - 4*a*c);

%Calculate and display roots of first function using quadroots
[quadSolution1a, quadSolution1b] = quadroots(a, b1, c)

%Calculate and display roots of first function using quadratic formula
naiveSolution1a = (-b1 + commonTerm)/(2*a)
naiveSolution1b = (-b1 - commonTerm)/(2*a)

%Calculate and display backward errors for both pairs of root solutions
%For function 1
quadError1a = c + quadSolution1a*(b1 + quadSolution1a*a)
quadError1b = c + quadSolution1b*(b1 + quadSolution1b*a)

naiveError1a = c + naiveSolution1a*(b1 + naiveSolution1a*a)
naiveError1b = c + naiveSolution1b*(b1 + naiveSolution1b*a)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Calculate and display roots of second function using quadroots
[quadSolution2a, quadSolution2b] = quadroots(a, b2, c)

%Calculate and display roots of second function using quadratic formula
naiveSolution2a = (-b2 + commonTerm)/(2*a)
naiveSolution2b = (-b2 - commonTerm)/(2*a)

%Calculate and display backward errors for both pairs of root solutions
%For function 2
quadError2a = c + quadSolution2a*(b2 + quadSolution2a*a)
quadError2b = c + quadSolution2b*(b2 + quadSolution2b*a)

naiveError2a = c + naiveSolution2a*(b2 + naiveSolution2a*a)
naiveError2b = c + naiveSolution2b*(b2 + naiveSolution2b*a)



