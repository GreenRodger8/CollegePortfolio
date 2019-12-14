%Script for MATLAB Problem 3, Assignment 3
%Editor: Gerardo E. Rodriguez, ger150030
%Use multidimensional Newton's method in order to solve the equation
%p = k1*e^(k2*r)+k3*r

format long e

%MAXIT
MAXIT = 10000000;

%relative error tolerance
TOL = .000001;

%initial guess; x is "current" iterate
x = [1 1 1]';

%store as previous iterate xp
xp = x;

%call function to generate right-hand-side, -f
negF = genrhs(x);

    
%call function to generate matrix, DF
DF = genmatrix(x);


%Use MATLAB function to do PA=LU factorization
[L,U,P] = lu(DF);
        
%Use our functions in elearning, forsub and backsub, as appropriate
%Adapted from previous work, gaelppscript.m
c = P*negF;
y = forsub(L,c);
x = backsub(U,y);
    
%x is the current iterate
%s is the difference between current and previous iterate
s = x-xp;
i = 0;
while norm(s)/norm(x) >= TOL && i < MAXIT  
    i = i + 1;
 
    %store previous iterate
    xp = x;
    
 
    %generate right-hand-side, -f
    negF = genrhs(x);
    
    
    %generate matrix, DF
    DF = genmatrix(x);

    %PA=LU factorization
    [L,U,P] = lu(DF);
        
    %Use our functions forsub and backsub as appropriate
    %Adapted from previous work, gaelppscript.m
    c = P*negF;
    y = forsub(L,c);
    x = backsub(U,y);
    
    %Recalculate s
    s = x-xp;
end

%display last iterate and relerr estimate
x

norm(s)/norm(x)

