% Function for MATLAB Problem 3, Assignment 5
% Editor: Gerardo E. Rodriguez, ger150030
% Computes approximation to definite integral 
% Inputs: Matlab inline function specifying integrand f, 
%    a,b integration interval, n=number of rows
% Output: Romberg tableau r

function r=rombergmod(f,a,b,error)

%Set maximum number of rows
n = 100;

h=(b-a)./(2.^(0:n-1));
fa = feval(f,a);
fb = feval(f,b);
r(1,1)=(b-a)*(fa+fb)/2;

absError = error+1; %to pass at least once through loop
j = 2;
while absError >= error && j <= n
  
  subtotal = 0;
  for i=1:2^(j-2)
    fmid = feval(f,a+(2*i-1)*h(j));
    subtotal = subtotal + fmid;
  end
  
  %Generates rows here
  r(j,1) = r(j-1,1)/2+h(j)*subtotal;
  for k=2:j
    r(j,k) = (4^(k-1)*r(j,k-1)-r(j-1,k-1))/(4^(k-1)-1);
  end
  
  %Compute absolute error between successive diagonal entries then
  %increment counter
  absError = abs(r(j-1,j-1)-r(j,j));
  j = j+1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% With testError = 0.5e-13, number of rows generated is 8, which means %
% that 8+1=9 number of integrand evaluations were used to compute the  %
% last diagonal element in the matrix                                  %
% The last diagonal element is of order of approximation 2j-2=2*8-2=14 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%