% GET_J
%
%   Function GET_J returnes the closed-loop control performance using the
%   LQR-based quality criterion.
%
%   J = get_J(x,u,Wx,Wu)
%
%   where;
%
%   J[class:double]  - is output value of quadratic criterion
%   x[class:double]  - is input vector of system states (column vectors)
%   u[class:double]  - is input matrix of system inputs (column vectors)
%   Wx[class:double] - is weighting matrix of system states
%   Wu[class:double] - is weighting matrix of system inputs
%
%   juraj.oravec@stuba.sk
%
%


function J = get_J(x,u,Wx,Wu)

Jx = 0;
Ju = 0;
for k = 1 : size(u,2)
    Jx(k,1) = x(:,k)'*Wx*x(:,k);
    Ju(k,1) = u(:,k)'*Wu*u(:,k);
end % for k

J = sum(Jx) + sum(Ju);

end % function
