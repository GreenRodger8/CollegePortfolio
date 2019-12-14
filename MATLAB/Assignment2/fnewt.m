%Function for MATLAB Problem 2, Assignment 2
%Author: Gerardo E. Rodriguez, ger150030
%Function that calculates f(I) = 500(1+I/12)^60 - 5000I - 500

%Defining function fnewt
function [f] = fnewt(I)

%Calculation
f = 500*((1+I/12)^60) - 5000*I - 500;