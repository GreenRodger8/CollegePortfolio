format long e

%matrix for circuit problem
A = [3.03 -12.1 14;
    -3.03 12.1 -7;
    6.11 -14.2 21];

%rhs for circuit problem - ' makes it a column
b = [-119 120 -139]';

%now, call function that does GE on A and b to get U and c (modified b)
[U,c,M] = gael(A,b);

U

c

%call the backsub function to find solution x
x = backsub(U,c)

%check to see if original Ax equals original b
A*x - b