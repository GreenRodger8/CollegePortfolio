function [y] = forsub(L,b)

%Forward-substitution
%accepts an nX1 vector b, an nXn lower triangular matrix L
%generates an nX1 solution vector y

n = size(b,1);

y = zeros(n,1);

y(1) = b(1);

for i = 2:n 
    
    y(i) = b(i);
    
    for j = 1:i-1 
        
        y(i) = y(i) - L(i,j)*y(j); 
        
    end 
    
end
