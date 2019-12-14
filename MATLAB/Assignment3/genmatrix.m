%Function for MATLAB Problem 3, Assignment 3
%Author: Gerardo E. Rodriguez, ger150030
%Input: 3x1 vector
%Output: 3x3 matrix

function [DF] = genmatrix(x)

DF=[1/x(1) 1 1/(10-x(3));
    1/x(1) 2 1/(6-x(3));
    1/x(1) 3 1/(5-x(3))];

% DF=[exp(x(2)*1) x(1)*exp(x(2)*1) 1;
%     exp(x(2)*2) 2*x(1)*exp(x(2)*2) 2;
%     exp(x(2)*3) 3*x(1)*exp(x(2)*3) 3];

