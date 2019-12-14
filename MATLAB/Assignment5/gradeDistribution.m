%Function for MATLAB Problem 2, Assignment 5
%Author: Gerardo E. Rodriguez, ger150030
%Input: x is integer which to evaluate function at
%Output: y which is evaluation of the function at x

function y = gradeDistribution(x)

y = (20*exp(-1*(x-60)*(x-60)/50))/(sqrt(2*pi));