%Script for MATLAB Problem 1, Assignment 6
%Author: Gerardo E. Rodriguez, ger150030
%Implements 3rd-order Euler/Taylor series method to approximate solutions

format long e

%Set number of steps, n
%n+1 points will be approximated, including endpoints
n = 10000;

%Set endpoints
a = 0;
b = 4;

%Set initial y condition
yInitial = 100;

%Set w(1) to initial condition
w = zeros(n+1,1);
w(1) = yInitial;

%Determine step size for n steps from a to b
h = (b - a)/n;

%Produce array of times t
time = zeros(n+1,1);
for i=1:n+1
    time(i) = a + h*(i-1);
end
time

%Approximate n number of y values from Taylor series
for i=1:n
    currentT = time(i);
    denominator = currentT - 5;
    w(i+1) = w(i) + (h)*(200 + w(i)/denominator) + (h*h/2)*(200/denominator) - (h*h*h/6)*(200/(denominator*denominator));
end

%Compute actual value of y
y = zeros(n+1,1);
y(1) = yInitial;
for i=2:n+1
    currentT = time(i);
    y(i) = 20*(5-currentT)*(10*log(5/(5-currentT))+1);
end

%Compute absolute global error value for each approximation
absoluteError = zeros(n+1,1);
for i=1:n+1
    absoluteError(i) = abs(w(i) - y(i));
end

%Plot absolute global error against time
figure
plot(time, absoluteError)

%Plot approximation solution vector against time
figure
plot(time, w)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% As n increases by a factor of 10^1, the maximum global error decreases %
% by a factor of 10^3, which makes sense as this is a third-order O(h^3) %
% Taylor series approximation                                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
