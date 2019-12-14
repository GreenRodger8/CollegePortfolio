%Function for MATLAB Problem 2, Assignment 2
%Author: Gerardo E. Rodriguez, ger150030
%Function that calculates f'(I) = 2500(1+I/12)^59 - 5000

%Defining function fpnewt
function [f] = fpnewt(I)

%Calculation
f = 2500*((1+I/12)^59) - 5000;
