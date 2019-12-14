%Program for MATLAB Problem 2, Assignment 1
%Author: Gerardo E. Rodriguez, ger150030
%Approximates the constant pi using the MacLaurin series arctan(x)
format long e

%Instantiate variables for current result and previous result
%To be used during iteration
currentResult = 0;
currentResult = single(currentResult);
previousResult = 1;
previousResult = single(previousResult);

%Instantiate variable that keeps count of iterations
iterations = 0;

%Holds new term to be added to currentResult during iteration
newTerm = 0;
newTerm = single(newTerm);

%While loop that continues until there is no change in result
while (currentResult ~= previousResult)
    previousResult = currentResult;
    
    %Calculate the new term and add it to the result
    newTerm = 4*((-1)^iterations)/(2*iterations + 1); 
    currentResult = currentResult + newTerm;
    
    %Update number of iterations
    iterations = iterations + 1;
end

%Display final approximation
currentResult

%Calculate and display absolute error
absoluteError = abs(single(pi) - currentResult)

%Calculate and display relative error
relativeError = abs((single(pi) - currentResult)/single(pi))

%Display number of terms(iterations) needed to arrive at this approximation
iterations

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           ANSWER TO PROBLEM 2 PART B          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   The running sum eventually stops changing   %
%   due to the phenomenon known as swamping.    %
%   Swamping occurs when adding or subtracting  %
%   two numbers of very different size i.e the  %
%   difference in exponents is greater than the %
%   number of significant digits. In this       %
%   program swamping occurs when the new term   %
%   becomes too small when compared to the      %
%   current term as the new term is continually %
%   decreasing in size with each iteration.     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%