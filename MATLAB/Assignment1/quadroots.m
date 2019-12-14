%Function for MATLAB Problem 3, Assignment 1
%Author: Gerardo E. Rodriguez, ger150030
%Function that calculates the roots of f(x) = ax^2 + bx + c
%Input: a is coefficient of x^2
%       b is coefficient of x
%       c is constant
%Output: x1 and x2 are roots of polynomial

%Defining function quadroots
function [x1,x2] = quadroots(a,b,c)

%Calculate common term once to avoid redundancy 
commonTerm = sqrt((b^2) - 4*a*c);

%Execute different calculations for the roots depending on b
if b>0
    x1 = -(2*c)/(b + commonTerm);
    x2 = -((b + commonTerm)/(2*a));
elseif b<0
    x1 = (-b + commonTerm)/(2*a);
    x2 = -((2*c)/(b - commonTerm));
else %b==0
    x1 = commonTerm/(2*a);
    x2 = -x1;
end


