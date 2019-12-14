%Script for MATLAB Problem 2, Assignment 4
%Author: Gerardo E. Rodriguez, ger150030
%Estimates the cosine function
%by using a piecewise function made up of quadratic functions

%%%%%%%%%%%%%%%%%%%%%    compute spline coefficients here    %%%%%%%%%%%%%%%

format long e

% delta = x(k) - x(k-1);
% S(k) = a(k) + b(k)(x-x(k)) + c(k)(x-x(k))^2; k to n-1
% a(k) = y(k); k to n-1
% c(k) = (y(k+1)-y(k))/(delta^2) - b(k)/delta; k to n-1
% b(k) + b(k+1) = (2/delta)(y(k+1)-y(k)) k to n-2
% b(1) = v(1)

%Initialize n (number of nodes) and define xCoordinates and yCoordinates
n = 100;
xCoordinates = zeros(n,1);
yCoordinates = zeros(n,1);

%Initialize v
v = 0;

%Initialize first and last x,y coordinates
xCoordinates(1) = 0;
yCoordinates(1) = cos(xCoordinates(1));
xCoordinates(n) = 2*pi;
yCoordinates(n) = cos(xCoordinates(n));

%Add rest of evenly spaced x coordinates and their respective y coordinates
delta = (xCoordinates(n) - xCoordinates(1))/(n-1);
for i=2:n-1
    xCoordinates(i) = xCoordinates(1) + (i-1)*delta;
    yCoordinates(i) = cos(xCoordinates(i));
end

%Solve for b's
%Initialize A matrix to solve for b
A = zeros(n-1);
for i=1:n-1
    for j=1:i
        A(i,j) = (-1)^(i+j);
    end
end

%Initialize x vector
x = zeros(n-1,1);
x(1) = v;
for i=1:n-2
    x(i+1) = (2/delta)*(yCoordinates(i+1)-yCoordinates(i));
end

%Use forsub to get b's
b = forsub(A,x);

%Solve for c's
c = zeros(n-1,1); 
for i=1:n-1
    c(i) = ((yCoordinates(i+1)-yCoordinates(i))/(delta^2))-(b(i)/delta);
end

%Array of a is just a subset of y's
a = yCoordinates(1:n-1);

%%%%%%%%%%%%%%%%%%  call cosine function here  %%%%%%%%%%%%%%%%%

X = 250;

cosine(X,a,b,c)

X = -100;

cosine(X,a,b,c)


%%%%%%%%%%%%%%%%%%%%%    plot spline    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%number of points on which to plot. n = number of nodes
nplot  = (n-1)*19+1;

xplot = zeros(nplot,1);
yplot = zeros(nplot,1);

%spacing between plot points
nspace = (xCoordinates(n)-xCoordinates(1))/(nplot-1);

k = 0;
for i = 1:n-1
    
    for j = 1:19
        
        k = k+1;
        xplot(k) = xCoordinates(i) + (j-1)*nspace;
        yplot(k) = a(i) + b(i)*(xplot(k) - xCoordinates(i)) + c(i)*(xplot(k) - xCoordinates(i))^2;
        
    end
    
end

xplot(nplot) = xCoordinates(n);
yplot(nplot) = a(i) + b(i)*(xCoordinates(n) - xCoordinates(n-1)) + c(i)*(xCoordinates(n) - xCoordinates(n-1))^2;

plot(xplot,yplot)

figure

abserr = abs(yplot - cos(xplot));

plot(xplot,abserr)
