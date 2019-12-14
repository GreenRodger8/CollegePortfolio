%Script for MATLAB Problem 2, Assignment 3
%Author: Gerardo E. Rodriguez, ger150030
%Computes error measures for a Vandermonde matrix

format long e

%Part A, generating a Vandermonde matrix of size nxn
%Setting value of n
n = 10;

%Instantiate zeros matrix
A = zeros(n,n);

%Actual generation of Vandermonde matrix
for i = 1:n %Rows
    
    for j = 1:n %Columns
        
        A(i,j) = i^(j-1); 
        
    end 
    
end

A

%Part B, computing the solution xc
%Instantiating solution x
x = ones(n,1);

%Finding rhs b
b = A*x

%Finally computing xc
xc = A\b

%Part C, computing the relative backward error
%Computing absolute backward error
absBackErr = norm(A*xc - b);

%Norm of b
normB = norm(b);

%Finally computing relative backward error
relBackErr = absBackErr/normB

%Part D, computing an upperbound for the relative forward error
%Compute condition number
condA = cond(A);

%Finally compute upperbound for relative forward error
forErrUppBound = condA*relBackErr

%Part E, compute relative forward err
%Computing absolute forward error
absForErr = norm(x - xc);

%Norm of x
normX = norm(x);

%Finally compute relative forward error
relForErr = absForErr/normX

%Part F, discover how many digits can be trusted
%Computer number of sigfigs from absolute exponent of relForErr
sigFigs = ceil(abs(log10(forErrUppBound)))