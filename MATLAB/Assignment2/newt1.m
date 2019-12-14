%Program for MATLAB Problem 2, Assignment 2
%Author: Gerardo E. Rodriguez, ger150030

format long e

%Set error tolerance
TOL = .000001;

%Set maxinum number of iterations
MAXIT = 20;

%Initial guess
x = 2;
prev = 0;

%Keep track of the number of iterations
count = 0;

%Record iterates - a col vector of MAXIT length
cits = zeros(MAXIT,1);

%Evaluate function f and f' at initial guess x
f = fnewt(x);
fp = fpnewt(x);

%Stop loopin when error is less than TOL or count is greater than MAXIT
while abs(x-prev)/x >= TOL & count < MAXIT
   
    %Save previous x
    prev = x;
    
    %Get next iteration 
    x = prev - (f/fp);
    
    %Get new values for f and fp
    f = fnewt(x);
    fp = fpnewt(x);
    
    %stop if f'(x)=0
    if fp == 0
        break
    end
    
    %Update count
    count = count + 1;
    
    %Add new x to list of iterates
    cits(count) = x;
    
end

%Update count
count = count + 1;

%Save previous x
prev = x;    
    
%Get final estimation of x
x = prev - (f/fp)
    
%Add to vector of iterates
cits(count) = x;
    
%Display error estimate
error = abs(x-prev)/x   

%display vector of iterates
cits

%display number of iterates
count        
  