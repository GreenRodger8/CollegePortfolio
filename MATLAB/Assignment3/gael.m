function [A,b,M] = gael(A,b)

%Gaussian elimination
%inputs: 
%nXn matrix A, and and nX1 vector b
%outputs: 
%nXn matrix m of multipliers
%nXn upper triangular matrix A
%nX1 vector b

%get n
[n,n] = size(A);

%set up matrix of zeros that will store multipliers
M = zeros(n,n);

%Gaussian elimination
for j = 1:n-1 %j is pivot row
    
    if A(j,j) == 0 %avoid div. by 0
            break
    end
    
    for i = j+1:n %elim. col. j from row i = j+1 to i = n
        
        M(i,j) = A(i,j)/A(j,j); %multiplier to elim. A(i,j), store in matrix m
        
        
        for k = j+1:n % add mult of row j to row i
            
            A(i,k) = A(i,k) - M(i,j)*A(j,k); 
            
        end
        
        b(i) = b(i) - M(i,j)*b(j); %add mult. of row j to row i
        
    end
    
end