function [x] = backsub(U,y)

%Back-substitution
%accepts an nX1 vector y, an nXn upper triangular matrix U
%generates an nX1 solution vector x

[n,n] = size(U);

x = zeros(n,1);

x(n) = y(n)/U(n,n);

for i = n-1:-1:1 
    
    x(i) = y(i); 
    
    for j = i+1:n 
        
        x(i) = x(i) - U(i,j)*x(j); 
        
    end
    
    x(i) = x(i)/U(i,i); 
    
end
