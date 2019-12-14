%Script for MATLAB Problem 1, Assignment 3
%Author: Gerardo E. Rodriguez, ger150030
%Runs Gaussian Elimination with Partial Pivoting on A
%Then solves for x using forward substition then backwards substition

format long e

%Instantiating matrix A and vector b
A = [3.03 -12.1 14;
    -3.03 12.1 -7;
    6.11 -14.2 21];
b = [-119 120 -139]';

%Run matrix A through Gaussian Elimination with Partial Pivoting
[N,P] = gaelpp(A);

N

P

%Pivot solutions of b according to P
c = P*b

%Run matrix N for lower triangle with vector c through forsub 
%to obtain vector y for next part
y = forsub(N,c)

%Run matrix N for upper triangle with vector y through backsub
%to finally obtain vector x, the solution
x = backsub(N,y)

%Check to see if original Ax equals original b
A*x - b