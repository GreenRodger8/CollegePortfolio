%Function for MATLAB Problem 2, Assignment 4
%Author: Gerardo E. Rodriguez, ger150030
%Input: X in integer where cosine is to be approximated
%       a is array of first coefficients of piecewise functions
%       b is array of second coefficients of piecewise functions
%       c is array of third coefficients of piecewise functions
%Output: y which is approximated by piecewise function

function y = cosine(X,a,b,c)

%X coordinates
xPoints = linspace(0, 2*pi, 100);

%Normalize X for easy use
X = abs(X);
X = mod(X,2*pi);

%Decide which piecewise function to use
n = size(a);
k = floor(X*n(1)/(2*pi))+1;

%Use piecewise function to estimate y for X
xK = xPoints(k);
y = a(k) + b(k)*(X - xK) + c(k)*((X - xK)^2);