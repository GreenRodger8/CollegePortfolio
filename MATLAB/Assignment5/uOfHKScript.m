%Script for MATLAB Problem 2, Assignment 5
%Author: Gerardo E. Rodriguez, ger150030
%Approximate the integral of a function from a to b in order to find the
%probability that a random student will score between a% and b% for the
%course average

format long e

%Set endpoints
a = 0;
b = 69;

%Get approximation using Composite Trapezoids (10,000 panels)
trapezoidArea = trapfun(10000,a,b,'gradeDistribution');
trapezoidFailEstimate = round(trapezoidArea,2,'significant');
trapezoidArea
trapezoidFailEstimate

%Get approximation using Compositie Simpson's Rule (100 panels)
simpsonArea = simpfun(100,a,b,'gradeDistribution');
simpsonFailEstimate = round(trapezoidArea,2,'significant');
simpsonArea
simpsonFailEstimate

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Would not take this course due to high rate of failure %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%