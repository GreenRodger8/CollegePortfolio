%Function for MATLAB Problem 3, Assignment 3
%Author: Gerardo E. Rodriguez, ger150030
%Input: 3x1 vector
%Output: 3x1 vector

function [f] = genrhs(x)

f = [log(x(1))+x(2)-log(10-x(3));
    log(x(1))+2*x(2)-log(12-2*x(3));
    log(x(1))+3*x(2)-log(15-3*x(3))];

% f =[x(1)*exp(x(2))+x(3)-10;
%     x(1)*exp(x(2)*2)+x(3)*2-12;
%     x(1)*exp(x(2)*3)+x(3)*3-15];
    
f = -f;