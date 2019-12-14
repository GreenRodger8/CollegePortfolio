%Script for MATLAB Problem 1, Assignment 4
%Author: Gerardo E. Rodriguez, ger150030
%Estimates the function exp(-1*abs(xCoordinates(x)))
%by interpolating n number of evenly spaced nodes

format long e

%Initialize n (number of nodes) and define xCoordinates and yCoordinates
n = 10;
xCoordinates = zeros(n,1);
yCoordinates = zeros(n,1);

%Initialize first and last x,y coordinates
xCoordinates(1) = -3;
yCoordinates(1) = exp(-1*abs(xCoordinates(1)));
xCoordinates(n) = 3;
yCoordinates(n) = exp(-1*abs(xCoordinates(n)));

%Add rest of evenly spaced x coordinates and their respective y coordinates
interval = (xCoordinates(n) - xCoordinates(1))/(n-1);
for i=2:n-1
    xCoordinates(i) = xCoordinates(1) + (i-1)*interval;
    yCoordinates(i) = exp(-1*abs(xCoordinates(i)));
end

%Compute coefficients for Newton's polynomial
newtonCoefficients = newtdd(xCoordinates,yCoordinates,n);

%Compute values from Newton's polynomial for evenly spaced x 
spacing = 0.01;
numberOfNewY = (xCoordinates(n) - xCoordinates(1))/spacing + 1;
interpolatedX = zeros(numberOfNewY,1);
interpolatedY = zeros(numberOfNewY,1);
for i=1:numberOfNewY
    currentX = xCoordinates(1) + (i-1)*spacing;
    interpolatedX(i) = currentX;
    interpolatedY(i) = nest(n-1,newtonCoefficients,currentX,xCoordinates(1:n-1));
end

%Compute absolute error for Newton's polynomial
absoluteError = zeros(numberOfNewY,1);
for i=1:numberOfNewY
    absoluteError(i) = abs(exp(-1*abs(interpolatedX(i)))-interpolatedY(i));
end

%Plot
figure
fplot(@(x) exp(-1*abs(x)),[xCoordinates(1),xCoordinates(n)])
figure
plot(interpolatedX,interpolatedY)
figure
plot(interpolatedX,absoluteError)

%Now do the same but for different n
%Initialize n (number of nodes) and define xCoordinates and yCoordinates
n = 30;
xCoordinates = zeros(n,1);
yCoordinates = zeros(n,1);

%Initialize first and last x,y coordinates
xCoordinates(1) = -3;
yCoordinates(1) = exp(-1*abs(xCoordinates(1)));
xCoordinates(n) = 3;
yCoordinates(n) = exp(-1*abs(xCoordinates(n)));

%Add rest of evenly spaced x coordinates and their respective y coordinates
interval = (xCoordinates(n) - xCoordinates(1))/(n-1);
for i=2:n-1
    xCoordinates(i) = xCoordinates(1) + (i-1)*interval;
    yCoordinates(i) = exp(-1*abs(xCoordinates(i)));
end

%Compute coefficients for Newton's polynomial
newtonCoefficients = newtdd(xCoordinates,yCoordinates,n);

%Compute values from Newton's polynomial for evenly spaced x 
spacing = 0.01;
numberOfNewY = (xCoordinates(n) - xCoordinates(1))/spacing + 1;
interpolatedX = zeros(numberOfNewY,1);
interpolatedY = zeros(numberOfNewY,1);
for i=1:numberOfNewY
    currentX = xCoordinates(1) + (i-1)*spacing;
    interpolatedX(i) = currentX;
    interpolatedY(i) = nest(n-1,newtonCoefficients,currentX,xCoordinates(1:n-1));
end

%Compute absolute error for Newton's polynomial
absoluteError = zeros(numberOfNewY,1);
for i=1:numberOfNewY
    absoluteError(i) = abs(exp(-1*abs(interpolatedX(i)))-interpolatedY(i));
end

%Estimate of maximum absolute error for interpolating polynomial
%First find nth derivative of function
syms t
estimatedFunction = exp(-1*t);
nDerivative = diff(estimatedFunction, n);

%Find max of derivative
startRange = (numberOfNewY-1)/2;
positiveX = interpolatedX(startRange:numberOfNewY);
nDerivativeArray = vpa(subs(nDerivative,t,positiveX));
maxDerivative = max(nDerivativeArray);

%Finally calculate max error
maxError = ((xCoordinates(n)-xCoordinates(1))^n)*maxDerivative/(factorial(n))

%Plot for different n
figure
plot(interpolatedX,interpolatedY)
figure
plot(interpolatedX,absoluteError)
