%Script for MATLAB Problem 1, Assignment 5
%Author: Gerardo E. Rodriguez, ger150030
%Compute vector of absolute errors in estimating the double derivative 
%of cos(x) using a three-point centered difference formula at x = 2

format long e

%Initialize vector with n step-sizes of different magnitudes
n = 12;
stepSize = zeros(n,1);
stepSize(1) = 1/10;
for i=2:n
    stepSize(i) = stepSize(i-1)/10;
end

%Compute actual value of f''(x)
x = 2;
actualValue = -1*cos(x);

%Compute absolute error values for each step-size h
absoluteError = zeros(n,1);
for i=1:n
    h = stepSize(i);
    estimate = (cos(x-2*h)-2*cos(x)+cos(x+2*h))/(4*h*h);
    absoluteError(i) = abs(estimate - actualValue);
end

%Plot absolute errors against step-sizes
loglog(stepSize,absoluteError)

%Get minimum of absoute errors and its corresponding step-size h
[minimumError,minimumIndex] = min(absoluteError);
hAtMinError = stepSize(minimumIndex);
minimumError
hAtMinError

%Calculate theoretical h
epsilon = 10^-16;
max4Deriv = 1; %Fourth derivative of cos(x) is cos(x), whose max is 1
hTheoretical = (6*epsilon/max4Deriv)^(1/4);
hTheoretical

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% As h keeps getting smaller, the absolute error keeps increasing %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
