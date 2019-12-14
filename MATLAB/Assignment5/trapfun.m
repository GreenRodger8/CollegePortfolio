%Function for MATLAB Problem 2, Assignment 5
%Author: Gerardo E. Rodriguez, ger150030
%Input: m is integer number of panels for
%       a is integer of lower bound for x
%       b is integer of higher bound for x
%       func is function which to compute area for
%Output: totalArea which approximates the integral of func from a to b
%        using Composite Trapezoids

function totalArea = trapfun(m,a,b,func)

%Determine step size for m panels from a to b
h = (b - a)/m;

%Generate m+1 number of y values from function func
y = zeros(m+1,1);
for i=1:m+1
    currentX = a + h*(i-1);
    [yTemp] = feval(func,currentX);
    y(i) = yTemp;
end

%Calculate total area
totalArea = (y(1)+y(m+1))*h/2;
totalArea = totalArea + h*sum(y(2:m));