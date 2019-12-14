%Function for MATLAB Problem 1, Assignment 2
%Author: Gerardo E. Rodriguez, ger150030
%Adapted from quadroots
%Function that approximates the roots of y^2 - 3y + 1 + 5/4(x-2)^2 = 0
%with respect to y given x
%Function is shifted down 2 units in order to achieve sign change

%Defining function ffalpos
function [y1] = ffalpos(x)

%Define variables
a = 1;
b = -3;
c = 1 + 5*((x - 2)^2)/4 ;

%Calculate common term once to avoid redundancy 
commonTerm = sqrt((b^2) - 4*a*c);

%Execute different calculations for the roots depending on b
if b>0
    y1 = -(2*c)/(b + commonTerm)-2;
    %y2 = -((b + commonTerm)/(2*a));
elseif b<0
    y1 = (-b + commonTerm)/(2*a)-2;
    %y2 = -((2*c)/(b - commonTerm));
else %b==0
    y1 = commonTerm/(2*a)-2;
    %y2 = -x1;
end